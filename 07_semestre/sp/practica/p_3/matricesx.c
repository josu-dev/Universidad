#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

/* Time in seconds from some point in the past */
double dwalltime();

int main(int argc, char *argv[])
{
    double *A, *B, *C;
    int i, j, k, N;
    int check = 1;
    double timetick;

    // Controla los argumentos al programa
    if (argc < 3)
    {
        printf("\n Faltan argumentos:: N dimension de la matriz, T cantidad de threads \n");
        return 0;
    }
    N = atoi(argv[1]);
    int numThreads = atoi(argv[2]);
    omp_set_num_threads(numThreads);

    // Aloca memoria para las matrices
    A = (double *)malloc(sizeof(double) * N * N);
    B = (double *)malloc(sizeof(double) * N * N);
    C = (double *)malloc(sizeof(double) * N * N);

    // Inicializa las matrices A y B en 1, el resultado sera una matriz con todos sus valores en N
    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
        {
            A[i * N + j] = 1;
            B[i + j * N] = 1;
        }
    }

    timetick = dwalltime();
    // Realiza la multiplicacion 1
    // int sum;
    // #pragma omp parallel for shared(A, B, C) private(i, j, sum, k)
    // for (i = 0; i < N; i++)
    // {
    //     for (j = 0; j < N; j++)
    //     {
    //         sum = 0;
    //         for (k = 0; k < N; k++)
    //         {
    //             sum = sum + A[i * N + k] * B[k + j * N];
    //         }
    //         C[i * N + j] = sum;
    //     }
    // }
    // 512 2
    // Tiempo en segundos 0.502231 
    // 512 4
    // Tiempo en segundos 0.253064 
    // 512 6
    // Tiempo en segundos 0.171111 
    // 512 8
    // Tiempo en segundos 0.130557 
    // 512 10
    // Tiempo en segundos 0.105975 
    // 512 12
    // Tiempo en segundos 0.088214 
    // 512 14
    // Tiempo en segundos 0.079437 
    // 512 16
    // Tiempo en segundos 0.079904
    int sum;
    for (i = 0; i < N; i++)
    {
        #pragma omp parallel for shared(A, B, C) private(j, sum, k)
        for (j = 0; j < N; j++)
        {
            sum = 0;
            for (k = 0; k < N; k++)
            {
                sum = sum + A[i * N + k] * B[k + j * N];
            }
            C[i * N + j] = sum;
        }
    }
    // 512 2
    // Tiempo en segundos 0.503944 
    // 512 4
    // Tiempo en segundos 0.255818 
    // 512 6
    // Tiempo en segundos 0.189393 
    // 512 8
    // Tiempo en segundos 0.139656 
    // 512 10
    // Tiempo en segundos 0.119647 
    // 512 12
    // Tiempo en segundos 0.103229 
    // 512 14
    // Tiempo en segundos 0.101074 
    // 512 16
    // Tiempo en segundos 0.126835 
    printf("Tiempo en segundos %f \n", dwalltime() - timetick);

    // Verifica el resultado
    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
        {
            check = check && (C[i * N + j] == N);
        }
    }

    if (check)
    {
        printf("Multiplicacion de matrices resultado correcto\n");
    }
    else
    {
        printf("Multiplicacion de matrices resultado erroneo\n");
    }

    free(A);
    free(B);
    free(C);
    return (0);
}

/*****************************************************************/

#include <sys/time.h>

double dwalltime()
{
    double sec;
    struct timeval tv;

    gettimeofday(&tv, NULL);
    sec = tv.tv_sec + tv.tv_usec / 1000000.0;
    return sec;
}
