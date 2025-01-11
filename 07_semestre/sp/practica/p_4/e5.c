#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

#define COORDINATOR 0

int main(int argc, char *argv[])
{
    int i, j, k, numProcs, rank, n, stripSize, check = 1;
    double *a, *b, *c, *d, *e, *f, *r;
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
        a = (double *)malloc(sizeof(double) * n * n);
        c = (double *)malloc(sizeof(double) * n * n);
        e = (double *)malloc(sizeof(double) * n * n);
        r = (double *)malloc(sizeof(double) * n * n);
    }
    else
    {
        a = (double *)malloc(sizeof(double) * n * stripSize);
        c = (double *)malloc(sizeof(double) * n * stripSize);
        e = (double *)malloc(sizeof(double) * n * stripSize);
        r = (double *)malloc(sizeof(double) * n * stripSize);
    }

    b = (double *)malloc(sizeof(double) * n * n);
    d = (double *)malloc(sizeof(double) * n * n);
    f = (double *)malloc(sizeof(double) * n * n);

    // inicializar datos
    if (rank == COORDINATOR)
    {
        for (i = 0; i < n; i++)
            for (j = 0; j < n; j++)
                a[i * n + j] = 1;
        for (i = 0; i < n; i++)
            for (j = 0; j < n; j++)
                b[i * n + j] = 1;
        for (i = 0; i < n; i++)
            for (j = 0; j < n; j++)
                c[i * n + j] = 1;
        for (i = 0; i < n; i++)
            for (j = 0; j < n; j++)
                d[i * n + j] = 1;
        for (i = 0; i < n; i++)
            for (j = 0; j < n; j++)
                e[i * n + j] = 1;
        for (i = 0; i < n; i++)
            for (j = 0; j < n; j++)
                f[i * n + j] = 1;
        for (i = 0; i < n; i++)
            for (j = 0; j < n; j++)
                r[i * n + j] = 0;
    }
    else
    {
        for (i = 0; i < n * stripSize; i++)
            r[i] = 0;
    }

    MPI_Barrier(MPI_COMM_WORLD);

    commTimes[0] = MPI_Wtime();

    MPI_Scatter(a, stripSize * n, MPI_DOUBLE, a, stripSize * n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);
    MPI_Bcast(b, n * n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);
    MPI_Scatter(c, stripSize * n, MPI_DOUBLE, c, stripSize * n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);
    MPI_Bcast(d, n * n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);
    MPI_Scatter(e, stripSize * n, MPI_DOUBLE, e, stripSize * n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);
    MPI_Bcast(f, n * n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);

    commTimes[1] = MPI_Wtime();

    /* computar multiplicacion parcial */
    for (i = 0; i < stripSize; i++)
    {
        for (j = 0; j < n; j++)
        {
            for (k = 0; k < n; k++)
            {
                r[i * n + j] += (a[i * n + k] * b[j * n + k]);
            }
        }
    }
    for (i = 0; i < stripSize; i++)
    {
        for (j = 0; j < n; j++)
        {
            for (k = 0; k < n; k++)
            {
                r[i * n + j] += (c[i * n + k] * d[j * n + k]);
            }
        }
    }
    for (i = 0; i < stripSize; i++)
    {
        for (j = 0; j < n; j++)
        {
            for (k = 0; k < n; k++)
            {
                r[i * n + j] += (e[i * n + k] * f[j * n + k]);
            }
        }
    }

    commTimes[2] = MPI_Wtime();

    MPI_Gather(r, n * stripSize, MPI_DOUBLE, r, n * stripSize, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);

    commTimes[3] = MPI_Wtime();

    MPI_Reduce(commTimes, minCommTimes, 4, MPI_DOUBLE, MPI_MIN, COORDINATOR, MPI_COMM_WORLD);
    MPI_Reduce(commTimes, maxCommTimes, 4, MPI_DOUBLE, MPI_MAX, COORDINATOR, MPI_COMM_WORLD);

    MPI_Finalize();

    if (rank == COORDINATOR)
    {

        // Check results
        for (i = 0; i < n; i++)
            for (j = 0; j < n; j++)
                check = check && (r[i * n + j] == (n * 3));

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
    free(d);
    free(e);
    free(f);
    free(r);

    return 0;
}
