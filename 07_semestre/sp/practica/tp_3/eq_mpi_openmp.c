#include <stdio.h>
#include <stdlib.h>
#include <float.h>
#include <mpi.h>
#include <omp.h>

/*
    Program to compute the following expression:

    ((MaxA x MaxB - MinA x MinB) / (AvgA x AvgB)) x [A x B] + [C x D]

    Where:
    - A, B, C, D are square matrices of size N x N
*/

#define COORDINATOR 0
#define TIME_SIZE 6

void blkmul(double *ablk, double *bblk, double *cblk, int n, int block_size);

void init_matrix(double *matrix, int size, double value, int transpose);

int main(int argc, char *argv[])
{
    int n, block_size, procs_count, rank;
    MPI_Status status;
    int provided;

    if ((argc != 3) || ((n = atoi(argv[1])) <= 0) || ((block_size = atoi(argv[2])) <= 0))
    {
        printf("\nUsar: %s size block_size\n  size: Dimension de la matriz\n  block_size: Tamaño de bloque\n", argv[0]);
        exit(1);
    }

    MPI_Init_thread(&argc, &argv, MPI_THREAD_MULTIPLE, &provided);

    MPI_Comm_size(MPI_COMM_WORLD, &procs_count);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    if (n % procs_count != 0)
    {
        printf("Matrix size must be multiple of the number of processes.\n");
        exit(1);
    }

    double *A, *B, *C, *D, *R, *CD;
    int i, j, k, strip_size, check, row, col, total_size;
    double max_a, max_b, min_a, min_b, avg_a, avg_b, scalar;
    double max[2], max_local[2], min[2], min_local[2], avg[2], avg_local[2];
    double comm_times[TIME_SIZE], avg_comm_times[TIME_SIZE], comm_time, total_time;

    max_a = max_b = DBL_MIN;
    min_a = min_b = DBL_MAX;
    avg_a = avg_b = 0.0;

    total_size = n * n;
    strip_size = n / procs_count;

    if (rank == COORDINATOR)
    {
        A = (double *)malloc(sizeof(double) * n * n);
        C = (double *)malloc(sizeof(double) * n * n);
        R = (double *)malloc(sizeof(double) * n * n);
        CD = (double *)malloc(sizeof(double) * n * n);
    }
    else
    {
        A = (double *)malloc(sizeof(double) * n * strip_size);
        C = (double *)malloc(sizeof(double) * n * strip_size);
        R = (double *)malloc(sizeof(double) * n * strip_size);
        CD = (double *)malloc(sizeof(double) * n * strip_size);
    }

    B = (double *)malloc(sizeof(double) * n * n);
    D = (double *)malloc(sizeof(double) * n * n);

    if (rank == COORDINATOR)
    {
        printf("P: %d N: %d BS: %d\n", procs_count, n, block_size);
        init_matrix(A, n, 1, 0);
        init_matrix(B, n, 1, 1);
        init_matrix(C, n, 1, 0);
        init_matrix(D, n, 1, 1);
    }

    for (i = 0; i < n * strip_size; i++)
    {
        R[i] = 0;
    }
    for (i = 0; i < n * strip_size; i++)
    {
        CD[i] = 0;
    }

    MPI_Barrier(MPI_COMM_WORLD);

    comm_times[0] = MPI_Wtime();

    MPI_Scatter(A, strip_size * n, MPI_DOUBLE, A, strip_size * n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);
    MPI_Bcast(B, n * n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);
    MPI_Scatter(C, strip_size * n, MPI_DOUBLE, C, strip_size * n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);
    MPI_Bcast(D, n * n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);

    comm_times[1] = MPI_Wtime();

#pragma omp parallel private(i, j, k, row, col)
    {
        // computation of [A x B]
#pragma omp for schedule(static) nowait
        for (i = 0; i < strip_size; i += block_size)
        {
            row = i * n;
            for (j = 0; j < n; j += block_size)
            {
                col = j * n;
                for (k = 0; k < n; k += block_size)
                {
                    blkmul(&A[row + k], &B[col + k], &R[row + j], n, block_size);
                }
            }
        }

        // computation of [C x D]
#pragma omp for schedule(static) nowait
        for (i = 0; i < strip_size; i += block_size)
        {
            row = i * n;
            for (j = 0; j < n; j += block_size)
            {
                col = j * n;
                for (k = 0; k < n; k += block_size)
                {
                    blkmul(&C[row + k], &D[col + k], &CD[row + j], n, block_size);
                }
            }
        }

        // computation of MaxA, MinA, AvgA
#pragma omp for schedule(static) reduction(max : max_a) reduction(min : min_a) reduction(+ : avg_a)
        for (i = 0; i < n * strip_size; i++)
        {
            if (A[i] > max_a)
                max_a = A[i];
            if (A[i] < min_a)
                min_a = A[i];
            avg_a += A[i];
        }

        // computation of MaxB, MinB, AvgB
#pragma omp for schedule(static) reduction(max : max_b) reduction(min : min_b) reduction(+ : avg_b)
        for (i = 0; i < n * strip_size; i++)
        {
            if (B[i] > max_b)
                max_b = B[i];
            if (B[i] < min_b)
                min_b = B[i];
            avg_b += B[i];
        }

#pragma omp single
        {
            max_local[0] = max_a;
            max_local[1] = max_b;
            min_local[0] = min_a;
            min_local[1] = min_b;
            avg_local[0] = avg_a;
            avg_local[1] = avg_b;
            comm_times[2] = MPI_Wtime();

            MPI_Allreduce(max_local, max, 2, MPI_DOUBLE, MPI_MAX, MPI_COMM_WORLD);
            MPI_Allreduce(min_local, min, 2, MPI_DOUBLE, MPI_MIN, MPI_COMM_WORLD);
            MPI_Allreduce(avg_local, avg, 2, MPI_DOUBLE, MPI_SUM, MPI_COMM_WORLD);

            comm_times[3] = MPI_Wtime();
            // computation of (MaxA x MaxB - MinA x MinB) / (AvgA x AvgB)
            scalar = (max[0] * max[1] - min[0] * min[1]) / (avg[0] * avg[1]);
        }

        // computation of R = scalar * R + CD
#pragma omp for schedule(static)
        for (i = 0; i < n * strip_size; i++)
        {
            R[i] = scalar * R[i] + CD[i];
        }
    }

    comm_times[4] = MPI_Wtime();

    MPI_Gather(R, n * strip_size, MPI_DOUBLE, R, n * strip_size, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);

    comm_times[5] = MPI_Wtime();

    // results
    MPI_Reduce(comm_times, avg_comm_times, TIME_SIZE, MPI_DOUBLE, MPI_SUM, COORDINATOR, MPI_COMM_WORLD);

    if (rank == COORDINATOR)
    {
        total_time = comm_times[TIME_SIZE - 1] - comm_times[0];

        for (i = 0; i < TIME_SIZE; i++)
        {
            avg_comm_times[i] /= procs_count;
        }

        comm_time = 0;
        for (i = 0; i < TIME_SIZE; i += 2)
        {
            comm_time += avg_comm_times[i + 1] - avg_comm_times[i];
        }

        check = 1;
        for (i = 0; i < n * n; i++)
        {
            check = check && (R[i] == n);
        }

        printf("T: %f\n", total_time);
        printf("C: %f\n", comm_time);
        printf("R: %s\n", check ? "OK" : "ERROR");
    }

    free(A);
    free(B);
    free(C);
    free(D);
    free(R);
    free(CD);

    MPI_Finalize();

    return 0;
}

void blkmul(double *ablk, double *bblk, double *cblk, int n, int block_size)
{
    int i, j, k, row, col;
    double sum;

    for (i = 0; i < block_size; i++)
    {
        row = i * n;
        for (j = 0; j < block_size; j++)
        {
            col = j * n;
            sum = 0;
            for (k = 0; k < block_size; k++)
            {
                sum += ablk[row + k] * bblk[col + k];
            }
            cblk[i * n + j] += sum;
        }
    }
}

void init_matrix(double *matrix, int size, double value, int transpose)
{
    int i, j;
    if (transpose)
    {
        for (i = 0; i < size; i++)
        {
            for (j = 0; j < size; j++)
            {
                matrix[j * size + i] = value;
            }
        }
        return;
    }

    for (i = 0; i < size; i++)
    {
        for (j = 0; j < size; j++)
        {
            matrix[i * size + j] = value;
        }
    }
}
