import pb_pkg::*;

function automatic void test();
   for (int ii=0; ii < 10; ii++) begin
      pb_pkg::bytestream_t stream;
      Hello src = Hello::type_id::create("src");
      Hello dest = Hello::type_id::create("dest");

      assert(src.randomize() with {
         bool_2.size() == 3;
         bool_3.size() == 4;
         fixed32_2.size() == 11;
         fixed32_3.size() == 12;
         fixed64_2.size() == 15;
         fixed64_3.size() == 16;
         int32_2.size() == 23;
         int32_3.size() == 24;
         int64_2.size() == 27;
         int64_3.size() == 28;
         sfixed32_2.size() == 31;
         sfixed32_3.size() == 32;
         sfixed64_2.size() == 35;
         sfixed64_3.size() == 36;
         sint32_2.size() == 39;
         sint32_3.size() == 40;
         sint64_2.size() == 43;
         sint64_3.size() == 44;
         uint32_2.size() == 47;
         uint32_3.size() == 48;
         uint64_2.size() == 51;
         uint64_3.size() == 52;
         exampleenum_2.size() == 7;
         });
      //src.print();
      src.serialize(stream);
      //$display("%p", stream);
      dest.deserialize(stream);
      dest.print();
      assert(src.compare(dest));
      // $display("Round %0d complete", ii);
   end
endfunction : test


module tb_top;
   initial begin
      test();
   end
endmodule
