/* Base functionality for protobuffer based SystemVerilog classes
 
Encoding documentation:
  https://developers.google.com/protocol-buffers/docs/encoding#simple
*/

package pb_pkg;

   localparam MAX_VARINT_BYTES = (64 / 7) + 1; // Sanity check for maximum bytes for a varint

   // Given a byte stream, start at _position cursor and extract a varint
   // _stream is not modified, passed as ref for performance
   // _cursor is advanced to next unconsumed byte in stream
   function automatic bit extract_varint(output longint unsigned _varint, ref byte _stream[], ref int unsigned _cursor);
      int bit_counter = 0;
      _varint = 0;
      for (int unsigned ii=0; ii < MAX_VARINT_BYTES; ii++) begin
         byte current_byte = _stream[_cursor++];
         _varint |= (current_byte & 8'h7f) << bit_counter;
         if (current_byte[7] == 0) begin
            return 0;
         end
         bit_counter+=7;
      end
      return 1;
   endfunction : extract_varint

endpackage : pb_pkg
