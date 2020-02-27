/* Base functionality for protobuffer based SystemVerilog classes
 
Encoding documentation:
  https://developers.google.com/protocol-buffers/docs/encoding#simple
*/

package pb_pkg;

   typedef byte             bytestream_t[];
   typedef int unsigned     cursor_t;
   typedef longint unsigned varint_t;
   typedef int unsigned     field_number_t;
   typedef int unsigned     wire_type_t;

   typedef enum {
                 LABEL_OPTIONAL = 1,
                 LABEL_REQUIRED = 2,
                 LABEL_REPEATED = 3
   } label_e;

   localparam MAX_VARINT_BYTES = (64 / 7) + 1; // Sanity check for maximum bytes for a varint

   // Given a byte stream, start at _position cursor and extract a varint
   // _stream is not modified, passed as ref for performance
   // _cursor is advanced to next unconsumed byte in stream
   // https://developers.google.com/protocol-buffers/docs/encoding#varints
   function automatic bit decode_varint(output varint_t _varint,
                                        ref bytestream_t _stream,
                                        ref cursor_t _cursor);
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


   // https://developers.google.com/protocol-buffers/docs/encoding#structure
   function automatic bit decode_message_key(output field_number_t _field_number,
                                             output wire_type_t _wire_type,
                                             ref bytestream_t _stream,
                                             ref cursor_t _cursor);
      varint_t varint;
      bit          retval = 0;
      retval = decode_varint(._varint(varint), ._stream(_stream), ._cursor(_cursor));
      _field_number = varint >> 3;
      _wire_type = varint & 3'b111;
      return retval;
   endfunction : decode_message_key

   function automatic bit encode_message_key(input field_number_t _field_number,
                                             input wire_type_t _wire_type,
                                             ref bytestream_t _stream,
                                             ref cursor_t _cursor);
      varint_t varint = (_field_number << 3) | _wire_type;
      return encode_varint(._varint(varint), ._stream(_stream), ._cursor(_cursor));
   endfunction : encode_message_key


   // https://developers.google.com/protocol-buffers/docs/encoding#strings
   // If _str_length != -1, assume the varint encoding the length has already been decoded
   function automatic bit decode_type_string(output string _result,
                                             ref bytestream_t _stream,
                                             ref cursor_t _cursor,
                                             input longint _str_length=-1);
      varint_t str_length;
      bit retval = 0;
      if (_str_length == -1) begin
         retval |= decode_varint(._varint(str_length), ._stream(_stream), ._cursor(_cursor));
      end
      else begin
         str_length = _str_length;
      end
      while (str_length) begin
         byte current = _stream[_cursor++];
         string current_str = string'(current);
         // TODO: performance
         // More efficient way to build up the string?
         _result = {_result, current_str};
         str_length--;
      end
      return 0;
   endfunction : decode_type_string

   function automatic bit decode_type_int32(output int _result,
                                       ref bytestream_t _stream,
                                       ref cursor_t _cursor);
      // TODO
      // Need to cast from longint unsigned to int?
      return decode_varint(._varint(_result), ._stream(_stream), ._cursor(_cursor));
   endfunction : decode_type_int32

   function automatic bit decode_type_int64(output longint _result,
                                       ref bytestream_t _stream,
                                       ref cursor_t _cursor);
      // TODO
      // Need to cast from longint unsigned to longint?
      return decode_varint(._varint(_result), ._stream(_stream), ._cursor(_cursor));
   endfunction : decode_type_int64

   function automatic bit decode_type_uint32(output int unsigned _result,
                                       ref bytestream_t _stream,
                                       ref cursor_t _cursor);
      // TODO
      // Need to cast from longint unsigned to int unsigned?
      return decode_varint(._varint(_result), ._stream(_stream), ._cursor(_cursor));
   endfunction : decode_type_uint32

   function automatic bit decode_type_uint64(output longint _result,
                                        ref bytestream_t _stream,
                                        ref cursor_t _cursor);
      return decode_varint(._varint(_result), ._stream(_stream), ._cursor(_cursor));
   endfunction : decode_type_uint64

   function automatic bit _extract_32_bits(output bit [31:0] _result,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
      for (int unsigned ii=0; ii < 32; ii+=8) begin
         _result |= (_stream[_cursor++] << ii);
      end
      return 0;
   endfunction : _extract_32_bits

   function automatic bit _extract_64_bits(output bit [63:0] _result,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
      for (int unsigned ii=0; ii < 64; ii+=8) begin
         _result |= (_stream[_cursor++] << ii);
      end
      return 0;
   endfunction : _extract_64_bits

   function automatic bit decode_type_float(output shortreal _result,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
      bit [31:0] result_bits;
      bit        retval = 0;
      retval |= _extract_32_bits(._result(result_bits), ._stream(_stream), ._cursor(_cursor));
      _result = $bitstoshortreal(result_bits);
      return retval;
   endfunction : decode_type_float

   function automatic bit decode_type_double(output shortreal _result,
                                        ref bytestream_t _stream,
                                        ref cursor_t _cursor);
      bit [63:0] result_bits;
      bit        retval = 0;
      retval |= _extract_64_bits(._result(result_bits), ._stream(_stream), ._cursor(_cursor));
      _result = $bitstoreal(result_bits);
      return retval;
   endfunction : decode_type_double

   // Consumes an unknown field
   function automatic bit decode_and_consume_unknown(input wire_type_t _wire_type,
                                                     ref bytestream_t _stream,
                                                     ref cursor_t _cursor);
      // TODO implement
      return 1;
   endfunction : decode_and_consume_unknown
                                                     
   
endpackage : pb_pkg
