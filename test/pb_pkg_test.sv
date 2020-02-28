// Unit test functions for pb_pkg.svh
import pb_pkg::*;

function automatic void test_bytestream_conversion();
   bytestream_t stream;
   enc_bytestream_t enc_stream;
   for (int unsigned ii=0; ii<53; ii++) begin
      enc_stream.push_back(ii);
   end
   assert(!_bytestream_queue_to_dynamic_array(._out(stream), ._in(enc_stream)));
   foreach(enc_stream[ii]) begin
      assert (stream[ii] == enc_stream[ii]);
   end
endfunction : test_bytestream_conversion

function automatic void test_varint_decode_single_byte();
   bytestream_t stream = '{8'b0000_0001};
   cursor_t cursor = 0;
   varint_t result;
   bit failure = decode_varint(result, stream, cursor);
   assert (failure == 0);
   assert (result == 1) else $display("result: %0d", result);
endfunction : test_varint_decode_single_byte

function automatic void test_varint_decode_300();
   bytestream_t stream = '{8'b1010_1100, 8'b0000_0010};
   cursor_t cursor = 0;
   varint_t result;
   bit failure = decode_varint(result, stream, cursor);
   assert (failure == 0);
   assert (result == 300) else $display("result: %0d", result);
endfunction : test_varint_decode_300

function automatic void test_varint_encode();
   enc_bytestream_t enc_stream;
   bytestream_t stream;
   cursor_t cursor = 0;
   varint_t result;
   bit failure = encode_varint(223, enc_stream);
   assert (failure == 0);
   failure = _bytestream_queue_to_dynamic_array(._out(stream), ._in(enc_stream));
   assert (failure == 0);
   failure = decode_varint(result, stream, cursor);
   assert (failure == 0);
   assert (result == 223) else $display("result: %0d", result);
endfunction : test_varint_encode

function automatic void test_message_key_encode_decode();
   enc_bytestream_t enc_stream;
   bytestream_t stream;
   cursor_t cursor = 0;
   field_number_t field_number = 12;
   wire_type_e wire_type = WIRE_TYPE_DELIMITED;
   bit failure = encode_message_key(field_number, wire_type, enc_stream);
   assert (failure == 0);
   failure = _bytestream_queue_to_dynamic_array(._out(stream), ._in(enc_stream));
   assert (failure == 0);
   cursor = 0;
   field_number = 0;
   wire_type = 0;
   failure = decode_message_key(field_number, wire_type, stream, cursor);
   assert (field_number == 12) else $display("field_number: %0d", field_number);
   assert (wire_type == WIRE_TYPE_DELIMITED) else $display("wire_type: %0d", wire_type);
endfunction : test_message_key_encode_decode

function automatic void test_decode_string();
   bytestream_t stream = '{8'h07, 8'h74, 8'h65, 8'h73, 8'h74, 8'h69, 8'h6e, 8'h67};
   enc_bytestream_t stream2;
   cursor_t cursor = 0;
   string result;
   bit    failure = decode_type_string(result, stream, cursor);
   assert (failure == 0);
   assert (result == "testing") else $display("result: %s", result);
   cursor = 0;
   failure = encode_type_string(result, stream2);
   assert (failure == 0);
   foreach (stream[xx]) begin
      assert (stream[xx] == stream2[xx]);
   end
endfunction : test_decode_string

function automatic void test_zigzag();
   assert (_zigzag64_to_longint(0) ==  0);
   assert (_zigzag64_to_longint(1) == -1);
   assert (_zigzag64_to_longint(2) ==  1);
   assert (_zigzag64_to_longint(3) == -2);
endfunction : test_zigzag
   

module tb_top;
   initial begin
      test_bytestream_conversion();
      test_varint_decode_single_byte();
      test_varint_decode_300();
      test_varint_encode();
      test_message_key_encode_decode();
      test_decode_string();
      test_zigzag();
   end
endmodule : tb_top
