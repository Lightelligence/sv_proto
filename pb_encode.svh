`ifndef __PB_ENCODE_SVH__
 `define __PB_ENCODE_SVH__

function automatic bit encode_varint(input varint_t _varint,
                                     ref bytestream_t _stream,
                                     ref cursor_t _cursor);
   byte new_bytes[$];
   do begin
      byte current = _varint & 8'h7f;
      _varint >>= 7;
      if (_varint) begin
         current |= 8'h80;
      end
      new_bytes.push_back(current);
   end
   while (_varint);
   // TODO: performance
   // This might be too expensive to continuously reallocate
   // Might need to do some larger preallocation and then check size
   _stream = new[_stream.size() + new_bytes.size()](_stream);
   foreach(new_bytes[ii]) begin
      _stream[_cursor++] = new_bytes[ii];
   end
   return 0;
endfunction : encode_varint

function automatic bit encode_message_key(input field_number_t _field_number,
                                          input wire_type_t _wire_type,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
   varint_t varint = (_field_number << 3) | _wire_type;
   return encode_varint(._varint(varint), ._stream(_stream), ._cursor(_cursor));
endfunction : encode_message_key


`endif // guard
