/* Base functionality for protobuffer based SystemVerilog classes
 
Encoding documentation:
  https://developers.google.com/protocol-buffers/docs/encoding#simple
*/

package pb_pkg;

   localparam MAX_VARINT_BYTES = (64 / 7) + 1; // Sanity check for maximum bytes for a varint

   // Given a byte stream, start at _position cursor and extract a varint
   // _stream is not modified, passed as ref for performance
   // _cursor is advanced to next unconsumed byte in stream
   // https://developers.google.com/protocol-buffers/docs/encoding#varints
   function automatic bit decode_varint(output longint unsigned _varint,
                                        ref byte         _stream[],
                                        ref int unsigned _cursor);
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
      return 1; // Fail if loop didn't break
   endfunction : decode_varint

   function automatic bit encode_varint(input longint unsigned varint,
                                        ref byte         _stream[],
                                        ref int unsigned _cursor);
      byte new_bytes[$];
      do begin
         byte current = varint & 8'h7f;
         varint >>= 7;
         if (varint) begin
            current |= 8'h80;
         end
         new_bytes.push_back(current);
      end 
      while (varint);
      // This might be too expensive to continuously reallocate
      // Might need to do some larger preallocation and then check size
      _stream = new[_stream.size() + new_bytes.size()](_stream);
      foreach(new_bytes[ii]) begin
         _stream[_cursor++] = new_bytes[ii];
      end
      return 0;
   endfunction : encode_varint


   // https://developers.google.com/protocol-buffers/docs/encoding#structure
   function automatic bit decode_message_key(output int unsigned _field_number,
                                             output int unsigned _wire_type,
                                             ref byte            _stream[],
                                             ref int unsigned    _cursor);
      int unsigned varint;
      bit          retval = 0;
      retval = decode_varint(._varint(varint), ._stream(_stream), ._cursor(_cursor));
      _field_number = varint >> 3;
      _wire_type = varint & 3'b111;
      return retval;
   endfunction : decode_message_key

endpackage : pb_pkg
