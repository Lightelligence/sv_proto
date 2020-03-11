import pb_pkg::*;

function automatic void test();
   for (int ii=0; ii < 1; ii++) begin
      pb_pkg::bytestream_t stream;
      Hello src = Hello::type_id::create("src");
      Hello dest = Hello::type_id::create("dest");

      src.f56 = "I'm stringicus!";
      src.f57 = "No, I'm stringicus!";
      for (int ii=0; ii < 12; ii++) begin
         src.f58.push_back($sformatf("No, I'm stringicus(%0d)!",  ii));
      end

      src.f59 = SubMessage::type_id::create("f59");
      src.f60 = SubMessage::type_id::create("f60");
      for (int ii=0; ii < 5; ii++) begin
         src.f61.push_back(SubMessage::type_id::create($sformatf("f61_%0d", ii)));
      end

      src.f65[12] = SubMessage::type_id::create($sformatf("subm_%0d", 12));
      src.f65[13] = SubMessage::type_id::create($sformatf("subm_%0d", 13));
      src.f65[14] = SubMessage::type_id::create($sformatf("subm_%0d", 14));

      src.f66[12] = 12;
      src.f66[13] = 13;
      src.f66[14] = 14;

      src.f67[0] = "life";
      src.f67[1] = "is";
      src.f67[2] = "a";

      src.f68["a"] = "box";
      src.f68["b"] = "of";
      src.f68["c"] = "chocalates";

      assert(src.randomize() with {
         f3.size() == 3;
         f4.size() == 4;
         f11.size() == 11;
         f12.size() == 12;
         f15.size() == 15;
         f16.size() == 16;
         f23.size() == 23;
         f24.size() == 24;
         f27.size() == 27;
         f28.size() == 28;
         f31.size() == 31;
         f32.size() == 32;
         f35.size() == 35;
         f36.size() == 36;
         f39.size() == 39;
         f40.size() == 40;
         f43.size() == 43;
         f44.size() == 44;
         f47.size() == 47;
         f48.size() == 48;
         f51.size() == 51;
         f52.size() == 52;
         f55.size() == 7;
         f62.size() == 3;
      });

      //src.print();
      src.serialize(stream);
      // $display("%p", stream);
      dest.deserialize(stream);

      assert (src.f66.size() == dest.f66.size());
      foreach (src.f66[xx]) begin
         assert (src.f66[xx] == dest.f66[xx]);
      end

      assert (src.f67.size() == dest.f67.size());
      foreach (src.f67[xx]) begin
         assert (src.f67[xx] == dest.f67[xx]);
      end

      assert (src.f68.size() == dest.f68.size());
      foreach (src.f68[xx]) begin
         $display("src.f68[\"%s\"] = \"%s\"", xx, src.f68[xx]);
         assert (src.f68[xx] == dest.f68[xx]);
      end
      foreach (dest.f68[xx]) begin
         $display("dest.f68[\"%s\"] = \"%s\"", xx, dest.f68[xx]);
      end
      dest.print();
      assert(src.compare(dest));
      // $display("Round %0d complete", ii);
   end
endfunction : test


module tb_top;
   initial begin
      test();
      $finish;
   end
endmodule
