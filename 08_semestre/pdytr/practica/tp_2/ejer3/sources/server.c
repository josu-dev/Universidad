/* A simple server in the internet domain using TCP
   The port number is passed as an argument */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <math.h>

#define MAX_BUFFER_SIZE 1000000 + 1 // +1 for the null terminator

void error(char *msg)
{
    perror(msg);
    exit(1);
}

void setup_buffers(int seed, char *send_buffer, char *rec_buffer, int buffer_size);

static unsigned long sdbm(unsigned char *str);

// precomputed hash table for client messages
unsigned long client_hash_table[6] = {
    5711497472162902172UL,
    1016675566424836794UL,
    17031609726658774327UL,
    14249887054720651773UL,
    1366483656743831765UL,
    14865125931119885912UL};

int main(int argc, char *argv[])
{
    int sockfd, newsockfd, portno, n;
    socklen_t clilen;
    struct sockaddr_in serv_addr, cli_addr;
    int buffer_size = 0, iteration = 0, exponent = 0;
    int send_bytes = 0, rec_bytes = 0;
    char send_buffer[MAX_BUFFER_SIZE];
    char rec_buffer[MAX_BUFFER_SIZE];
    if (argc < 3)
    {
        fprintf(stderr, "usage %s port exponent iteration\n", argv[0]);
        exit(1);
    }

    iteration = atoi(argv[3]);
    exponent = atoi(argv[2]);
    buffer_size = pow(10, exponent);
    setup_buffers(0, send_buffer, rec_buffer, buffer_size);

    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    // AF_INET - FAMILIA DEL PROTOCOLO - IPV4 PROTOCOLS INTERNET
    // SOCK_STREAM - TIPO DE SOCKET
    if (sockfd < 0)
    {
        error("ERROR opening socket");
    }

    bzero((char *)&serv_addr, sizeof(serv_addr));

    portno = atoi(argv[1]);
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = INADDR_ANY;
    serv_addr.sin_port = htons(portno);

    // VINCULA EL FILE DESCRIPTOR CON LA DIRECCIÓN Y EL PUERTO
    if (bind(sockfd, (struct sockaddr *)&serv_addr,
             sizeof(serv_addr)) < 0)
    {
        error("ERROR on binding");
    }

    listen(sockfd, 5); // makes the socket passive and sets the maximum number of connections to 5

    clilen = sizeof(cli_addr);

    newsockfd = accept(sockfd,
                       (struct sockaddr *)&cli_addr,
                       &clilen);
    if (newsockfd < 0)
    {
        error("ERROR on accept");
    }

    rec_bytes = 0;
    while (rec_bytes < buffer_size)
    {
        n = read(newsockfd, rec_buffer + rec_bytes, buffer_size - rec_bytes);
        if (n < 0)
        {
            error("ERROR reading from socket");
        }

        rec_bytes += n;
    }

    rec_buffer[rec_bytes] = '\0';

    send_bytes = 0;
    while (send_bytes < buffer_size)
    {
        n = write(newsockfd, send_buffer + send_bytes, buffer_size - send_bytes);
        if (n < 0)
        {
            error("ERROR writing to socket");
        }
        send_bytes += n;
    }

    close(newsockfd);
    close(sockfd);

    int expected_value = buffer_size == rec_bytes && sdbm(rec_buffer) == client_hash_table[exponent - 1];

    printf("%i,%i,%i,%s,0\n", iteration, send_bytes, rec_bytes, expected_value ? "true" : "false");

    return 0;
}

void setup_buffers(int seed, char *buffer_send, char *buffer_reci, int buffer_size)
{
    srand(seed);
    for (int i = 0; i < buffer_size; i++)
    {
        buffer_send[i] = (rand() % 255) + 1;
    }
    memset(buffer_reci, '0', buffer_size);
}

static unsigned long sdbm(unsigned char *str)
{
    unsigned long hash = 0;
    int c;

    while (c = *str++)
        hash = c + (hash << 6) + (hash << 16) - hash;
    return hash;
}

void precompute_sbdm(int exponent, int seed)
{
    int buffer_size = pow(10, exponent);
    char buffer_send[buffer_size + 1];
    char buffer_reci[buffer_size + 1];
    setup_buffers(12, buffer_send, buffer_reci, buffer_size);
    buffer_send[buffer_size] = '\0';
    printf("Buffer size: %i sbdm: %lu\n", buffer_size, sdbm(buffer_send));
    exit(0);
}
