#include <iostream>
#include <stdlib.h>

#include <sys/socket.h> 
#include <sys/un.h>
#include <unistd.h> 
#include <string.h> 

#include "external/xcelium/svdpi.h"

using namespace std;

extern "C" int socket_initialize(const char *socket_name, int *socket_id) {
  struct sockaddr_un saddr;
  saddr.sun_family = AF_UNIX;
  strncpy (saddr.sun_path, socket_name, sizeof(saddr.sun_path));
  saddr.sun_path[sizeof (saddr.sun_path) - 1] = '\0';

  if ((*socket_id = socket(AF_UNIX, SOCK_STREAM, 0)) < 0) { 
    cerr << "ERROR: Failed to create socket handle " << endl;
    return -1; 
  }

  if (connect(*socket_id, (struct sockaddr *)&saddr, sizeof(saddr)) < 0) { 
    cerr << "ERROR: Connection to socket " << socket_name << " failed" << endl;
    return -1; 
  } 
  cout << "Socket " << socket_name << " connected successfully" << endl;
  return 0;
}

int check_array_handle_dimensions(const svOpenArrayHandle h) {
  if (svDimensions(h) != 1) {
    cerr << "ERROR: multidimensional data sent to socket_*_bytes" << endl;
    return 1;
  }
  if (svSize(h, 0) != 8) {
    cerr << "ERROR: Expected data structure to be bytes" << endl;
    return 1;
  }
  return 0;
}

extern "C" int socket_write_bytes(int socket_id, const svOpenArrayHandle h) {
  check_array_handle_dimensions(h);
  unsigned int data_size = svSize(h, 1);
  unsigned char* raw_array = (unsigned char*)svGetArrayPtr(h);
  write(socket_id, raw_array, data_size);
  return 0;
}

extern "C" int socket_read_bytes(int socket_id, svOpenArrayHandle h) {
  check_array_handle_dimensions(h);
  unsigned int data_size = svSize(h, 1);
  unsigned char* raw_array = (unsigned char*)svGetArrayPtr(h);
  read(socket_id, raw_array, data_size);
  return 0;
}
