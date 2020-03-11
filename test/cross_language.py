"""Simple socket implementation to test serialization/deserialization across languages"""
import os
import socket
import struct
import sys

from test.proto.native_pb2 import Hello

class PBSocket():
    """Base class to manage socket and serialization."""
    def __init__(self, socket_name):
        """Blocks until opposite side of socket is connected."""
        self.socket_name = socket_name
        try:
            os.remove(self.socket_name)
        except OSError:
            pass
        self._s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        self._s.bind(self.socket_name)
        self._s.listen()
        self._conn, _ = self._s.accept()

    def close(self):
        """Call when finished interacting with SystemVerilog."""
        self._transmit_eot()
        self._s.shutdown(socket.SHUT_RDWR)
        self._s.close()

    def transmit(self, msg):
        """Send a ProtoBuf message across the socket."""
        payload_size_buf = struct.pack('<I', msg.ByteSize())
        buf = msg.SerializeToString()
        #print("Server about to transmit payload of size:", msg.ByteSize())
        self._conn.sendall(payload_size_buf)
        #print("Server transmitting:\n", msg)
        self._conn.sendall(buf)

    def receive(self):
        """Wait for a ProtoBuf message from the socket."""
        payload_size_buf = self._conn.recv(4)
        print("buf:", payload_size_buf.hex())
        payload_size = struct.unpack('<I', payload_size_buf)[0]
        print("unpacked:", payload_size)
        #print("Server about to receive payload of size:", payload_size)
        data = self._conn.recv(payload_size)
        print("data buf:", data.hex())
        rsp_simm = Hello()
        rsp_simm.ParseFromString(data)
        #print("Server received:\n", rsp_simm)
        return rsp_simm

def main(socket_name):
    s = PBSocket(socket_name)
    h = s.receive()
    h.f1 = True
    print(h)
    s.transmit(h)

if __name__ == '__main__':
    main(sys.argv[1])
