`ifndef __PB_ENCODE_SVH__
 `define __PB_ENCODE_SVH__

function automatic bit _bytestream_queue_to_dynamic_array(ref bytestream_t _out,
                                                          ref enc_bytestream_t _in);
   _out = new[_in.size()];
   _out = {>>{_in}};
   return 0;
endfunction : _bytestream_queue_to_dynamic_array

function automatic queue_extend(ref enc_bytestream_t _modify, ref enc_bytestream_t _discard);
   foreach (_discard[ii]) begin
      _modify.push_back(_discard[ii]);
   end
endfunction queue_extend

function automatic bit _insert_32_bits(output bit [31:0] _value,
                                       ref enc_bytestream_t _stream);
   for (int unsigned ii=0; ii < 32; ii+=8) begin
      byte tmp = (_value >> ii) & 8'hFF;
      _stream.push_back(tmp);
   end
   return 0;
endfunction : _insert_32_bits

function automatic bit _insert_64_bits(output bit [63:0] _value,
                                       ref enc_bytestream_t _stream);
   for (int unsigned ii=0; ii < 64; ii+=8) begin
      byte tmp = (_value >> ii) & 8'hFF;
      _stream.push_back(tmp);
   end
   return 0;
endfunction : _insert_64_bits

function int unsigned _int_to_zigzag32(input int _in);
   return (_in << 1) ^ (_in >>> 31);
endfunction : _int_to_zigzag32

function longint unsigned _longint_to_zigzag64(input longint _in);
   return (_in << 1) ^ (_in >>> 63);
endfunction : _longint_to_zigzag64

function automatic bit encode_varint(input varint_t _varint,
                                     ref enc_bytestream_t _stream);
   do begin
      byte current = _varint & 8'h7f;
      _varint >>= 7;
      if (_varint) begin
         current |= 8'h80;
      end
      _stream.push_back(current);
   end while (_varint);
   return 0;
endfunction : encode_varint

function automatic bit encode_message_key(input field_number_t _field_number,
                                          input wire_type_t _wire_type,
                                          ref enc_bytestream_t _stream);
   varint_t varint = (_field_number << 3) | _wire_type;
   return encode_varint(._varint(varint), ._stream(_stream));
endfunction : encode_message_key

function automatic bit encode_delimited(input field_number_t _field_number,
                                        ref enc_bytestream_t _delimited_stream,
                                        ref enc_bytestream_t _stream);
   encode_message_key(._field_number(_field_number),
                      ._wire_type(2),
                      ._stream(_stream));
   pb_pkg::encode_varint(._value(_delimited_stream.size()),
                         ._stream(_stream));
   pb_pkg::queue_extend(._modify(_stream),
                        ._discard(_delimited_stream));
endfunction : encode_delimited

function automatic bit encode_type_string(input string _value,
                                          ref enc_bytestream_t _stream);
   bit retval;
   varint_t str_length = _value.len();
   retval |= encode_varint(._varint(str_length), ._stream(_stream));
   foreach (_value[ii]) begin
      _stream.push_back(_value[ii]);
   end
   return 0;
endfunction : encode_type_string

function automatic bit encode_type_int32(input int _value,
                                         ref enc_bytestream_t _stream);
   return encode_varint(._varint(_value), ._stream(_stream));
endfunction : encode_type_int32

function automatic bit encode_type_int64(input longint _value,
                                         ref enc_bytestream_t _stream);
   return encode_varint(._varint(_value), ._stream(_stream));
endfunction : encode_type_int64

function automatic bit encode_type_uint32(input int unsigned _value,
                                          ref enc_bytestream_t _stream);
   return encode_varint(._varint(_value), ._stream(_stream));
endfunction : encode_type_uint32

function automatic bit encode_type_uint64(input longint _value,
                                          ref enc_bytestream_t _stream);
   return encode_varint(._varint(_value), ._stream(_stream));
endfunction : encode_type_uint64

function automatic bit encode_type_float(input shortreal _value,
                                         ref enc_bytestream_t _stream);
   bit [31:0] value_bits = $shortrealtobits(_value);
   return _insert_32_bits(._value(value_bits), ._stream(_stream));
endfunction : encode_type_float

function automatic bit encode_type_double(input real _value,
                                          ref enc_bytestream_t _stream);
   bit [63:0] value_bits = $realtobits(_value);
   return _insert_64_bits(._value(value_bits), ._stream(_stream));
endfunction : encode_type_double

function automatic bit encode_type_fixed32(input int unsigned _value,
                                           ref enc_bytestream_t _stream);
   return _insert_32_bits(._value(_value), ._stream(_stream));
endfunction : encode_type_fixed32

function automatic bit encode_type_fixed64(input longint unsigned _value,
                                           ref enc_bytestream_t _stream);
   return _insert_64_bits(._value(_value), ._stream(_stream));
endfunction : encode_type_fixed64

function automatic bit encode_type_sfixed32(input int _value,
                                            ref enc_bytestream_t _stream);
   return _insert_32_bits(._value(_value), ._stream(_stream));
endfunction : encode_type_sfixed32

function automatic bit encode_type_sfixed64(input longint _value,
                                            ref enc_bytestream_t _stream);
   return _insert_64_bits(._value(_value), ._stream(_stream));
endfunction : encode_type_sfixed64

function automatic bit encode_type_sint32(input int _value,
                                          ref enc_bytestream_t _stream);
   bit [31:0] zigzag = _int_to_zigzag32(_value);
   return _insert_32_bits(._value(zigzag), ._stream(_stream));
endfunction : encode_type_sint32

function automatic bit encode_type_sint64(input longint _value,
                                          ref enc_bytestream_t _stream);
   bit [63:0] zigzag = _longint_to_zigzag64(_value);
   return _insert_64_bits(._value(zigzag), ._stream(_stream));
endfunction : encode_type_sint64

`endif // guard
