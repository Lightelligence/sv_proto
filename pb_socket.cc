#include <iostream>
#include <stdlib.h>

#include <sys/socket.h> 
#include <sys/un.h>
#include <unistd.h> 
#include <string.h> 

#include "external/xcelium/svdpi.h"

using namespace std;

// global socket file descriptor
int pbps_sock;

extern "C" int socket_initialize(const char *socket_name) {
  struct sockaddr_un saddr;
  saddr.sun_family = AF_UNIX;
  strncpy (saddr.sun_path, socket_name, sizeof(saddr.sun_path));
  saddr.sun_path[sizeof (saddr.sun_path) - 1] = '\0';

  if ((pbps_sock = socket(AF_UNIX, SOCK_STREAM, 0)) < 0) { 
    printf("Failed to create socket handle\n"); 
    return -1; 
  }

  if (connect(pbps_sock, (struct sockaddr *)&saddr, sizeof(saddr)) < 0) { 
    printf("\nConnection to socket %s Failed \n", socket_name);
    return -1; 
  } 
  printf("Socket %s connected successfully\n", socket_name);
  return 0;
}

extern "C" int socket_write_bytes(const svOpenArrayHandle h) {
  cout << "FIXME remove. In socket_write_bytes" << endl;
  if (svDimensions(h) != 1) {
    cout << "FIXME assertion. multidimensional data sent to socket_write_bytes" << endl;
  }
  if (svSize(h, 0) != 8) {
    cout << "FIXME assertion. Expected data structure to be bytes" << endl;
  }
  unsigned int data_size = svSize(h, 1);
  // cout << "Data size: " << data_size << endl;

  unsigned char* raw_array = (unsigned char*)svGetArrayPtr(h);
  write(pbps_sock, raw_array, data_size);
  return 0;
}

extern "C" int socket_read_bytes(svOpenArrayHandle h) {
  if (svDimensions(h) != 1) {
    cout << "FIXME assertion. multidimensional data sent to socket_write_bytes" << endl;
  }
  if (svSize(h, 0) != 8) {
    cout << "FIXME assertion. Expected data structure to be bytes" << endl;
  }

  unsigned int data_size = svSize(h, 1);
  cout << "read data size: " << data_size << endl;

  unsigned char* raw_array = (unsigned char*)svGetArrayPtr(h);

  read(pbps_sock, raw_array, data_size);

  return 0;
}
