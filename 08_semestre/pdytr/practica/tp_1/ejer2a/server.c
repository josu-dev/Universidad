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

#define MAX_BUFF_SIZE 1000000

void error(char *msg)
{
    perror(msg);
    exit(1);
}

void setup_buffers(int seed, char *send_buff, char *rec_buff, int buff_size);

int main(int argc, char *argv[])
{
    int sockfd, newsockfd, portno;
    socklen_t clilen;
    struct sockaddr_in serv_addr, cli_addr;
    int exponent, buff_size, iteration;
    int send_bytes, rec_bytes;
    char send_buff[MAX_BUFF_SIZE];
    char rec_buff[MAX_BUFF_SIZE];

    if (argc < 4)
    {
        fprintf(stderr, "ERROR, no port provided\n");
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

    rec_bytes = read(newsockfd, rec_buff, buff_size);
    if (rec_bytes < 0)
    {
        error("ERROR reading from socket");
    }

    send_bytes = write(newsockfd, send_buff, buff_size);
    if (send_bytes < 0)
    {
        error("ERROR writing to socket");
    }

    close(newsockfd);
    close(sockfd);

    printf("%i,%i,%i\n", iteration, send_bytes, rec_bytes);

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
