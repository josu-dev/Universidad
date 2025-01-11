#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#define MAX_BUFFER_SIZE 1000000 + 1 // +1 for the null terminator

void error(char *msg)
{
    perror(msg);
    exit(1);
}

void setup_buffers(int seed, char *buffer_send, char *buffer_reci, int buffer_size);

static unsigned long sdbm(unsigned char *str);

// precomputed hash table for server messages
unsigned long server_hash_table[6] = {
    3652826869364505693UL,
    5820215518419826150UL,
    10398846990348147623UL,
    12999012604981726211UL,
    2936681361451910436UL,
    17588486855662106889UL};

int main(int argc, char *argv[])
{
    int sockfd, portno, n;
    struct sockaddr_in serv_addr;
    struct hostent *server;
    int buffer_size = 0, iteration = 0, exponent = 0;
    int send_bytes = 0, rec_bytes = 0;
    double total_time;
    clock_t tick;
    char buffer_send[MAX_BUFFER_SIZE];
    char buffer_reci[MAX_BUFFER_SIZE];
    if (argc < 5)
    {
        fprintf(stderr, "usage %s hostname port exponent iteration\n", argv[0]);
        exit(1);
    }

    iteration = atoi(argv[4]);
    exponent = atoi(argv[3]);
    buffer_size = pow(10, exponent);
    setup_buffers(12, buffer_send, buffer_reci, buffer_size);
    portno = atoi(argv[2]);

    server = gethostbyname(argv[1]);
    if (server == NULL)
    {
        fprintf(stderr, "ERROR, no such host\n");
        exit(0);
    }

    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    // AF_INET - FAMILIA DEL PROTOCOLO - IPV4 PROTOCOLS INTERNET
    // SOCK_STREAM - TIPO DE SOCKET
    if (sockfd < 0)
    {
        error("ERROR opening socket");
    }

    bzero((char *)&serv_addr, sizeof(serv_addr)); // set all values to '\0'
    serv_addr.sin_family = AF_INET;

    bcopy((char *)server->h_addr,
          (char *)&serv_addr.sin_addr.s_addr,
          server->h_length); // copy server address to serv_addr
    serv_addr.sin_port = htons(portno);

    if (connect(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0)
    {
        error("ERROR connecting");
    }

    tick = clock();

    send_bytes = 0;
    while (send_bytes < buffer_size)
    {
        n = write(sockfd, buffer_send + send_bytes, buffer_size - send_bytes);
        if (n < 0)
        {
            error("ERROR writing to socket");
        }
        send_bytes += n;
    }

    rec_bytes = 0;
    while (rec_bytes < buffer_size)
    {
        n = read(sockfd, buffer_reci + rec_bytes, buffer_size - rec_bytes);
        if (n < 0)
        {
            error("ERROR reading from socket");
        }
        rec_bytes += n;
    }

    buffer_reci[rec_bytes] = '\0';

    total_time = ((double)clock() - tick) / CLOCKS_PER_SEC;

    close(sockfd);

    int expected_value = buffer_size == rec_bytes && sdbm(buffer_reci) == server_hash_table[exponent - 1];

    printf("%i,%i,%i,%s,%f\n", iteration, send_bytes, rec_bytes, expected_value ? "true" : "false", total_time);

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
