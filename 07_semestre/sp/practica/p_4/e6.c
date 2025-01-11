#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

#define COORDINATOR 0

int main(int argc, char *argv[])
{
    int i, numProcs, rank, n, stripSize, check = 1;
    double *a, local_min, local_max, local_avg, min, max, avg;
    MPI_Status status;
    double commTimes[4], maxCommTimes[4], minCommTimes[4], commTime, totalTime;

    /* Lee par�metros de la l�nea de comando */
    if ((argc != 2) || ((n = atoi(argv[1])) <= 0))
    {
        printf("\nUsar: %s size \n  size: Dimension de la matriz y el vector\n", argv[0]);
        exit(1);
    }

    MPI_Init(&argc, &argv);

    MPI_Comm_size(MPI_COMM_WORLD, &numProcs);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    if (n % numProcs != 0)
    {
        printf("El tama�o de la matriz debe ser multiplo del numero de procesos.\n");
        exit(1);
    }

    // calcular porcion de cada worker
    stripSize = n / numProcs;

    // Reservar memoria
    if (rank == COORDINATOR)
    {
        a = (double *)malloc(sizeof(double) * n);
    }
    else
    {
        a = (double *)malloc(sizeof(double) * stripSize);
    }

    // inicializar datos
    if (rank == COORDINATOR)
    {
        for (i = 0; i < n; i++)
                a[i] = i * i;
    }

    local_min = a[0];
    local_max = a[0];
    local_avg = 0;

    MPI_Barrier(MPI_COMM_WORLD);

    commTimes[0] = MPI_Wtime();

    MPI_Scatter(a, stripSize, MPI_DOUBLE, a, stripSize, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);

    commTimes[1] = MPI_Wtime();

    for (i = 0; i < stripSize; i++)
    {
        if (a[i] < local_min)
        {
            local_min = a[i];
        }
        if (a[i] > local_max)
        {
            local_max = a[i];
        }
        local_avg += a[i];
    }

    local_avg = local_avg / n;

    commTimes[2] = MPI_Wtime();

    MPI_Reduce(&local_min, &min, 1, MPI_DOUBLE, MPI_MIN, COORDINATOR, MPI_COMM_WORLD);
    MPI_Reduce(&local_max, &max, 1, MPI_DOUBLE, MPI_MAX, COORDINATOR, MPI_COMM_WORLD);
    MPI_Reduce(&local_avg, &avg, 1, MPI_DOUBLE, MPI_SUM, COORDINATOR, MPI_COMM_WORLD);

    commTimes[3] = MPI_Wtime();

    MPI_Reduce(commTimes, minCommTimes, 4, MPI_DOUBLE, MPI_MIN, COORDINATOR, MPI_COMM_WORLD);
    MPI_Reduce(commTimes, maxCommTimes, 4, MPI_DOUBLE, MPI_MAX, COORDINATOR, MPI_COMM_WORLD);

    MPI_Finalize();

    if (rank == COORDINATOR)
    {

        // Check results
        check = (min == 0) && (max == ((n - 1) * (n - 1)));
        local_avg = 0;
        for (i = 0; i < n; i++)
        {
            local_avg += a[i];
        }
        check = check && ((local_avg / n) == avg);

        if (check)
        {
            printf("Correcto\n");
        }
        else
        {
            printf("Erroneo\n");
        }

        totalTime = maxCommTimes[3] - minCommTimes[0];
        commTime = (maxCommTimes[1] - minCommTimes[0]) + (maxCommTimes[3] - minCommTimes[2]);

        printf("Analisis de vector (N=%d)\tTiempo total=%lf\tTiempo comunicacion=%lf\n", n, totalTime, commTime);
    }

    free(a);

    return 0;
}
