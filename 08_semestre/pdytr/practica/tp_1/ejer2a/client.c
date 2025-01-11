#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
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
    int sockfd, portno;
    struct sockaddr_in serv_addr;
    struct hostent *server;
    int exponent, buff_size, iteration;
    int send_bytes, rec_bytes;
    char send_buff[MAX_BUFF_SIZE];
    char rec_buff[MAX_BUFF_SIZE];
    if (argc < 5)
    {
        fprintf(stderr, "usage %s hostname port exponent iteration\n", argv[0]);
        exit(1);
    }

    iteration = atoi(argv[4]);
    exponent = atoi(argv[3]);
    buff_size = pow(10, exponent);
    setup_buffers(12, send_buff, rec_buff, buff_size);
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

    send_bytes = write(sockfd, send_buff, buff_size);
    if (send_bytes < 0)
    {
        error("ERROR writing to socket");
    }

    rec_bytes = read(sockfd, rec_buff, buff_size);
    if (rec_bytes < 0)
    {
        error("ERROR reading from socket");
    }

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
