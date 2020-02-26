// Unit test functions for pb_pkg.svh

function automatic void test_varint_decode_single_byte();
   byte stream[] = '{8'b0000_0001};
   int unsigned cursor = 0;
   longint          result;
   bit failure = pb_pkg::decode_varint(result, stream, cursor);
   assert (failure == 0);
   assert (result == 1) else $display("result: %0d", result);
endfunction : test_varint_decode_single_byte

function automatic void test_varint_decode_300();
   byte    stream[] = '{8'b1010_1100, 8'b0000_0010};
   int unsigned cursor = 0;
   longint          result;
   bit failure = pb_pkg::decode_varint(result, stream, cursor);
   assert (failure == 0);
   assert (result == 300) else $display("result: %0d", result);
endfunction : test_varint_decode_300

function automatic void test_varint_encode();
   byte stream[] = new[2];
   int unsigned cursor = 0;
   longint          result;
   bit failure = pb_pkg::encode_varint(223, stream, cursor);
   assert (failure == 0);
   cursor = 0;
   failure = pb_pkg::decode_varint(result, stream, cursor);
   assert (failure == 0);
   assert (result == 223) else $display("result: %0d", result);
endfunction : test_varint_encode

function automatic void test_message_key_encode_decode();
   byte stream[] = new[0];
   int unsigned cursor = 0;
   int unsigned field_number = 12;
   int unsigned wire_type = 2;
   bit failure = pb_pkg::encode_message_key(field_number, wire_type, stream, cursor);
   assert (failure == 0);
   cursor = 0;
   field_number = 0;
   wire_type = 0;
   failure = pb_pkg::decode_message_key(field_number, wire_type, stream, cursor);
   assert (field_number == 12) else $display("field_number: %0d", field_number);
   assert (wire_type == 2) else $display("wire_type: %0d", wire_type);
endfunction : test_message_key_encode_decode

module tb_top;
   initial begin
      test_varint_decode_single_byte();
      test_varint_decode_300();
      test_varint_encode();
      test_message_key_encode_decode();
   end
endmodule : tb_top
