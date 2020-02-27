`ifndef __PB_ENCODE_SVH__
 `define __PB_ENCODE_SVH__

function automatic bit _insert_32_bits(output bit [31:0] _value,
                                        ref bytestream_t _stream,
                                        ref cursor_t _cursor);
   for (int unsigned ii=0; ii < 32; ii+=8) begin
      byte tmp = (_value >> ii) & 8'hFF;
      _stream[_cursor++] = tmp;
   end
   return 0;
endfunction : _insert_32_bits

function automatic bit _insert_64_bits(output bit [63:0] _value,
                                        ref bytestream_t _stream,
                                        ref cursor_t _cursor);
   for (int unsigned ii=0; ii < 64; ii+=8) begin
      byte tmp = (_value >> ii) & 8'hFF;
      _stream[_cursor++] = tmp;
   end
   return 0;
endfunction : _insert_64_bits

function int unsigned _int_to_zigzag32(input int _in);
   return (_in << 1) ^ (_in >>> 31);
endfunction : _zigzag32_to_int

function longint unsigned _longint_to_zigzag64(input longint _in);
   return (_in << 1) ^ (_in >>> 63);
endfunction : _zigzag64_to_longint

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

function automatic bit encode_type_string(input string _value,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
   return 1; // TODO implement
endfunction : encode_type_string

function automatic bit encode_type_int32(input int _value,
                                         ref bytestream_t _stream,
                                         ref cursor_t _cursor);
   return encode_varint(._varint(_value), ._stream(_stream), ._cursor(_cursor));
endfunction : encode_type_int32

function automatic bit encode_type_int64(input longint _value,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
   return encode_varint(._varint(_value), ._stream(_stream), ._cursor(_cursor));
endfunction : encode_type_int64

function automatic bit encode_type_uint32(input int unsigned _value,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
   return encode_varint(._varint(_value), ._stream(_stream), ._cursor(_cursor));
endfunction : encode_type_uint32

function automatic bit encode_type_uint64(input longint _value,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
   return encode_varint(._varint(_value), ._stream(_stream), ._cursor(_cursor));
endfunction : encode_type_uint64

function automatic bit encode_type_float(input shortreal _value,
                                         ref bytestream_t _stream,
                                         ref cursor_t _cursor);
   bit [31:0] value_bits = $shortrealtobits(_value);
   return _insert_32_bits(._value(value_bits), ._stream(_stream), ._cursor(_cursor));
endfunction : encode_type_float

function automatic bit encode_type_double(input real _value,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
   bit [63:0] value_bits = $realtobits(_value);
   return _insert_64_bits(._value(value_bits), ._stream(_stream), ._cursor(_cursor));
endfunction : encode_type_double

function automatic bit encode_type_fixed32(input int unsigned _value,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
   return _insert_32_bits(._value(_value), ._stream(_stream), ._cursor(_cursor));
endfunction : encode_type_fixed32

function automatic bit encode_type_fixed64(input longint unsigned _value,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
   return _insert_64_bits(._value(_value), ._stream(_stream), ._cursor(_cursor));
endfunction : encode_type_fixed64

function automatic bit encode_type_sfixed32(input int _value,
                                            ref bytestream_t _stream,
                                            ref cursor_t _cursor);
   return _insert_32_bits(._value(_value), ._stream(_stream), ._cursor(_cursor));
endfunction : encode_type_sfixed32

function automatic bit encode_type_sfixed64(input longint _value,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
   return _insert_64_bits(._value(_value), ._stream(_stream), ._cursor(_cursor));
endfunction : encode_type_sfixed64

function automatic bit encode_type_sint32(input int _value,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
   bit [31:0] zigzag = _int_to_zigzag(_value);
   return _insert_32_bits(._value(zigzag), ._stream(_stream), ._cursor(_cursor));
endfunction : encode_type_sint32

function automatic bit encode_type_sint64(input longint _value,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
   bit [63:0] zigzag = _longint_to_zigzag(_value);
   return _insert_64_bits(._value(zigzag), ._stream(_stream), ._cursor(_cursor));
endfunction : encode_type_sint64

`endif // guard
