#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
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
    int sockfd, portno;
    struct sockaddr_in serv_addr;
    struct hostent *server;
    int exponent, buff_size, iteration;
    int send_bytes, rec_bytes, n;
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

    unsigned long send_hash = sdbm(send_buff, send_bytes);
    write(sockfd, &send_bytes, sizeof(send_bytes));
    write(sockfd, &send_hash, sizeof(send_hash));

    rec_bytes = 0;
    while (rec_bytes < buff_size)
    {
        n = read(sockfd, rec_buff + rec_bytes, buff_size - rec_bytes);
        if (n < 0)
        {
            error("ERROR reading from socket buffer");
        }
        rec_bytes += n;
    }

    int server_send_bytes;
    unsigned long server_send_hash;
    read(sockfd, &server_send_bytes, sizeof(server_send_bytes));
    read(sockfd, &server_send_hash, sizeof(server_send_hash));

    close(sockfd);

    int expected_value = rec_bytes == server_send_bytes && sdbm(rec_buff, rec_bytes) == server_send_hash;

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
