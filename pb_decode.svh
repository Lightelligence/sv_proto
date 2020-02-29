`ifndef __PB_DECODE_SVH__
 `define __PB_DECODE_SVH__

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

function int _zigzag32_to_int(input int unsigned _in);
   return (_in >> 1) ^ -(_in & 1);
endfunction : _zigzag32_to_int

function longint _zigzag64_to_longint(input longint unsigned _in);
   return (_in >> 1) ^ -(_in & 1);
endfunction : _zigzag64_to_longint

// Given a byte stream, start at _position cursor and extract a varint
// _stream is not modified, passed as ref for performance
// _cursor is advanced to next unconsumed byte in stream
// https://developers.google.com/protocol-buffers/docs/encoding#varints
function automatic bit decode_varint(output varint_t _value,
                                     ref bytestream_t _stream,
                                     ref cursor_t _cursor);
   int bit_counter = 0;
   _value = 0;
   for (int unsigned ii=0; ii < MAX_VARINT_BYTES; ii++) begin
      byte current_byte = _stream[_cursor++];
      _value |= (current_byte & 8'h7f) << bit_counter;
      if (current_byte[7] == 0) begin
         return 0;
      end
      bit_counter+=7;
   end
   return 1; // Fail if loop didn't break
endfunction : decode_varint

// https://developers.google.com/protocol-buffers/docs/encoding#structure
function automatic bit decode_message_key(output field_number_t _field_number,
                                          output wire_type_e _wire_type,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
   varint_t varint;
   bit                                           retval = 0;
   retval = decode_varint(._value(varint), ._stream(_stream), ._cursor(_cursor));
   _field_number = varint >> 3;
   _wire_type = wire_type_e'(varint & 3'b111);
   return retval;
endfunction : decode_message_key

// https://developers.google.com/protocol-buffers/docs/encoding#strings
// If _str_length != -1, assume the varint encoding the length has already been decoded
function automatic bit decode_type_string(output string _result,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor,
                                          input longint _str_length=-1);
   varint_t str_length;
   bit                                                  retval = 0;
   if (_str_length == -1) begin
      retval |= decode_varint(._value(str_length), ._stream(_stream), ._cursor(_cursor));
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

function automatic bit decode_type_bool(output bit _result,
                                         ref bytestream_t _stream,
                                         ref cursor_t _cursor);
   return decode_varint(._value(_result), ._stream(_stream), ._cursor(_cursor));
endfunction : decode_type_bool

function automatic bit decode_type_enum(output varint_t _result,
                                         ref bytestream_t _stream,
                                         ref cursor_t _cursor);
   return decode_varint(._value(_result), ._stream(_stream), ._cursor(_cursor));
endfunction : decode_type_enum

function automatic bit decode_type_int32(output int _result,
                                         ref bytestream_t _stream,
                                         ref cursor_t _cursor);
   return decode_varint(._value(_result), ._stream(_stream), ._cursor(_cursor));
endfunction : decode_type_int32

function automatic bit decode_type_int64(output longint _result,
                                         ref bytestream_t _stream,
                                         ref cursor_t _cursor);
   return decode_varint(._value(_result), ._stream(_stream), ._cursor(_cursor));
endfunction : decode_type_int64

function automatic bit decode_type_uint32(output int unsigned _result,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
   return decode_varint(._value(_result), ._stream(_stream), ._cursor(_cursor));
endfunction : decode_type_uint32

function automatic bit decode_type_uint64(output longint _result,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
   return decode_varint(._value(_result), ._stream(_stream), ._cursor(_cursor));
endfunction : decode_type_uint64


function automatic bit decode_type_float(output shortreal _result,
                                         ref bytestream_t _stream,
                                         ref cursor_t _cursor);
   bit [31:0] result_bits;
   bit        retval = 0;
   retval |= _extract_32_bits(._result(result_bits), ._stream(_stream), ._cursor(_cursor));
   _result = $bitstoshortreal(result_bits);
   return retval;
endfunction : decode_type_float

function automatic bit decode_type_double(output real _result,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
   bit [63:0] result_bits;
   bit        retval = 0;
   retval |= _extract_64_bits(._result(result_bits), ._stream(_stream), ._cursor(_cursor));
   _result = $bitstoreal(result_bits);
   return retval;
endfunction : decode_type_double

function automatic bit decode_type_fixed32(output int unsigned _result,
                                           ref bytestream_t _stream,
                                           ref cursor_t _cursor);
   return _extract_32_bits(._result(_result), ._stream(_stream), ._cursor(_cursor));
endfunction : decode_type_fixed32

function automatic bit decode_type_fixed64(output longint unsigned _result,
                                           ref bytestream_t _stream,
                                           ref cursor_t _cursor);
   return _extract_64_bits(._result(_result), ._stream(_stream), ._cursor(_cursor));
endfunction : decode_type_fixed64


function automatic bit decode_type_sfixed32(output int _result,
                                            ref bytestream_t _stream,
                                            ref cursor_t _cursor);
   return _extract_32_bits(._result(_result), ._stream(_stream), ._cursor(_cursor));
endfunction : decode_type_sfixed32

function automatic bit decode_type_sfixed64(output longint _result,
                                            ref bytestream_t _stream,
                                            ref cursor_t _cursor);
   return _extract_64_bits(._result(_result), ._stream(_stream), ._cursor(_cursor));
endfunction : decode_type_sfixed64

function automatic bit decode_type_sint32(output int _result,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
   bit        retval;
   bit [31:0] zigzag;
   retval |= _extract_32_bits(._result(zigzag), ._stream(_stream), ._cursor(_cursor));
   _result = _zigzag32_to_int(zigzag);
   return retval;
endfunction : decode_type_sint32

function automatic bit decode_type_sint64(output longint _result,
                                          ref bytestream_t _stream,
                                          ref cursor_t _cursor);
   bit        retval;
   bit [63:0] zigzag;
   retval |= _extract_64_bits(._result(zigzag), ._stream(_stream), ._cursor(_cursor));
   _result = _zigzag64_to_longint(zigzag);
   return retval;
endfunction : decode_type_sint64

// Consumes an unknown field
function automatic bit decode_and_consume_unknown(input wire_type_e _wire_type,
                                                  ref bytestream_t _stream,
                                                  ref cursor_t _cursor,
                                                  input longint _delimited_length=-1);
   bit                                                          retval = 0;
   case (_wire_type)
     WIRE_TYPE_VARINT: begin
        // Varint variable size, decode and don't use value
        varint_t unused;
        retval |= decode_varint(._value(unused), ._stream(_stream), ._cursor(_cursor));
     end
     WIRE_TYPE_64BIT: begin
        _cursor += 8;
     end
     WIRE_TYPE_DELIMITED: begin
        if (_delimited_length == -1) begin
           retval |= decode_varint(._value(_delimited_length), ._stream(_stream), ._cursor(_cursor));
        end
        _cursor += _delimited_length;
     end
     WIRE_TYPE_32BIT: begin
        _cursor += 4;
     end
     default: assert (0) else $display("Illegal wire type");
   endcase
   return retval;
endfunction : decode_and_consume_unknown

`endif // guard
