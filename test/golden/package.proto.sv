package example;

  `include "uvm_macros.svh"
  import uvm_pkg::*;

  class Hello extends uvm_object;


    ///////////////////////////////////////////////////////////////////////////
    // Public Variables
    string name;

    ///////////////////////////////////////////////////////////////////////////
    // Bookkeeping Variables
    local const pb_pkg::field_number_t name__field_number = 1;

    bit m_is_initialized[string];

    `uvm_object_utils(Hello)

    function new(string name="Hello");
       super.new(.name(name));
    this.m_is_initialized["name"] = 0;
    endfunction : new

    function void serialize(ref pb_pkg::bytestream_t _stream);
      pb_pkg::enc_bytestream_t enc_stream;
      this._serialize(._stream(enc_stream));
      pb_pkg::_bytestream_queue_to_dynamic_array(._out(_stream), ._in(enc_stream));
    endfunction : serialize

    function void _serialize(ref pb_pkg::enc_bytestream_t _stream);
      if (!this.is_initialized()) begin
        `uvm_fatal(this.get_name(), "Attempting to serialize, but not initialized")
      end
      if (this.name.len()) begin
        pb_pkg::encode_message_key(._field_number(this.name__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_DELIMITED),
                                   ._stream(_stream));
        pb_pkg::encode_type_string(._value(this.name),
                                   ._stream(_stream));
      end

    endfunction : _serialize

    function void deserialize(ref pb_pkg::bytestream_t _stream);
      pb_pkg::cursor_t cursor = 0;
      pb_pkg::cursor_t cursor_stop = -1;
      this._deserialize(._stream(_stream), ._cursor(cursor), ._cursor_stop(cursor_stop));
    endfunction : deserialize

    function void _deserialize(ref pb_pkg::bytestream_t _stream, ref pb_pkg::cursor_t _cursor, input pb_pkg::cursor_t _cursor_stop);
      pb_pkg::cursor_t cursor_orig = _cursor;
      pb_pkg::cursor_t stream_size = _stream.size();
      while ((_cursor < stream_size) && (_cursor < _cursor_stop)) begin
        pb_pkg::field_number_t field_number;
        pb_pkg::wire_type_e wire_type;
        pb_pkg::varint_t delimited_length;
        pb_pkg::cursor_t delimited_stop;
        if (pb_pkg::decode_message_key(._field_number(field_number),
                                          ._wire_type(wire_type),
                                          ._stream(_stream),
                                          ._cursor(_cursor))) begin
            `uvm_fatal(this.get_name(), "Decode_message_key failed")
         end
        if (wire_type == pb_pkg::WIRE_TYPE_DELIMITED) begin
            if (pb_pkg::decode_varint(._value(delimited_length),
                                         ._stream(_stream),
                                         ._cursor(_cursor))) begin
               `uvm_fatal(this.get_name(), "decode_varint for WIRE_TYPE_DELIMITED failed")
             end
            delimited_stop = _cursor + delimited_length;
        end
        case (field_number)
          0 : `uvm_error(this.get_name(), $sformatf("Extracted field_number==0 which is illegal at cursor %0d in stream\n%p", _cursor, _stream))
          ////////////////////////////////
          // name
          name__field_number: begin
            if (wire_type != pb_pkg::WIRE_TYPE_DELIMITED) begin
              `uvm_fatal(this.get_name(), "Unexpected wire_type")
            end
            if (pb_pkg::decode_type_string(._result(name), ._stream(_stream), ._cursor(_cursor), ._str_length(delimited_length))) begin
              `uvm_fatal(this.get_name(), "Failed subdecode")
            end
            this.m_is_initialized["name"] = 1;
          end
          default : begin
            if (pb_pkg::decode_and_consume_unknown(._wire_type(wire_type), ._stream(_stream), ._cursor(_cursor), ._delimited_length(delimited_length))) begin
              `uvm_fatal(this.get_name(), "Failed decode_and_consume_unknown")
            end
          end
        endcase
        if (wire_type == pb_pkg::WIRE_TYPE_DELIMITED) begin
          if (_cursor != delimited_stop) begin
            `uvm_fatal(this.get_name(), "cursor didn't stop at exactly delimited_stop")
          end
        end
        if (_cursor == cursor_orig) begin
          `uvm_error(this.get_name(), $sformatf("Deserialize loop didn't advance cursor starting at position %0d. Stream follows:\n%p", _cursor, _stream))
          break;
        end
      end
      if (!this.is_initialized()) begin
        `uvm_error(this.get_name(), "Deserialize didn't result in proper initialization")
      end
    endfunction : _deserialize

    function bit is_initialized();
      is_initialized = 1;
      foreach (this.m_is_initialized[field_name]) begin
        if (!this.m_is_initialized[field_name]) begin
          `uvm_warning(this.get_name(), $sformatf("required field '%s' was not initialized", field_name))
          is_initialized = 0;
        end
      end
    endfunction : is_initialized

    function void post_randomize();
      this.m_is_initialized["name"] = 1;
    endfunction : post_randomize

  virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    bit res;
    Hello rhs_cast;
    $cast(rhs_cast, rhs);
    res = super.do_compare(rhs, comparer);
  res &= (this.name == rhs_cast.name);
    return res;
  endfunction : do_compare

  virtual function void do_print( uvm_printer printer );
    super.do_print( printer );
      printer.print_string("name", this.name);
  endfunction : do_print

  endclass : Hello


endpackage : example
