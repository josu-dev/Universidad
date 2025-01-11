#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "mpi.h"

#define MASTER 0

int main(int argc, char *argv[])
{
    int myrank;
    int size;
    int dest;
    int source;
    int tag = 0;
    MPI_Status status;
    char message[BUFSIZ];

    MPI_Init(&argc, &argv);

    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &myrank);

    if (myrank == MASTER)
    {
        printf("MASTER rank %d\n", myrank);
        sprintf(message, "hi from MASTER rank %d\n", myrank);
        dest = MASTER;
        MPI_Send(message, strlen(message) + 1, MPI_CHAR, 1, tag, MPI_COMM_WORLD);
        MPI_Recv(message, BUFSIZ, MPI_CHAR, size - 1, tag, MPI_COMM_WORLD, &status);
        printf("(MASTER rank %d) Mensaje recibido: %s\n", myrank, message);
    }
    else
    {
        printf("SLAVE rank %d\n", myrank);
        MPI_Recv(message, BUFSIZ, MPI_CHAR, myrank - 1, tag, MPI_COMM_WORLD, &status);
        printf("(SLAVE rank %d) Mensaje recibido: %s\n", myrank, message);

        sprintf(message, "hi from SLAVE rank %d\n", myrank);
        MPI_Send(message, strlen(message) + 1, MPI_CHAR, (myrank + 1) % size, tag, MPI_COMM_WORLD);
    }

    MPI_Finalize();

    return EXIT_SUCCESS;
}
