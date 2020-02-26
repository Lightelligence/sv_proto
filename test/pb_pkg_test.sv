// Unit test functions for pb_pkg.svh

function automatic void test_varint_single_byte();
   byte stream[] = '{8'b0000_0001};
   int unsigned cursor = 0;
   longint          result;
   bit failure = pb_pkg::extract_varint(result, stream, cursor);
   assert (failure == 0);
   assert (result == 1) else $display("result: %0d", result);
endfunction : test_varint_single_byte

function automatic void test_varint_300();
   byte    stream[] = '{8'b1010_1100, 8'b0000_0010};
   int unsigned cursor = 0;
   longint          result;
   bit failure = pb_pkg::extract_varint(result, stream, cursor);
   assert (failure == 0);
   assert (result == 300) else $display("result: %0d", result);
endfunction : test_varint_300

function automatic void test_message_key();
   byte stream[] = '{8'b0000_1000};
   int unsigned cursor = 0;
   int unsigned field_number, wire_type;
   bit failure = pb_pkg::extract_message_key(field_number, wire_type, stream, cursor);
   assert (failure == 0);
   assert (field_number == 1) else $display("field_number: %0d", field_number);
   assert (wire_type == 0) else $display("wire_type: %0d", wire_type);
endfunction : test_message_key

module tb_top;
   initial begin
      test_varint_single_byte();
      test_varint_300();
      test_message_key();
   end
endmodule : tb_top
