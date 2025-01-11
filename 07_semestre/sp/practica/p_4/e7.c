#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#include <omp.h>

#define COORDINATOR 0
#define MAX_THREADS 8
#define BLOCK_SIZE 32

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

int main(int argc, char *argv[])
{
    int provided, claimed;
    int i, j, k, numProcs, rank, n, stripSize, total_size, check = 1, row, col;
    double *a, *b, *c;
    MPI_Status status;
    double commTimes[4], maxCommTimes[4], minCommTimes[4], commTime, totalTime;

    if ((argc != 2) || ((n = atoi(argv[1])) <= 0))
    {
        printf("\nUsar: %s size \n  size: Dimension de la matriz\n", argv[0]);
        exit(1);
    }

    MPI_Init_thread(&argc, &argv, MPI_THREAD_MULTIPLE, &provided);

    MPI_Comm_size(MPI_COMM_WORLD, &numProcs);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    if (n % numProcs != 0)
    {
        printf("El tamaño de la matriz debe ser multiplo del numero de procesos.\n");
        exit(1);
    }

    stripSize = n / numProcs;
    total_size = n * n;

    if (rank == COORDINATOR)
    {
        a = (double *)malloc(sizeof(double) * n * n);
        c = (double *)malloc(sizeof(double) * n * n);
    }
    else
    {
        a = (double *)malloc(sizeof(double) * n * stripSize);
        c = (double *)malloc(sizeof(double) * n * stripSize);
    }

    b = (double *)malloc(sizeof(double) * n * n);

    if (rank == COORDINATOR)
    {
        for (i = 0; i < n; i++)
            for (j = 0; j < n; j++)
                a[i * n + j] = 1;
        for (i = 0; i < n; i++)
            for (j = 0; j < n; j++)
                b[i * n + j] = 1;
    }

    MPI_Barrier(MPI_COMM_WORLD);

    commTimes[0] = MPI_Wtime();

    MPI_Scatter(a, stripSize * n, MPI_DOUBLE, a, stripSize * n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);
    MPI_Bcast(b, n * n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);

    commTimes[1] = MPI_Wtime();

#pragma omp parallel for schedule(static) private(i, j, k, row, col)
    for (i = 0; i < stripSize; i += BLOCK_SIZE)
    {
        row = i * n;
        for (j = 0; j < n; j += BLOCK_SIZE)
        {
            col = j * n;
            for (k = 0; k < n; k += BLOCK_SIZE)
            {
                blkmul(&a[row + k], &b[col + k], &c[row + j], n, BLOCK_SIZE);
            }
        }
    }

    commTimes[2] = MPI_Wtime();

    MPI_Gather(c, n * stripSize, MPI_DOUBLE, c, n * stripSize, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);

    commTimes[3] = MPI_Wtime();

    MPI_Reduce(commTimes, minCommTimes, 4, MPI_DOUBLE, MPI_MIN, COORDINATOR, MPI_COMM_WORLD);
    MPI_Reduce(commTimes, maxCommTimes, 4, MPI_DOUBLE, MPI_MAX, COORDINATOR, MPI_COMM_WORLD);

    MPI_Finalize();

    if (rank == COORDINATOR)
    {
        for (i = 0; i < n; i++)
            for (j = 0; j < n; j++)
                check = check && (c[i * n + j] == n);

        if (check)
        {
            printf("Multiplicacion de matrices resultado correcto\n");
        }
        else
        {
            printf("Multiplicacion de matrices resultado erroneo\n");
        }

        totalTime = maxCommTimes[3] - minCommTimes[0];
        commTime = (maxCommTimes[1] - minCommTimes[0]) + (maxCommTimes[3] - minCommTimes[2]);

        printf("Multiplicacion de matrices (N=%d)\tTiempo total=%lf\tTiempo comunicacion=%lf\n", n, totalTime, commTime);
    }

    free(a);
    free(b);
    free(c);

    return 0;
}
