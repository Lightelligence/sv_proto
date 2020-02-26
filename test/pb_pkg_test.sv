// Unit test functions for pb_pkg.svh
import pb_pkg::*;

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
   bytestream_t stream = new[2];
   cursor_t cursor = 0;
   varint_t result;
   bit failure = encode_varint(223, stream, cursor);
   assert (failure == 0);
   cursor = 0;
   failure = decode_varint(result, stream, cursor);
   assert (failure == 0);
   assert (result == 223) else $display("result: %0d", result);
endfunction : test_varint_encode

function automatic void test_message_key_encode_decode();
   bytestream_t stream = new[0];
   cursor_t cursor = 0;
   field_number_t field_number = 12;
   wire_type_t wire_type = 2;
   bit failure = encode_message_key(field_number, wire_type, stream, cursor);
   assert (failure == 0);
   cursor = 0;
   field_number = 0;
   wire_type = 0;
   failure = decode_message_key(field_number, wire_type, stream, cursor);
   assert (field_number == 12) else $display("field_number: %0d", field_number);
   assert (wire_type == 2) else $display("wire_type: %0d", wire_type);
endfunction : test_message_key_encode_decode

function automatic void test_decode_string();
   bytestream_t stream = '{8'h07, 8'h74, 8'h65, 8'h73, 8'h74, 8'h69, 8'h6e, 8'h67};
   cursor_t cursor = 0;
   string result;
   bit    failure = decode_type_string(result, stream, cursor);
   assert (failure == 0);
   assert (result == "testing") else $display("result: %s", result);
endfunction : test_decode_string

module tb_top;
   initial begin
      test_varint_decode_single_byte();
      test_varint_decode_300();
      test_varint_encode();
      test_message_key_encode_decode();
      test_decode_string();
   end
endmodule : tb_top
