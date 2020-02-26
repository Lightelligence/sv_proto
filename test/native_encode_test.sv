import pb_pkg::*;

function automatic void test_creation();
   Hello h = Hello::type_id::create("Hello");
endfunction : test_creation

module tb_top;
   initial begin
      test_creation();
   end
endmodule : tb_top
