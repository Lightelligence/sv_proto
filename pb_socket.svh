/*
 The socket_c class wraps a simple read/write DPI interface to a file based socket.
 The protocol over the socket is:
   1. send payload.size() as 4 bytes
   2. send payload
 */

`ifndef __PB_SOCKET_SVH__
 `define __PB_SOCKET_SVH__

import "DPI" socket_initialize  = function int _socket_initialize (input string socket_name, output int _socket_id);
import "DPI" socket_write_bytes = function void _socket_write_bytes(input int _socket_id, input  byte _stream[]);
import "DPI" socket_read_bytes  = task _socket_read_bytes (input int _socket_id, output byte _stream[]);

class socket_c extends uvm_object;

   local bit is_initialized = 0;
   string name;
   local int socket_id;

   `uvm_object_utils_begin(socket_c)
      `uvm_field_string(name, UVM_ALL_ON)
   `uvm_object_utils_end

   function new(string name="socket");
      super.new(name);
   endfunction : new

   virtual function void initialize(string _name);
      if (this.is_initialized) begin
         `uvm_error("socket", $sformatf("Attempting to reinitialize socket %s", this.name))
         return;
      end
      this.name = _name;
      if (_socket_initialize(name, this.socket_id)) begin
         `uvm_fatal("socket", $sformatf("Failed to connect to socket %s", this.name))
      end
      this.is_initialized = 1;
   endfunction : initialize

   virtual function void tx_serialized_message(ref bytestream_t _stream);
      bytestream_t stream_size = '{0, 0, 0, 0};
      if (!this.is_initialized) begin
         `uvm_fatal("socket", "Attempting to tx_serialized_message before initialization")
      end
      stream_size = {<<8{_stream.size()}};
      _socket_write_bytes(this.socket_id, stream_size);
      _socket_write_bytes(this.socket_id, _stream);
   endfunction : tx_serialized_message

   virtual task rx_serialized_message(ref bytestream_t _stream);
      bytestream_t payload_size_buf = new[4];
      int unsigned payload_size;
      if (!this.is_initialized) begin
         `uvm_fatal("socket", "Attempting to rx_serialized_message before initialization")
      end
      _socket_read_bytes(this.socket_id, payload_size_buf);
      payload_size = {<<8{payload_size_buf}};
      _stream = new[payload_size];
      _socket_read_bytes(this.socket_id, _stream);
   endtask : rx_serialized_message

endclass : socket_c      
   
`endif // guard
