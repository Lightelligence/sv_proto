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


module tb_top;
   initial begin
      test_varint_single_byte();
      test_varint_300();
   end
   
endmodule : tb_top
