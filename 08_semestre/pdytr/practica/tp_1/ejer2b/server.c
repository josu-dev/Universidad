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

#define MAX_BUFF_SIZE 1000000 + 1 // +1 for the null terminator

void error(char *msg)
{
    perror(msg);
    exit(1);
}

void setup_buffers(int seed, char *send_buff, char *rec_buff, int buff_size);

static unsigned long sdbm(unsigned char *str, int len);

int main(int argc, char *argv[])
{
    int sockfd, newsockfd, portno;
    socklen_t clilen;
    struct sockaddr_in serv_addr, cli_addr;
    int exponent, buff_size, iteration;
    int send_bytes, rec_bytes, n;
    char send_buff[MAX_BUFF_SIZE];
    char rec_buff[MAX_BUFF_SIZE];

    if (argc < 4)
    {
        fprintf(stderr, "usage %s port exponent iteration\n", argv[0]);
        exit(1);
    }

    iteration = atoi(argv[3]);
    exponent = atoi(argv[2]);
    buff_size = pow(10, exponent);
    setup_buffers(0, send_buff, rec_buff, buff_size);

    // CREA EL FILE DESCRIPTOR DEL SOCKET PARA LA CONEXIÓN
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    // AF_INET - FAMILIA DEL PROTOCOLO - IPV4 PROTOCOLS INTERNET
    // SOCK_STREAM - TIPO DE SOCKET
    if (sockfd < 0)
    {
        {
            error("ERROR opening socket");
        }
    }

    bzero((char *)&serv_addr, sizeof(serv_addr));

    portno = atoi(argv[1]);
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = INADDR_ANY;
    serv_addr.sin_port = htons(portno);

    if (bind(sockfd, (struct sockaddr *)&serv_addr,
             sizeof(serv_addr)) < 0)
        error("ERROR on binding");

    listen(sockfd, 5);

    clilen = sizeof(cli_addr);

    newsockfd = accept(sockfd,
                       (struct sockaddr *)&cli_addr,
                       &clilen);
    if (newsockfd < 0)
    {
        error("ERROR on accept");
    }

    rec_bytes = 0;
    while (rec_bytes < buff_size)
    {
        n = read(newsockfd, rec_buff + rec_bytes, buff_size - rec_bytes);
        if (n < 0)
        {
            error("ERROR reading from socket buffer");
        }
        rec_bytes += n;
    }

    int client_send_bytes;
    unsigned long client_send_hash;
    read(newsockfd, &client_send_bytes, sizeof(client_send_bytes));
    read(newsockfd, &client_send_hash, sizeof(client_send_hash));

    send_bytes = write(newsockfd, send_buff, buff_size);
    if (send_bytes < 0)
    {
        error("ERROR writing to socket buffer");
    }

    unsigned long send_hash = sdbm(send_buff, send_bytes);
    write(newsockfd, &send_bytes, sizeof(send_bytes));
    write(newsockfd, &send_hash, sizeof(send_hash));

    close(newsockfd);
    close(sockfd);

    int expected_value = rec_bytes == client_send_bytes && sdbm(rec_buff, rec_bytes) == client_send_hash;

    printf("%i,%i,%i,%s\n", iteration, send_bytes, rec_bytes, expected_value ? "true" : "false");

    return 0;
}

void setup_buffers(int seed, char *send_buff, char *rec_buff, int buff_size)
{
    srand(seed);
    for (int i = 0; i < buff_size; i++)
    {
        send_buff[i] = (rand() % 255) + 1;
    }
    memset(rec_buff, '0', buff_size);
}

static unsigned long sdbm(unsigned char *str, int len)
{
    unsigned long hash = 0;
    int c;
    unsigned char *end_dir = str + len;

    while (str < end_dir)
    {
        c = *str++;
        hash = c + (hash << 6) + (hash << 16) - hash;
    }
    return hash;
}
