import pb_pkg::*;

task automatic test();
   for (int ii=0; ii < 1; ii++) begin
      pb_pkg::socket_c socket = pb_pkg::socket_c::type_id::create("socket");
      pb_pkg::bytestream_t stream0, stream1;
      Hello src = Hello::type_id::create("src");
      Hello dest = Hello::type_id::create("dest");

      src.f57 = "this is required";
      src.f60 = SubMessage::type_id::create("foob");
      src.f63 = '{8'h30, 8'h51};

      socket.initialize("cross_language_socket");
      src.serialize(stream0);
      socket.tx_serialized_message(stream0);
      socket.rx_serialized_message(stream1);
      $display("stream: %p", stream1);
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
