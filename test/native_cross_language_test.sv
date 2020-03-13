import pb_pkg::*;

task automatic test();
   pb_pkg::socket_c socket = pb_pkg::socket_c::type_id::create("socket");
   string socket_name;
   $value$plusargs("socket_name=%s", socket_name);
   $display("socket_name='%s'", socket_name);
   socket.initialize(socket_name);

   for (int ii=0; ii < 1; ii++) begin
      pb_pkg::bytestream_t stream0, stream1;
      Hello src = Hello::type_id::create("src");
      Hello dest = Hello::type_id::create("dest");

      src.f57 = "this is required";
      src.f60 = SubMessage::type_id::create("foob");
      src.f60.f4 = "not empty";
      src.f63 = '{8'h30, 8'h51};

      assert(src.randomize());

      src.print();
      src.serialize(stream0);

      socket.tx_serialized_message(stream0);
      socket.rx_serialized_message(stream1);
      // $display("stream: %p", stream1);
      dest.deserialize(stream1);
      src.compare(dest);
   end
endtask : test

module tb_top;
   initial begin
      test();
      $finish;
   end
endmodule
