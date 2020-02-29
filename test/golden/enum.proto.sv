package example;

  `include "uvm_macros.svh"
  import uvm_pkg::*;

  typedef enum {
    NONE = 0,
    MR = 1,
    MRS = 2,
    MISS = 3
  } Greeting;


  class Hello extends uvm_object;

    rand Greeting greeting;
    string name;

    local const pb_pkg::field_number_t greeting__field_number = 1;
    local const pb_pkg::field_number_t name__field_number = 2;

    local const pb_pkg::label_e greeting__label = pb_pkg::LABEL_REQUIRED;
    local const pb_pkg::label_e name__label = pb_pkg::LABEL_REQUIRED;

    bit greeting__is_initialized = 0;
    bit name__is_initialized = 0;

    `uvm_object_utils_begin(Hello)
      `uvm_field_enum(Greeting, greeting, UVM_ALL_ON)
      `uvm_field_string(name, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name="Hello");
       super.new(.name(name));
    endfunction : new

    function void serialize(ref pb_pkg::bytestream_t _stream);
      pb_pkg::enc_bytestream_t enc_stream;
      this._serialize(._stream(enc_stream));
      pb_pkg::_bytestream_queue_to_dynamic_array(._out(_stream), ._in(enc_stream));
    endfunction : serialize

    function void _serialize(ref pb_pkg::enc_bytestream_t _stream);
       assert (this.is_initialized());
      begin
        Greeting tmp = this.greeting;
        pb_pkg::encode_message_key(._field_number(this.greeting__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_enum(._value(tmp), ._stream(_stream));
      end
      begin
        string tmp = this.name;
        pb_pkg::encode_message_key(._field_number(this.name__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_DELIMITED),
                                   ._stream(_stream));
        pb_pkg::encode_type_string(._value(tmp),
                                   ._stream(_stream));
      end

    endfunction : _serialize

    function void deserialize(ref pb_pkg::bytestream_t _stream);
      pb_pkg::cursor_t cursor = 0;
      pb_pkg::cursor_t cursor_stop = -1;
      this._deserialize(._stream(_stream), ._cursor(cursor), ._cursor_stop(cursor_stop));
    endfunction : deserialize

    function void _deserialize(ref pb_pkg::bytestream_t _stream, ref pb_pkg::cursor_t _cursor, input pb_pkg::cursor_t _cursor_stop);
      pb_pkg::cursor_t stream_size = _stream.size();
      while ((_cursor < stream_size) && (_cursor < _cursor_stop)) begin
        pb_pkg::field_number_t field_number;
        pb_pkg::wire_type_e wire_type;
        pb_pkg::varint_t delimited_length;
        pb_pkg::cursor_t delimited_stop;
        assert (!pb_pkg::decode_message_key(._field_number(field_number),
                                            ._wire_type(wire_type),
                                            ._stream(_stream),
                                            ._cursor(_cursor)));
        if (wire_type == pb_pkg::WIRE_TYPE_DELIMITED) begin
            assert (!pb_pkg::decode_varint(._value(delimited_length),
                                           ._stream(_stream),
                                           ._cursor(_cursor)));
            delimited_stop = _cursor + delimited_length;
        end
        case (field_number)
          greeting__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_enum(._result(greeting), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.greeting__is_initialized = 1;
          end
          name__field_number: begin
            assert (wire_type == pb_pkg::WIRE_TYPE_DELIMITED);
            assert (!pb_pkg::decode_type_string(._result(name), ._stream(_stream), ._cursor(_cursor), ._str_length(delimited_length)));
            this.name__is_initialized = 1;
          end
          default : assert (!pb_pkg::decode_and_consume_unknown(._wire_type(wire_type), ._stream(_stream), ._cursor(_cursor), ._delimited_length(delimited_length)));
        endcase
        if (wire_type == pb_pkg::WIRE_TYPE_DELIMITED) begin
          assert (_cursor == delimited_stop) else $display("_cursor: %0d delimited_stop: %0d", _cursor, delimited_stop);
        end
      end
      assert (this.is_initialized());
    endfunction : _deserialize

    function bit is_initialized();
      is_initialized = 1;
      is_initialized &= this.greeting__is_initialized;
      is_initialized &= this.name__is_initialized;
    endfunction : is_initialized
    function void post_randomize();
      this.greeting__is_initialized = 1;
      this.name__is_initialized = 1;
    endfunction : post_randomize

  endclass : Hello


endpackage : example
