  `include "uvm_macros.svh"
  import uvm_pkg::*;

  typedef enum {
    VAL0 = 0,
    VAL1 = 1,
    VAL2 = 2,
    VAL3 = 4
  } ExampleEnum;


  class SubMessage extends uvm_object;

    ///////////////////////////////////////////////////////////////////////////
    // Public Variables
    `pb_real_rand shortreal f1;
    rand int unsigned f2;
    rand ExampleEnum f3;
    string f4;
    rand longint unsigned f5;
    rand ExampleEnum f6;

    ///////////////////////////////////////////////////////////////////////////
    // Bookkeeping Variables
    typedef enum {
      oneof__oo0__uninitialized
     ,oneof__oo0__f1
     ,oneof__oo0__f2
     ,oneof__oo0__f3
    } oneof__oo0_e;
    rand oneof__oo0_e oneof__oo0 = oneof__oo0__uninitialized;
    constraint oneof__oo0_cnstr {
      oneof__oo0 != oneof__oo0__uninitialized;
    }

    typedef enum {
      oneof__oo1__uninitialized
     ,oneof__oo1__f4
     ,oneof__oo1__f5
     ,oneof__oo1__f6
    } oneof__oo1_e;
    rand oneof__oo1_e oneof__oo1 = oneof__oo1__uninitialized;
    constraint oneof__oo1_cnstr {
      oneof__oo1 != oneof__oo1__uninitialized;
    }

    local const pb_pkg::field_number_t f1__field_number = 1;
    local const pb_pkg::field_number_t f2__field_number = 2;
    local const pb_pkg::field_number_t f3__field_number = 3;
    local const pb_pkg::field_number_t f4__field_number = 4;
    local const pb_pkg::field_number_t f5__field_number = 5;
    local const pb_pkg::field_number_t f6__field_number = 6;

    bit m_is_initialized[string];

    `uvm_object_utils(SubMessage)

    function new(string name="SubMessage");
       super.new(.name(name));
    endfunction : new

    function void serialize(ref pb_pkg::bytestream_t _stream);
      pb_pkg::enc_bytestream_t enc_stream;
      this._serialize(._stream(enc_stream));
      pb_pkg::_bytestream_queue_to_dynamic_array(._out(_stream), ._in(enc_stream));
    endfunction : serialize

    function void _serialize(ref pb_pkg::enc_bytestream_t _stream);
      assert (this.is_initialized());
      if (oneof__oo0 == oneof__oo0__f1) begin
        pb_pkg::encode_message_key(._field_number(this.f1__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_32BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_float(._value(this.f1), ._stream(_stream));
      end
      if (oneof__oo0 == oneof__oo0__f2) begin
        pb_pkg::encode_message_key(._field_number(this.f2__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_uint32(._value(this.f2), ._stream(_stream));
      end
      if (oneof__oo0 == oneof__oo0__f3) begin
        pb_pkg::encode_message_key(._field_number(this.f3__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_enum(._value(this.f3), ._stream(_stream));
      end
      if (oneof__oo1 == oneof__oo1__f4) begin
      if (this.f4.len()) begin
        pb_pkg::encode_message_key(._field_number(this.f4__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_DELIMITED),
                                   ._stream(_stream));
        pb_pkg::encode_type_string(._value(this.f4),
                                   ._stream(_stream));
      end
      end
      if (oneof__oo1 == oneof__oo1__f5) begin
        pb_pkg::encode_message_key(._field_number(this.f5__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_uint64(._value(this.f5), ._stream(_stream));
      end
      if (oneof__oo1 == oneof__oo1__f6) begin
        pb_pkg::encode_message_key(._field_number(this.f6__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_enum(._value(this.f6), ._stream(_stream));
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
          ////////////////////////////////
          // f1
          f1__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_float(._result(f1), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.oneof__oo0 = oneof__oo0__f1;
          end
          ////////////////////////////////
          // f2
          f2__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_uint32(._result(f2), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.oneof__oo0 = oneof__oo0__f2;
          end
          ////////////////////////////////
          // f3
          f3__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              pb_pkg::varint_t tmp_varint;
              assert (!pb_pkg::decode_type_enum(._result(tmp_varint), ._stream(_stream), ._cursor(_cursor)));
              f3 = ExampleEnum'(tmp_varint);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.oneof__oo0 = oneof__oo0__f3;
          end
          ////////////////////////////////
          // f4
          f4__field_number: begin
            assert (wire_type == pb_pkg::WIRE_TYPE_DELIMITED);
            assert (!pb_pkg::decode_type_string(._result(f4), ._stream(_stream), ._cursor(_cursor), ._str_length(delimited_length)));
            this.oneof__oo1 = oneof__oo1__f4;
          end
          ////////////////////////////////
          // f5
          f5__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_uint64(._result(f5), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.oneof__oo1 = oneof__oo1__f5;
          end
          ////////////////////////////////
          // f6
          f6__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              pb_pkg::varint_t tmp_varint;
              assert (!pb_pkg::decode_type_enum(._result(tmp_varint), ._stream(_stream), ._cursor(_cursor)));
              f6 = ExampleEnum'(tmp_varint);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.oneof__oo1 = oneof__oo1__f6;
          end
          default : assert (!pb_pkg::decode_and_consume_unknown(._wire_type(wire_type), ._stream(_stream), ._cursor(_cursor), ._delimited_length(delimited_length)));
        endcase
        if (wire_type == pb_pkg::WIRE_TYPE_DELIMITED) begin
          assert (_cursor == delimited_stop) else $display("_cursor: %0d delimited_stop: %0d", _cursor, delimited_stop);
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
      if (oneof__oo0 == oneof__oo0__uninitialized) begin
        `uvm_warning(this.get_name(), "oneof 'oo0' has no initialized member")
        is_initialized = 0;
      end
      if (oneof__oo1 == oneof__oo1__uninitialized) begin
        `uvm_warning(this.get_name(), "oneof 'oo1' has no initialized member")
        is_initialized = 0;
      end
    endfunction : is_initialized

    function void post_randomize();
    endfunction : post_randomize

  virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    bit res;
    SubMessage rhs_cast;
    $cast(rhs_cast, rhs);
    res = super.do_compare(rhs, comparer);
    case (this.oneof__oo0)
      oneof__oo0__f1: begin
      res &= (this.f1 == rhs_cast.f1);
end
      oneof__oo0__f2: begin
      res &= (this.f2 == rhs_cast.f2);
end
      oneof__oo0__f3: begin
      res &= (this.f3 == rhs_cast.f3);
end
      default: begin
        `uvm_error(this.get_name(), "oneof_{oneof.name} uninitialized in do_compare")
        res = 0;
      end
    endcase
    case (this.oneof__oo1)
      oneof__oo1__f4: begin
      res &= (this.f4 == rhs_cast.f4);
end
      oneof__oo1__f5: begin
      res &= (this.f5 == rhs_cast.f5);
end
      oneof__oo1__f6: begin
      res &= (this.f6 == rhs_cast.f6);
end
      default: begin
        `uvm_error(this.get_name(), "oneof_{oneof.name} uninitialized in do_compare")
        res = 0;
      end
    endcase
    return res;
  endfunction : do_compare

  virtual function void do_print( uvm_printer printer );
    super.do_print( printer );
    case (this.oneof__oo0)
      oneof__oo0__f1: begin
          printer.print_real("f1", this.f1);
      end
      oneof__oo0__f2: begin
          printer.print_field_int("f2", this.f2, 32, UVM_HEX);
      end
      oneof__oo0__f3: begin
          printer.print_field_int("f3", this.f3, 32, UVM_ENUM);
      end
      default: begin
        `uvm_error(this.get_name(), "oneof_{oneof.name} uninitialized in do_print")
      end
    endcase
    case (this.oneof__oo1)
      oneof__oo1__f4: begin
          printer.print_string("f4", this.f4);
      end
      oneof__oo1__f5: begin
          printer.print_field_int("f5", this.f5, 64, UVM_HEX);
      end
      oneof__oo1__f6: begin
          printer.print_field_int("f6", this.f6, 32, UVM_ENUM);
      end
      default: begin
        `uvm_error(this.get_name(), "oneof_{oneof.name} uninitialized in do_print")
      end
    endcase
  endfunction : do_print

  endclass : SubMessage


  class Hello extends uvm_object;

    ///////////////////////////////////////////////////////////////////////////
    // Public Variables
    rand bit f1;
    rand bit f2;
    rand bit f3[$];
    rand bit f4[$];
    `pb_real_rand real f5;
    `pb_real_rand real f6;
    `pb_real_rand real f7[$];
    `pb_real_rand real f8[$];
    rand int unsigned f9;
    rand int unsigned f10;
    rand int unsigned f11[$];
    rand int unsigned f12[$];
    rand longint unsigned f13;
    rand longint unsigned f14;
    rand longint unsigned f15[$];
    rand longint unsigned f16[$];
    `pb_real_rand shortreal f17;
    `pb_real_rand shortreal f18;
    `pb_real_rand shortreal f19[$];
    `pb_real_rand shortreal f20[$];
    rand int f21 = -3;
    rand int f22 = -5;
    rand int f23[$];
    rand int f24[$];
    rand longint f25;
    rand longint f26;
    rand longint f27[$];
    rand longint f28[$];
    rand int f29;
    rand int f30;
    rand int f31[$];
    rand int f32[$];
    rand longint f33;
    rand longint f34;
    rand longint f35[$];
    rand longint f36[$];
    rand int f37;
    rand int f38;
    rand int f39[$];
    rand int f40[$];
    rand longint f41;
    rand longint f42;
    rand longint f43[$];
    rand longint f44[$];
    rand int unsigned f45;
    rand int unsigned f46;
    rand int unsigned f47[$];
    rand int unsigned f48[$];
    rand longint unsigned f49;
    rand longint unsigned f50;
    rand longint unsigned f51[$];
    rand longint unsigned f52[$];
    rand ExampleEnum f53 = VAL1;
    rand ExampleEnum f54;
    rand ExampleEnum f55[$];
    string f56 = "a_default";
    string f57;
    string f58[$];
    rand SubMessage f59;
    rand SubMessage f60;
    rand SubMessage f61[$];
    rand pb_pkg::bytestream_t f62 = '{8'h32, 8'h31, 8'h31};
    rand pb_pkg::bytestream_t f63;
    rand pb_pkg::bytestream_t f64[$];
    rand SubMessage f65[int unsigned];
    rand int unsigned f66[int unsigned];
    string f67[int unsigned];
    string f68[string];

    ///////////////////////////////////////////////////////////////////////////
    // Bookkeeping Variables
    local const pb_pkg::field_number_t f1__field_number = 1;
    local const pb_pkg::field_number_t f2__field_number = 2;
    local const pb_pkg::field_number_t f3__field_number = 3;
    local const pb_pkg::field_number_t f4__field_number = 4;
    local const pb_pkg::field_number_t f5__field_number = 5;
    local const pb_pkg::field_number_t f6__field_number = 6;
    local const pb_pkg::field_number_t f7__field_number = 7;
    local const pb_pkg::field_number_t f8__field_number = 8;
    local const pb_pkg::field_number_t f9__field_number = 9;
    local const pb_pkg::field_number_t f10__field_number = 10;
    local const pb_pkg::field_number_t f11__field_number = 11;
    local const pb_pkg::field_number_t f12__field_number = 12;
    local const pb_pkg::field_number_t f13__field_number = 13;
    local const pb_pkg::field_number_t f14__field_number = 14;
    local const pb_pkg::field_number_t f15__field_number = 15;
    local const pb_pkg::field_number_t f16__field_number = 16;
    local const pb_pkg::field_number_t f17__field_number = 17;
    local const pb_pkg::field_number_t f18__field_number = 18;
    local const pb_pkg::field_number_t f19__field_number = 19;
    local const pb_pkg::field_number_t f20__field_number = 20;
    local const pb_pkg::field_number_t f21__field_number = 21;
    local const pb_pkg::field_number_t f22__field_number = 22;
    local const pb_pkg::field_number_t f23__field_number = 23;
    local const pb_pkg::field_number_t f24__field_number = 24;
    local const pb_pkg::field_number_t f25__field_number = 25;
    local const pb_pkg::field_number_t f26__field_number = 26;
    local const pb_pkg::field_number_t f27__field_number = 27;
    local const pb_pkg::field_number_t f28__field_number = 28;
    local const pb_pkg::field_number_t f29__field_number = 29;
    local const pb_pkg::field_number_t f30__field_number = 30;
    local const pb_pkg::field_number_t f31__field_number = 31;
    local const pb_pkg::field_number_t f32__field_number = 32;
    local const pb_pkg::field_number_t f33__field_number = 33;
    local const pb_pkg::field_number_t f34__field_number = 34;
    local const pb_pkg::field_number_t f35__field_number = 35;
    local const pb_pkg::field_number_t f36__field_number = 36;
    local const pb_pkg::field_number_t f37__field_number = 37;
    local const pb_pkg::field_number_t f38__field_number = 38;
    local const pb_pkg::field_number_t f39__field_number = 39;
    local const pb_pkg::field_number_t f40__field_number = 40;
    local const pb_pkg::field_number_t f41__field_number = 41;
    local const pb_pkg::field_number_t f42__field_number = 42;
    local const pb_pkg::field_number_t f43__field_number = 43;
    local const pb_pkg::field_number_t f44__field_number = 44;
    local const pb_pkg::field_number_t f45__field_number = 45;
    local const pb_pkg::field_number_t f46__field_number = 46;
    local const pb_pkg::field_number_t f47__field_number = 47;
    local const pb_pkg::field_number_t f48__field_number = 48;
    local const pb_pkg::field_number_t f49__field_number = 49;
    local const pb_pkg::field_number_t f50__field_number = 50;
    local const pb_pkg::field_number_t f51__field_number = 51;
    local const pb_pkg::field_number_t f52__field_number = 52;
    local const pb_pkg::field_number_t f53__field_number = 53;
    local const pb_pkg::field_number_t f54__field_number = 54;
    local const pb_pkg::field_number_t f55__field_number = 55;
    local const pb_pkg::field_number_t f56__field_number = 56;
    local const pb_pkg::field_number_t f57__field_number = 57;
    local const pb_pkg::field_number_t f58__field_number = 58;
    local const pb_pkg::field_number_t f59__field_number = 59;
    local const pb_pkg::field_number_t f60__field_number = 60;
    local const pb_pkg::field_number_t f61__field_number = 61;
    local const pb_pkg::field_number_t f62__field_number = 62;
    local const pb_pkg::field_number_t f63__field_number = 63;
    local const pb_pkg::field_number_t f64__field_number = 64;
    local const pb_pkg::field_number_t f65__field_number = 65;
    local const pb_pkg::field_number_t f65_key__field_number = 1;
    local const pb_pkg::field_number_t f65_value__field_number = 2;
    local const pb_pkg::field_number_t f66__field_number = 66;
    local const pb_pkg::field_number_t f66_key__field_number = 1;
    local const pb_pkg::field_number_t f66_value__field_number = 2;
    local const pb_pkg::field_number_t f67__field_number = 67;
    local const pb_pkg::field_number_t f67_key__field_number = 1;
    local const pb_pkg::field_number_t f67_value__field_number = 2;
    local const pb_pkg::field_number_t f68__field_number = 68;
    local const pb_pkg::field_number_t f68_key__field_number = 1;
    local const pb_pkg::field_number_t f68_value__field_number = 2;

    bit m_is_initialized[string];

    `uvm_object_utils(Hello)

    function new(string name="Hello");
       super.new(.name(name));
    this.m_is_initialized["f2"] = 0;
    this.m_is_initialized["f6"] = 0;
    this.m_is_initialized["f10"] = 0;
    this.m_is_initialized["f14"] = 0;
    this.m_is_initialized["f18"] = 0;
    this.m_is_initialized["f22"] = 0;
    this.m_is_initialized["f26"] = 0;
    this.m_is_initialized["f30"] = 0;
    this.m_is_initialized["f34"] = 0;
    this.m_is_initialized["f38"] = 0;
    this.m_is_initialized["f42"] = 0;
    this.m_is_initialized["f46"] = 0;
    this.m_is_initialized["f50"] = 0;
    this.m_is_initialized["f54"] = 0;
    this.m_is_initialized["f57"] = 0;
    this.m_is_initialized["f63"] = 0;
    endfunction : new

    function void serialize(ref pb_pkg::bytestream_t _stream);
      pb_pkg::enc_bytestream_t enc_stream;
      this._serialize(._stream(enc_stream));
      pb_pkg::_bytestream_queue_to_dynamic_array(._out(_stream), ._in(enc_stream));
    endfunction : serialize

    function void _serialize(ref pb_pkg::enc_bytestream_t _stream);
      assert (this.is_initialized());
      begin
        pb_pkg::encode_message_key(._field_number(this.f1__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_bool(._value(this.f1), ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f2__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_bool(._value(this.f2), ._stream(_stream));
      end
      foreach (this.f3[ii]) begin
        bit tmp = this.f3[ii];
        pb_pkg::encode_message_key(._field_number(this.f3__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_bool(._value(this.f3[ii]), ._stream(_stream));
      end
      if (this.f4.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.f4[ii]) begin
          pb_pkg::encode_type_bool(._value(this.f4[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.f4__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f5__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_64BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_double(._value(this.f5), ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f6__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_64BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_double(._value(this.f6), ._stream(_stream));
      end
      foreach (this.f7[ii]) begin
        real tmp = this.f7[ii];
        pb_pkg::encode_message_key(._field_number(this.f7__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_64BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_double(._value(this.f7[ii]), ._stream(_stream));
      end
      if (this.f8.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.f8[ii]) begin
          pb_pkg::encode_type_double(._value(this.f8[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.f8__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f9__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_32BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_fixed32(._value(this.f9), ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f10__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_32BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_fixed32(._value(this.f10), ._stream(_stream));
      end
      foreach (this.f11[ii]) begin
        int unsigned tmp = this.f11[ii];
        pb_pkg::encode_message_key(._field_number(this.f11__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_32BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_fixed32(._value(this.f11[ii]), ._stream(_stream));
      end
      if (this.f12.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.f12[ii]) begin
          pb_pkg::encode_type_fixed32(._value(this.f12[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.f12__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f13__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_64BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_fixed64(._value(this.f13), ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f14__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_64BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_fixed64(._value(this.f14), ._stream(_stream));
      end
      foreach (this.f15[ii]) begin
        longint unsigned tmp = this.f15[ii];
        pb_pkg::encode_message_key(._field_number(this.f15__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_64BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_fixed64(._value(this.f15[ii]), ._stream(_stream));
      end
      if (this.f16.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.f16[ii]) begin
          pb_pkg::encode_type_fixed64(._value(this.f16[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.f16__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f17__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_32BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_float(._value(this.f17), ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f18__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_32BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_float(._value(this.f18), ._stream(_stream));
      end
      foreach (this.f19[ii]) begin
        shortreal tmp = this.f19[ii];
        pb_pkg::encode_message_key(._field_number(this.f19__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_32BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_float(._value(this.f19[ii]), ._stream(_stream));
      end
      if (this.f20.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.f20[ii]) begin
          pb_pkg::encode_type_float(._value(this.f20[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.f20__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f21__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_int32(._value(this.f21), ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f22__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_int32(._value(this.f22), ._stream(_stream));
      end
      foreach (this.f23[ii]) begin
        int tmp = this.f23[ii];
        pb_pkg::encode_message_key(._field_number(this.f23__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_int32(._value(this.f23[ii]), ._stream(_stream));
      end
      if (this.f24.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.f24[ii]) begin
          pb_pkg::encode_type_int32(._value(this.f24[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.f24__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f25__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_int64(._value(this.f25), ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f26__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_int64(._value(this.f26), ._stream(_stream));
      end
      foreach (this.f27[ii]) begin
        longint tmp = this.f27[ii];
        pb_pkg::encode_message_key(._field_number(this.f27__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_int64(._value(this.f27[ii]), ._stream(_stream));
      end
      if (this.f28.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.f28[ii]) begin
          pb_pkg::encode_type_int64(._value(this.f28[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.f28__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f29__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_32BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sfixed32(._value(this.f29), ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f30__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_32BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sfixed32(._value(this.f30), ._stream(_stream));
      end
      foreach (this.f31[ii]) begin
        int tmp = this.f31[ii];
        pb_pkg::encode_message_key(._field_number(this.f31__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_32BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sfixed32(._value(this.f31[ii]), ._stream(_stream));
      end
      if (this.f32.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.f32[ii]) begin
          pb_pkg::encode_type_sfixed32(._value(this.f32[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.f32__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f33__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_64BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sfixed64(._value(this.f33), ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f34__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_64BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sfixed64(._value(this.f34), ._stream(_stream));
      end
      foreach (this.f35[ii]) begin
        longint tmp = this.f35[ii];
        pb_pkg::encode_message_key(._field_number(this.f35__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_64BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sfixed64(._value(this.f35[ii]), ._stream(_stream));
      end
      if (this.f36.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.f36[ii]) begin
          pb_pkg::encode_type_sfixed64(._value(this.f36[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.f36__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f37__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sint32(._value(this.f37), ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f38__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sint32(._value(this.f38), ._stream(_stream));
      end
      foreach (this.f39[ii]) begin
        int tmp = this.f39[ii];
        pb_pkg::encode_message_key(._field_number(this.f39__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sint32(._value(this.f39[ii]), ._stream(_stream));
      end
      if (this.f40.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.f40[ii]) begin
          pb_pkg::encode_type_sint32(._value(this.f40[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.f40__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f41__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sint64(._value(this.f41), ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f42__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sint64(._value(this.f42), ._stream(_stream));
      end
      foreach (this.f43[ii]) begin
        longint tmp = this.f43[ii];
        pb_pkg::encode_message_key(._field_number(this.f43__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sint64(._value(this.f43[ii]), ._stream(_stream));
      end
      if (this.f44.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.f44[ii]) begin
          pb_pkg::encode_type_sint64(._value(this.f44[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.f44__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f45__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_uint32(._value(this.f45), ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f46__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_uint32(._value(this.f46), ._stream(_stream));
      end
      foreach (this.f47[ii]) begin
        int unsigned tmp = this.f47[ii];
        pb_pkg::encode_message_key(._field_number(this.f47__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_uint32(._value(this.f47[ii]), ._stream(_stream));
      end
      if (this.f48.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.f48[ii]) begin
          pb_pkg::encode_type_uint32(._value(this.f48[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.f48__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f49__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_uint64(._value(this.f49), ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f50__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_uint64(._value(this.f50), ._stream(_stream));
      end
      foreach (this.f51[ii]) begin
        longint unsigned tmp = this.f51[ii];
        pb_pkg::encode_message_key(._field_number(this.f51__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_uint64(._value(this.f51[ii]), ._stream(_stream));
      end
      if (this.f52.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.f52[ii]) begin
          pb_pkg::encode_type_uint64(._value(this.f52[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.f52__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f53__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_enum(._value(this.f53), ._stream(_stream));
      end
      begin
        pb_pkg::encode_message_key(._field_number(this.f54__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_enum(._value(this.f54), ._stream(_stream));
      end
      foreach (this.f55[ii]) begin
        ExampleEnum tmp = this.f55[ii];
        pb_pkg::encode_message_key(._field_number(this.f55__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_enum(._value(this.f55[ii]), ._stream(_stream));
      end
      if (this.f56.len()) begin
        pb_pkg::encode_message_key(._field_number(this.f56__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_DELIMITED),
                                   ._stream(_stream));
        pb_pkg::encode_type_string(._value(this.f56),
                                   ._stream(_stream));
      end
      if (this.f57.len()) begin
        pb_pkg::encode_message_key(._field_number(this.f57__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_DELIMITED),
                                   ._stream(_stream));
        pb_pkg::encode_type_string(._value(this.f57),
                                   ._stream(_stream));
      end
      foreach (this.f58[ii]) begin
        pb_pkg::encode_message_key(._field_number(this.f58__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_DELIMITED),
                                   ._stream(_stream));
        pb_pkg::encode_type_string(._value(this.f58[ii]),
                                   ._stream(_stream));
      end
      if (this.f59) begin
        pb_pkg::enc_bytestream_t sub_stream;
        this.f59._serialize(._stream(sub_stream));
        pb_pkg::encode_delimited(._field_number(this.f59__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      if (this.f60) begin
        pb_pkg::enc_bytestream_t sub_stream;
        this.f60._serialize(._stream(sub_stream));
        pb_pkg::encode_delimited(._field_number(this.f60__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      foreach (this.f61[ii]) begin
        pb_pkg::enc_bytestream_t sub_stream;
        this.f61[ii]._serialize(._stream(sub_stream));
        pb_pkg::encode_delimited(._field_number(this.f61__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      if (this.f62.size()) begin
        pb_pkg::encode_message_key(._field_number(this.f62__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_DELIMITED),
                                   ._stream(_stream));
        pb_pkg::encode_type_bytes(._value(this.f62),
                                   ._stream(_stream));
      end
      if (this.f63.size()) begin
        pb_pkg::encode_message_key(._field_number(this.f63__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_DELIMITED),
                                   ._stream(_stream));
        pb_pkg::encode_type_bytes(._value(this.f63),
                                   ._stream(_stream));
      end
      foreach (this.f64[ii]) begin
        pb_pkg::encode_message_key(._field_number(this.f64__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_DELIMITED),
                                   ._stream(_stream));
        pb_pkg::encode_type_bytes(._value(this.f64[ii]),
                                   ._stream(_stream));
      end
      begin
        foreach (this.f65[xx]) begin
          pb_pkg::enc_bytestream_t f65_sub_stream;
          int unsigned found_key = xx;
          SubMessage found_value = this.f65[xx];
          begin
            pb_pkg::encode_message_key(._field_number(this.f65_key__field_number),
                                       ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                       ._stream(f65_sub_stream));
            pb_pkg::encode_type_uint32(._value(found_key), ._stream(f65_sub_stream));
          end
          if (found_value) begin
            pb_pkg::enc_bytestream_t sub_stream;
            found_value._serialize(._stream(sub_stream));
            pb_pkg::encode_delimited(._field_number(this.f65_value__field_number),
                                     ._delimited_stream(sub_stream),
                                     ._stream(f65_sub_stream));
          end
          pb_pkg::encode_delimited(._field_number(f65__field_number),
                                   ._delimited_stream(f65_sub_stream),
                                   ._stream(_stream));
        end
      end
      begin
        foreach (this.f66[xx]) begin
          pb_pkg::enc_bytestream_t f66_sub_stream;
          int unsigned found_key = xx;
          int unsigned found_value = this.f66[xx];
          begin
            pb_pkg::encode_message_key(._field_number(this.f66_key__field_number),
                                       ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                       ._stream(f66_sub_stream));
            pb_pkg::encode_type_uint32(._value(found_key), ._stream(f66_sub_stream));
          end
          begin
            pb_pkg::encode_message_key(._field_number(this.f66_value__field_number),
                                       ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                       ._stream(f66_sub_stream));
            pb_pkg::encode_type_uint32(._value(found_value), ._stream(f66_sub_stream));
          end
          pb_pkg::encode_delimited(._field_number(f66__field_number),
                                   ._delimited_stream(f66_sub_stream),
                                   ._stream(_stream));
        end
      end
      begin
        foreach (this.f67[xx]) begin
          pb_pkg::enc_bytestream_t f67_sub_stream;
          int unsigned found_key = xx;
          string found_value = this.f67[xx];
          begin
            pb_pkg::encode_message_key(._field_number(this.f67_key__field_number),
                                       ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                       ._stream(f67_sub_stream));
            pb_pkg::encode_type_uint32(._value(found_key), ._stream(f67_sub_stream));
          end
          if (found_value.len()) begin
            pb_pkg::encode_message_key(._field_number(this.f67_value__field_number),
                                       ._wire_type(pb_pkg::WIRE_TYPE_DELIMITED),
                                       ._stream(f67_sub_stream));
            pb_pkg::encode_type_string(._value(found_value),
                                       ._stream(f67_sub_stream));
          end
          pb_pkg::encode_delimited(._field_number(f67__field_number),
                                   ._delimited_stream(f67_sub_stream),
                                   ._stream(_stream));
        end
      end
      begin
        foreach (this.f68[xx]) begin
          pb_pkg::enc_bytestream_t f68_sub_stream;
          string found_key = xx;
          string found_value = this.f68[xx];
          if (found_key.len()) begin
            pb_pkg::encode_message_key(._field_number(this.f68_key__field_number),
                                       ._wire_type(pb_pkg::WIRE_TYPE_DELIMITED),
                                       ._stream(f68_sub_stream));
            pb_pkg::encode_type_string(._value(found_key),
                                       ._stream(f68_sub_stream));
          end
          if (found_value.len()) begin
            pb_pkg::encode_message_key(._field_number(this.f68_value__field_number),
                                       ._wire_type(pb_pkg::WIRE_TYPE_DELIMITED),
                                       ._stream(f68_sub_stream));
            pb_pkg::encode_type_string(._value(found_value),
                                       ._stream(f68_sub_stream));
          end
          pb_pkg::encode_delimited(._field_number(f68__field_number),
                                   ._delimited_stream(f68_sub_stream),
                                   ._stream(_stream));
        end
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
          ////////////////////////////////
          // f1
          f1__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_bool(._result(f1), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f2
          f2__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_bool(._result(f2), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.m_is_initialized["f2"] = 1;
          end
          ////////////////////////////////
          // f3
          f3__field_number: begin
            bit tmp_f3;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_bool(._result(tmp_f3), ._stream(_stream), ._cursor(_cursor)));
              this.f3.push_back(tmp_f3);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f4
          f4__field_number: begin
            bit tmp_f4;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_bool(._result(tmp_f4), ._stream(_stream), ._cursor(_cursor)));
              this.f4.push_back(tmp_f4);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f5
          f5__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_double(._result(f5), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f6
          f6__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_double(._result(f6), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.m_is_initialized["f6"] = 1;
          end
          ////////////////////////////////
          // f7
          f7__field_number: begin
            real tmp_f7;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_double(._result(tmp_f7), ._stream(_stream), ._cursor(_cursor)));
              this.f7.push_back(tmp_f7);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f8
          f8__field_number: begin
            real tmp_f8;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_double(._result(tmp_f8), ._stream(_stream), ._cursor(_cursor)));
              this.f8.push_back(tmp_f8);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f9
          f9__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_fixed32(._result(f9), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f10
          f10__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_fixed32(._result(f10), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.m_is_initialized["f10"] = 1;
          end
          ////////////////////////////////
          // f11
          f11__field_number: begin
            int unsigned tmp_f11;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_fixed32(._result(tmp_f11), ._stream(_stream), ._cursor(_cursor)));
              this.f11.push_back(tmp_f11);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f12
          f12__field_number: begin
            int unsigned tmp_f12;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_fixed32(._result(tmp_f12), ._stream(_stream), ._cursor(_cursor)));
              this.f12.push_back(tmp_f12);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f13
          f13__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_fixed64(._result(f13), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f14
          f14__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_fixed64(._result(f14), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.m_is_initialized["f14"] = 1;
          end
          ////////////////////////////////
          // f15
          f15__field_number: begin
            longint unsigned tmp_f15;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_fixed64(._result(tmp_f15), ._stream(_stream), ._cursor(_cursor)));
              this.f15.push_back(tmp_f15);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f16
          f16__field_number: begin
            longint unsigned tmp_f16;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_fixed64(._result(tmp_f16), ._stream(_stream), ._cursor(_cursor)));
              this.f16.push_back(tmp_f16);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f17
          f17__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_float(._result(f17), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f18
          f18__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_float(._result(f18), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.m_is_initialized["f18"] = 1;
          end
          ////////////////////////////////
          // f19
          f19__field_number: begin
            shortreal tmp_f19;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_float(._result(tmp_f19), ._stream(_stream), ._cursor(_cursor)));
              this.f19.push_back(tmp_f19);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f20
          f20__field_number: begin
            shortreal tmp_f20;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_float(._result(tmp_f20), ._stream(_stream), ._cursor(_cursor)));
              this.f20.push_back(tmp_f20);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f21
          f21__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_int32(._result(f21), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f22
          f22__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_int32(._result(f22), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.m_is_initialized["f22"] = 1;
          end
          ////////////////////////////////
          // f23
          f23__field_number: begin
            int tmp_f23;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_int32(._result(tmp_f23), ._stream(_stream), ._cursor(_cursor)));
              this.f23.push_back(tmp_f23);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f24
          f24__field_number: begin
            int tmp_f24;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_int32(._result(tmp_f24), ._stream(_stream), ._cursor(_cursor)));
              this.f24.push_back(tmp_f24);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f25
          f25__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_int64(._result(f25), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f26
          f26__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_int64(._result(f26), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.m_is_initialized["f26"] = 1;
          end
          ////////////////////////////////
          // f27
          f27__field_number: begin
            longint tmp_f27;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_int64(._result(tmp_f27), ._stream(_stream), ._cursor(_cursor)));
              this.f27.push_back(tmp_f27);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f28
          f28__field_number: begin
            longint tmp_f28;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_int64(._result(tmp_f28), ._stream(_stream), ._cursor(_cursor)));
              this.f28.push_back(tmp_f28);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f29
          f29__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_sfixed32(._result(f29), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f30
          f30__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_sfixed32(._result(f30), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.m_is_initialized["f30"] = 1;
          end
          ////////////////////////////////
          // f31
          f31__field_number: begin
            int tmp_f31;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_sfixed32(._result(tmp_f31), ._stream(_stream), ._cursor(_cursor)));
              this.f31.push_back(tmp_f31);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f32
          f32__field_number: begin
            int tmp_f32;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_sfixed32(._result(tmp_f32), ._stream(_stream), ._cursor(_cursor)));
              this.f32.push_back(tmp_f32);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f33
          f33__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_sfixed64(._result(f33), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f34
          f34__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_sfixed64(._result(f34), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.m_is_initialized["f34"] = 1;
          end
          ////////////////////////////////
          // f35
          f35__field_number: begin
            longint tmp_f35;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_sfixed64(._result(tmp_f35), ._stream(_stream), ._cursor(_cursor)));
              this.f35.push_back(tmp_f35);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f36
          f36__field_number: begin
            longint tmp_f36;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_sfixed64(._result(tmp_f36), ._stream(_stream), ._cursor(_cursor)));
              this.f36.push_back(tmp_f36);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f37
          f37__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_sint32(._result(f37), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f38
          f38__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_sint32(._result(f38), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.m_is_initialized["f38"] = 1;
          end
          ////////////////////////////////
          // f39
          f39__field_number: begin
            int tmp_f39;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_sint32(._result(tmp_f39), ._stream(_stream), ._cursor(_cursor)));
              this.f39.push_back(tmp_f39);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f40
          f40__field_number: begin
            int tmp_f40;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_sint32(._result(tmp_f40), ._stream(_stream), ._cursor(_cursor)));
              this.f40.push_back(tmp_f40);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f41
          f41__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_sint64(._result(f41), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f42
          f42__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_sint64(._result(f42), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.m_is_initialized["f42"] = 1;
          end
          ////////////////////////////////
          // f43
          f43__field_number: begin
            longint tmp_f43;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_sint64(._result(tmp_f43), ._stream(_stream), ._cursor(_cursor)));
              this.f43.push_back(tmp_f43);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f44
          f44__field_number: begin
            longint tmp_f44;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_sint64(._result(tmp_f44), ._stream(_stream), ._cursor(_cursor)));
              this.f44.push_back(tmp_f44);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f45
          f45__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_uint32(._result(f45), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f46
          f46__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_uint32(._result(f46), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.m_is_initialized["f46"] = 1;
          end
          ////////////////////////////////
          // f47
          f47__field_number: begin
            int unsigned tmp_f47;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_uint32(._result(tmp_f47), ._stream(_stream), ._cursor(_cursor)));
              this.f47.push_back(tmp_f47);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f48
          f48__field_number: begin
            int unsigned tmp_f48;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_uint32(._result(tmp_f48), ._stream(_stream), ._cursor(_cursor)));
              this.f48.push_back(tmp_f48);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f49
          f49__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_uint64(._result(f49), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f50
          f50__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_uint64(._result(f50), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.m_is_initialized["f50"] = 1;
          end
          ////////////////////////////////
          // f51
          f51__field_number: begin
            longint unsigned tmp_f51;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_uint64(._result(tmp_f51), ._stream(_stream), ._cursor(_cursor)));
              this.f51.push_back(tmp_f51);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f52
          f52__field_number: begin
            longint unsigned tmp_f52;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_uint64(._result(tmp_f52), ._stream(_stream), ._cursor(_cursor)));
              this.f52.push_back(tmp_f52);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f53
          f53__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              pb_pkg::varint_t tmp_varint;
              assert (!pb_pkg::decode_type_enum(._result(tmp_varint), ._stream(_stream), ._cursor(_cursor)));
              f53 = ExampleEnum'(tmp_varint);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f54
          f54__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              pb_pkg::varint_t tmp_varint;
              assert (!pb_pkg::decode_type_enum(._result(tmp_varint), ._stream(_stream), ._cursor(_cursor)));
              f54 = ExampleEnum'(tmp_varint);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.m_is_initialized["f54"] = 1;
          end
          ////////////////////////////////
          // f55
          f55__field_number: begin
            ExampleEnum tmp_f55;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              pb_pkg::varint_t tmp_varint;
              assert (!pb_pkg::decode_type_enum(._result(tmp_varint), ._stream(_stream), ._cursor(_cursor)));
              tmp_f55 = ExampleEnum'(tmp_varint);
              this.f55.push_back(tmp_f55);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          ////////////////////////////////
          // f56
          f56__field_number: begin
            assert (wire_type == pb_pkg::WIRE_TYPE_DELIMITED);
            assert (!pb_pkg::decode_type_string(._result(f56), ._stream(_stream), ._cursor(_cursor), ._str_length(delimited_length)));
          end
          ////////////////////////////////
          // f57
          f57__field_number: begin
            assert (wire_type == pb_pkg::WIRE_TYPE_DELIMITED);
            assert (!pb_pkg::decode_type_string(._result(f57), ._stream(_stream), ._cursor(_cursor), ._str_length(delimited_length)));
            this.m_is_initialized["f57"] = 1;
          end
          ////////////////////////////////
          // f58
          f58__field_number: begin
            string tmp_f58;
            assert (wire_type == pb_pkg::WIRE_TYPE_DELIMITED);
            assert (!pb_pkg::decode_type_string(._result(tmp_f58), ._stream(_stream), ._cursor(_cursor), ._str_length(delimited_length)));
            this.f58.push_back(tmp_f58);
          end
          ////////////////////////////////
          // f59
          f59__field_number: begin
            assert (wire_type == pb_pkg::WIRE_TYPE_DELIMITED);
            f59 = SubMessage::type_id::create();
            f59._deserialize(._stream(_stream), ._cursor(_cursor), ._cursor_stop(_cursor + delimited_length));
          end
          ////////////////////////////////
          // f60
          f60__field_number: begin
            assert (wire_type == pb_pkg::WIRE_TYPE_DELIMITED);
            f60 = SubMessage::type_id::create();
            f60._deserialize(._stream(_stream), ._cursor(_cursor), ._cursor_stop(_cursor + delimited_length));
          end
          ////////////////////////////////
          // f61
          f61__field_number: begin
            SubMessage tmp_f61;
            assert (wire_type == pb_pkg::WIRE_TYPE_DELIMITED);
            tmp_f61 = SubMessage::type_id::create();
            tmp_f61._deserialize(._stream(_stream), ._cursor(_cursor), ._cursor_stop(_cursor + delimited_length));
            this.f61.push_back(tmp_f61);
          end
          ////////////////////////////////
          // f62
          f62__field_number: begin
            assert (wire_type == pb_pkg::WIRE_TYPE_DELIMITED);
            assert (!pb_pkg::decode_type_bytes(._result(f62), ._stream(_stream), ._cursor(_cursor), ._str_length(delimited_length)));
          end
          ////////////////////////////////
          // f63
          f63__field_number: begin
            assert (wire_type == pb_pkg::WIRE_TYPE_DELIMITED);
            assert (!pb_pkg::decode_type_bytes(._result(f63), ._stream(_stream), ._cursor(_cursor), ._str_length(delimited_length)));
            this.m_is_initialized["f63"] = 1;
          end
          ////////////////////////////////
          // f64
          f64__field_number: begin
            pb_pkg::bytestream_t tmp_f64;
            assert (wire_type == pb_pkg::WIRE_TYPE_DELIMITED);
            assert (!pb_pkg::decode_type_bytes(._result(tmp_f64), ._stream(_stream), ._cursor(_cursor), ._str_length(delimited_length)));
            this.f64.push_back(tmp_f64);
          end
          ////////////////////////////////
          // f65
          f65__field_number: begin
              int unsigned found_key;
              SubMessage found_value;
              assert (wire_type == pb_pkg::WIRE_TYPE_DELIMITED);
              while ((_cursor < stream_size) && (_cursor < delimited_stop)) begin
                assert (!pb_pkg::decode_message_key(._field_number(field_number),
                                                    ._wire_type(wire_type),
                                                    ._stream(_stream),
                                                    ._cursor(_cursor)));
                if (wire_type == pb_pkg::WIRE_TYPE_DELIMITED) begin
                    assert (!pb_pkg::decode_varint(._value(delimited_length),
                                                   ._stream(_stream),
                                                   ._cursor(_cursor)));
                end
                case (field_number)
                  ////////////////////////////////
                  // key
                  f65_key__field_number: begin
                    assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
                    do begin
                      assert (!pb_pkg::decode_type_uint32(._result(found_key), ._stream(_stream), ._cursor(_cursor)));
                    end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
                  end
                  ////////////////////////////////
                  // value
                  f65_value__field_number: begin
                    assert (wire_type == pb_pkg::WIRE_TYPE_DELIMITED);
                    found_value = SubMessage::type_id::create();
                    found_value._deserialize(._stream(_stream), ._cursor(_cursor), ._cursor_stop(_cursor + delimited_length));
                  end
                  default : assert (!pb_pkg::decode_and_consume_unknown(._wire_type(wire_type), ._stream(_stream), ._cursor(_cursor), ._delimited_length(delimited_length)));
                endcase
              end
              f65[found_key] = found_value;
          end
          ////////////////////////////////
          // f66
          f66__field_number: begin
              int unsigned found_key;
              int unsigned found_value;
              assert (wire_type == pb_pkg::WIRE_TYPE_DELIMITED);
              while ((_cursor < stream_size) && (_cursor < delimited_stop)) begin
                assert (!pb_pkg::decode_message_key(._field_number(field_number),
                                                    ._wire_type(wire_type),
                                                    ._stream(_stream),
                                                    ._cursor(_cursor)));
                if (wire_type == pb_pkg::WIRE_TYPE_DELIMITED) begin
                    assert (!pb_pkg::decode_varint(._value(delimited_length),
                                                   ._stream(_stream),
                                                   ._cursor(_cursor)));
                end
                case (field_number)
                  ////////////////////////////////
                  // key
                  f66_key__field_number: begin
                    assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
                    do begin
                      assert (!pb_pkg::decode_type_uint32(._result(found_key), ._stream(_stream), ._cursor(_cursor)));
                    end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
                  end
                  ////////////////////////////////
                  // value
                  f66_value__field_number: begin
                    assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
                    do begin
                      assert (!pb_pkg::decode_type_uint32(._result(found_value), ._stream(_stream), ._cursor(_cursor)));
                    end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
                  end
                  default : assert (!pb_pkg::decode_and_consume_unknown(._wire_type(wire_type), ._stream(_stream), ._cursor(_cursor), ._delimited_length(delimited_length)));
                endcase
              end
              f66[found_key] = found_value;
          end
          ////////////////////////////////
          // f67
          f67__field_number: begin
              int unsigned found_key;
              string found_value;
              assert (wire_type == pb_pkg::WIRE_TYPE_DELIMITED);
              while ((_cursor < stream_size) && (_cursor < delimited_stop)) begin
                assert (!pb_pkg::decode_message_key(._field_number(field_number),
                                                    ._wire_type(wire_type),
                                                    ._stream(_stream),
                                                    ._cursor(_cursor)));
                if (wire_type == pb_pkg::WIRE_TYPE_DELIMITED) begin
                    assert (!pb_pkg::decode_varint(._value(delimited_length),
                                                   ._stream(_stream),
                                                   ._cursor(_cursor)));
                end
                case (field_number)
                  ////////////////////////////////
                  // key
                  f67_key__field_number: begin
                    assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
                    do begin
                      assert (!pb_pkg::decode_type_uint32(._result(found_key), ._stream(_stream), ._cursor(_cursor)));
                    end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
                  end
                  ////////////////////////////////
                  // value
                  f67_value__field_number: begin
                    assert (wire_type == pb_pkg::WIRE_TYPE_DELIMITED);
                    assert (!pb_pkg::decode_type_string(._result(found_value), ._stream(_stream), ._cursor(_cursor), ._str_length(delimited_length)));
                  end
                  default : assert (!pb_pkg::decode_and_consume_unknown(._wire_type(wire_type), ._stream(_stream), ._cursor(_cursor), ._delimited_length(delimited_length)));
                endcase
              end
              f67[found_key] = found_value;
          end
          ////////////////////////////////
          // f68
          f68__field_number: begin
              string found_key;
              string found_value;
              assert (wire_type == pb_pkg::WIRE_TYPE_DELIMITED);
              while ((_cursor < stream_size) && (_cursor < delimited_stop)) begin
                assert (!pb_pkg::decode_message_key(._field_number(field_number),
                                                    ._wire_type(wire_type),
                                                    ._stream(_stream),
                                                    ._cursor(_cursor)));
                if (wire_type == pb_pkg::WIRE_TYPE_DELIMITED) begin
                    assert (!pb_pkg::decode_varint(._value(delimited_length),
                                                   ._stream(_stream),
                                                   ._cursor(_cursor)));
                end
                case (field_number)
                  ////////////////////////////////
                  // key
                  f68_key__field_number: begin
                    assert (wire_type == pb_pkg::WIRE_TYPE_DELIMITED);
                    assert (!pb_pkg::decode_type_string(._result(found_key), ._stream(_stream), ._cursor(_cursor), ._str_length(delimited_length)));
                  end
                  ////////////////////////////////
                  // value
                  f68_value__field_number: begin
                    assert (wire_type == pb_pkg::WIRE_TYPE_DELIMITED);
                    assert (!pb_pkg::decode_type_string(._result(found_value), ._stream(_stream), ._cursor(_cursor), ._str_length(delimited_length)));
                  end
                  default : assert (!pb_pkg::decode_and_consume_unknown(._wire_type(wire_type), ._stream(_stream), ._cursor(_cursor), ._delimited_length(delimited_length)));
                endcase
              end
              f68[found_key] = found_value;
          end
          default : assert (!pb_pkg::decode_and_consume_unknown(._wire_type(wire_type), ._stream(_stream), ._cursor(_cursor), ._delimited_length(delimited_length)));
        endcase
        if (wire_type == pb_pkg::WIRE_TYPE_DELIMITED) begin
          assert (_cursor == delimited_stop) else $display("_cursor: %0d delimited_stop: %0d", _cursor, delimited_stop);
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
      if (this.f60 == null) begin
        `uvm_warning(this.get_name(), "required field 'f60' is null")
        is_initialized = 0;
      end
      else begin
        is_initialized &= this.f60.is_initialized();
      end
    endfunction : is_initialized

    function void post_randomize();
      this.m_is_initialized["f2"] = 1;
      this.m_is_initialized["f6"] = 1;
      this.m_is_initialized["f10"] = 1;
      this.m_is_initialized["f14"] = 1;
      this.m_is_initialized["f18"] = 1;
      this.m_is_initialized["f22"] = 1;
      this.m_is_initialized["f26"] = 1;
      this.m_is_initialized["f30"] = 1;
      this.m_is_initialized["f34"] = 1;
      this.m_is_initialized["f38"] = 1;
      this.m_is_initialized["f42"] = 1;
      this.m_is_initialized["f46"] = 1;
      this.m_is_initialized["f50"] = 1;
      this.m_is_initialized["f54"] = 1;
      this.m_is_initialized["f57"] = 1;
      this.m_is_initialized["f63"] = 1;
    endfunction : post_randomize

  virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    bit res;
    Hello rhs_cast;
    $cast(rhs_cast, rhs);
    res = super.do_compare(rhs, comparer);
  res &= (this.f1 == rhs_cast.f1);
  res &= (this.f2 == rhs_cast.f2);
  res &= (this.f3 == rhs_cast.f3);
  res &= (this.f4 == rhs_cast.f4);
  res &= (this.f5 == rhs_cast.f5);
  res &= (this.f6 == rhs_cast.f6);
  res &= (this.f7 == rhs_cast.f7);
  res &= (this.f8 == rhs_cast.f8);
  res &= (this.f9 == rhs_cast.f9);
  res &= (this.f10 == rhs_cast.f10);
  res &= (this.f11 == rhs_cast.f11);
  res &= (this.f12 == rhs_cast.f12);
  res &= (this.f13 == rhs_cast.f13);
  res &= (this.f14 == rhs_cast.f14);
  res &= (this.f15 == rhs_cast.f15);
  res &= (this.f16 == rhs_cast.f16);
  res &= (this.f17 == rhs_cast.f17);
  res &= (this.f18 == rhs_cast.f18);
  res &= (this.f19 == rhs_cast.f19);
  res &= (this.f20 == rhs_cast.f20);
  res &= (this.f21 == rhs_cast.f21);
  res &= (this.f22 == rhs_cast.f22);
  res &= (this.f23 == rhs_cast.f23);
  res &= (this.f24 == rhs_cast.f24);
  res &= (this.f25 == rhs_cast.f25);
  res &= (this.f26 == rhs_cast.f26);
  res &= (this.f27 == rhs_cast.f27);
  res &= (this.f28 == rhs_cast.f28);
  res &= (this.f29 == rhs_cast.f29);
  res &= (this.f30 == rhs_cast.f30);
  res &= (this.f31 == rhs_cast.f31);
  res &= (this.f32 == rhs_cast.f32);
  res &= (this.f33 == rhs_cast.f33);
  res &= (this.f34 == rhs_cast.f34);
  res &= (this.f35 == rhs_cast.f35);
  res &= (this.f36 == rhs_cast.f36);
  res &= (this.f37 == rhs_cast.f37);
  res &= (this.f38 == rhs_cast.f38);
  res &= (this.f39 == rhs_cast.f39);
  res &= (this.f40 == rhs_cast.f40);
  res &= (this.f41 == rhs_cast.f41);
  res &= (this.f42 == rhs_cast.f42);
  res &= (this.f43 == rhs_cast.f43);
  res &= (this.f44 == rhs_cast.f44);
  res &= (this.f45 == rhs_cast.f45);
  res &= (this.f46 == rhs_cast.f46);
  res &= (this.f47 == rhs_cast.f47);
  res &= (this.f48 == rhs_cast.f48);
  res &= (this.f49 == rhs_cast.f49);
  res &= (this.f50 == rhs_cast.f50);
  res &= (this.f51 == rhs_cast.f51);
  res &= (this.f52 == rhs_cast.f52);
  res &= (this.f53 == rhs_cast.f53);
  res &= (this.f54 == rhs_cast.f54);
  res &= (this.f55 == rhs_cast.f55);
  res &= (this.f56 == rhs_cast.f56);
  res &= (this.f57 == rhs_cast.f57);
  res &= (this.f58 == rhs_cast.f58);
    if ((this.f59 != null) && (rhs_cast.f59 != null)) begin
      res &= this.f59.do_compare(rhs_cast.f59, comparer);
    end else begin
      if ((this.f59 != null) || (rhs_cast.f59 != null)) begin
        res = 0;
      end
    end
    if ((this.f60 != null) && (rhs_cast.f60 != null)) begin
      res &= this.f60.do_compare(rhs_cast.f60, comparer);
    end else begin
      if ((this.f60 != null) || (rhs_cast.f60 != null)) begin
        res = 0;
      end
    end
  res &= (this.f61.size() == rhs_cast.f61.size());
  foreach (this.f61[xx]) begin
    if ((this.f61[xx] != null) && (rhs_cast.f61[xx] != null)) begin
      res &= this.f61[xx].do_compare(rhs_cast.f61[xx], comparer);
    end else begin
      if ((this.f61[xx] != null) || (rhs_cast.f61[xx] != null)) begin
        res = 0;
      end
    end
  end
  res &= (this.f62 == rhs_cast.f62);
  res &= (this.f63 == rhs_cast.f63);
  res &= (this.f64 == rhs_cast.f64);
    res &= (this.f65.size() == rhs_cast.f65.size());
    foreach (this.f65[xx]) begin
      if (!rhs_cast.f65.exists(xx)) begin
        res = 0;
      end
      else begin
          if ((this.f65[xx] != null) && (rhs_cast.f65[xx] != null)) begin
            res &= this.f65[xx].do_compare(rhs_cast.f65[xx], comparer);
          end else begin
            if ((this.f65[xx] != null) || (rhs_cast.f65[xx] != null)) begin
              res = 0;
            end
          end
      end
    end
    res &= (this.f66.size() == rhs_cast.f66.size());
    foreach (this.f66[xx]) begin
      if (!rhs_cast.f66.exists(xx)) begin
        res = 0;
      end
      else begin
        res &= (this.f66[xx] == rhs_cast.f66[xx]);
      end
    end
    res &= (this.f67.size() == rhs_cast.f67.size());
    foreach (this.f67[xx]) begin
      if (!rhs_cast.f67.exists(xx)) begin
        res = 0;
      end
      else begin
        res &= (this.f67[xx] == rhs_cast.f67[xx]);
      end
    end
    res &= (this.f68.size() == rhs_cast.f68.size());
    foreach (this.f68[xx]) begin
      if (!rhs_cast.f68.exists(xx)) begin
        res = 0;
      end
      else begin
        res &= (this.f68[xx] == rhs_cast.f68[xx]);
      end
    end
    return res;
  endfunction : do_compare

  virtual function void do_print( uvm_printer printer );
    super.do_print( printer );
      printer.print_field_int("f1", this.f1, 1, UVM_BIN);
      printer.print_field_int("f2", this.f2, 1, UVM_BIN);
    printer.print_array_header("this.f3", this.f3.size());
    foreach(this.f3[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f3[xx], 1, UVM_BIN);
    end
    printer.print_array_footer(this.f3.size());
    printer.print_array_header("this.f4", this.f4.size());
    foreach(this.f4[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f4[xx], 1, UVM_BIN);
    end
    printer.print_array_footer(this.f4.size());
      printer.print_real("f5", this.f5);
      printer.print_real("f6", this.f6);
    printer.print_array_header("this.f7", this.f7.size());
    foreach(this.f7[xx]) begin
      printer.print_real($sformatf("%0d", xx), this.f7[xx]);
    end
    printer.print_array_footer(this.f7.size());
    printer.print_array_header("this.f8", this.f8.size());
    foreach(this.f8[xx]) begin
      printer.print_real($sformatf("%0d", xx), this.f8[xx]);
    end
    printer.print_array_footer(this.f8.size());
      printer.print_field_int("f9", this.f9, 32, UVM_DEC);
      printer.print_field_int("f10", this.f10, 32, UVM_DEC);
    printer.print_array_header("this.f11", this.f11.size());
    foreach(this.f11[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f11[xx], 32, UVM_DEC);
    end
    printer.print_array_footer(this.f11.size());
    printer.print_array_header("this.f12", this.f12.size());
    foreach(this.f12[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f12[xx], 32, UVM_DEC);
    end
    printer.print_array_footer(this.f12.size());
      printer.print_field_int("f13", this.f13, 64, UVM_DEC);
      printer.print_field_int("f14", this.f14, 64, UVM_DEC);
    printer.print_array_header("this.f15", this.f15.size());
    foreach(this.f15[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f15[xx], 64, UVM_DEC);
    end
    printer.print_array_footer(this.f15.size());
    printer.print_array_header("this.f16", this.f16.size());
    foreach(this.f16[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f16[xx], 64, UVM_DEC);
    end
    printer.print_array_footer(this.f16.size());
      printer.print_real("f17", this.f17);
      printer.print_real("f18", this.f18);
    printer.print_array_header("this.f19", this.f19.size());
    foreach(this.f19[xx]) begin
      printer.print_real($sformatf("%0d", xx), this.f19[xx]);
    end
    printer.print_array_footer(this.f19.size());
    printer.print_array_header("this.f20", this.f20.size());
    foreach(this.f20[xx]) begin
      printer.print_real($sformatf("%0d", xx), this.f20[xx]);
    end
    printer.print_array_footer(this.f20.size());
      printer.print_field_int("f21", this.f21, 32, UVM_DEC);
      printer.print_field_int("f22", this.f22, 32, UVM_DEC);
    printer.print_array_header("this.f23", this.f23.size());
    foreach(this.f23[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f23[xx], 32, UVM_DEC);
    end
    printer.print_array_footer(this.f23.size());
    printer.print_array_header("this.f24", this.f24.size());
    foreach(this.f24[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f24[xx], 32, UVM_DEC);
    end
    printer.print_array_footer(this.f24.size());
      printer.print_field_int("f25", this.f25, 64, UVM_DEC);
      printer.print_field_int("f26", this.f26, 64, UVM_DEC);
    printer.print_array_header("this.f27", this.f27.size());
    foreach(this.f27[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f27[xx], 64, UVM_DEC);
    end
    printer.print_array_footer(this.f27.size());
    printer.print_array_header("this.f28", this.f28.size());
    foreach(this.f28[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f28[xx], 64, UVM_DEC);
    end
    printer.print_array_footer(this.f28.size());
      printer.print_field_int("f29", this.f29, 32, UVM_DEC);
      printer.print_field_int("f30", this.f30, 32, UVM_DEC);
    printer.print_array_header("this.f31", this.f31.size());
    foreach(this.f31[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f31[xx], 32, UVM_DEC);
    end
    printer.print_array_footer(this.f31.size());
    printer.print_array_header("this.f32", this.f32.size());
    foreach(this.f32[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f32[xx], 32, UVM_DEC);
    end
    printer.print_array_footer(this.f32.size());
      printer.print_field_int("f33", this.f33, 64, UVM_DEC);
      printer.print_field_int("f34", this.f34, 64, UVM_DEC);
    printer.print_array_header("this.f35", this.f35.size());
    foreach(this.f35[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f35[xx], 64, UVM_DEC);
    end
    printer.print_array_footer(this.f35.size());
    printer.print_array_header("this.f36", this.f36.size());
    foreach(this.f36[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f36[xx], 64, UVM_DEC);
    end
    printer.print_array_footer(this.f36.size());
      printer.print_field_int("f37", this.f37, 32, UVM_DEC);
      printer.print_field_int("f38", this.f38, 32, UVM_DEC);
    printer.print_array_header("this.f39", this.f39.size());
    foreach(this.f39[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f39[xx], 32, UVM_DEC);
    end
    printer.print_array_footer(this.f39.size());
    printer.print_array_header("this.f40", this.f40.size());
    foreach(this.f40[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f40[xx], 32, UVM_DEC);
    end
    printer.print_array_footer(this.f40.size());
      printer.print_field_int("f41", this.f41, 64, UVM_DEC);
      printer.print_field_int("f42", this.f42, 64, UVM_DEC);
    printer.print_array_header("this.f43", this.f43.size());
    foreach(this.f43[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f43[xx], 64, UVM_DEC);
    end
    printer.print_array_footer(this.f43.size());
    printer.print_array_header("this.f44", this.f44.size());
    foreach(this.f44[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f44[xx], 64, UVM_DEC);
    end
    printer.print_array_footer(this.f44.size());
      printer.print_field_int("f45", this.f45, 32, UVM_HEX);
      printer.print_field_int("f46", this.f46, 32, UVM_HEX);
    printer.print_array_header("this.f47", this.f47.size());
    foreach(this.f47[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f47[xx], 32, UVM_HEX);
    end
    printer.print_array_footer(this.f47.size());
    printer.print_array_header("this.f48", this.f48.size());
    foreach(this.f48[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f48[xx], 32, UVM_HEX);
    end
    printer.print_array_footer(this.f48.size());
      printer.print_field_int("f49", this.f49, 64, UVM_HEX);
      printer.print_field_int("f50", this.f50, 64, UVM_HEX);
    printer.print_array_header("this.f51", this.f51.size());
    foreach(this.f51[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f51[xx], 64, UVM_HEX);
    end
    printer.print_array_footer(this.f51.size());
    printer.print_array_header("this.f52", this.f52.size());
    foreach(this.f52[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f52[xx], 64, UVM_HEX);
    end
    printer.print_array_footer(this.f52.size());
      printer.print_field_int("f53", this.f53, 32, UVM_ENUM);
      printer.print_field_int("f54", this.f54, 32, UVM_ENUM);
    printer.print_array_header("this.f55", this.f55.size());
    foreach(this.f55[xx]) begin
      printer.print_field_int($sformatf("%0d", xx), this.f55[xx], 32, UVM_ENUM);
    end
    printer.print_array_footer(this.f55.size());
      printer.print_string("f56", this.f56);
      printer.print_string("f57", this.f57);
    printer.print_array_header("this.f58", this.f58.size());
    foreach(this.f58[xx]) begin
      printer.print_string($sformatf("%0d", xx), this.f58[xx]);
    end
    printer.print_array_footer(this.f58.size());
      printer.print_object("f59", this.f59);
      printer.print_object("f60", this.f60);
    printer.print_array_header("this.f61", this.f61.size());
    foreach(this.f61[xx]) begin
      printer.print_object($sformatf("%0d", xx), this.f61[xx]);
    end
    printer.print_array_footer(this.f61.size());
      printer.print_generic("f62", "bytes", this.f62.size(), $sformatf("%p", this.f62));
      printer.print_generic("f63", "bytes", this.f63.size(), $sformatf("%p", this.f63));
    printer.print_array_header("this.f64", this.f64.size());
    foreach(this.f64[xx]) begin
      printer.print_generic($sformatf("%0d", xx), "bytes", this.f64[xx].size(), $sformatf("%p", this.f64[xx]));
    end
    printer.print_array_footer(this.f64.size());
    printer.print_array_header("this.f65", this.f65.size());
    foreach(this.f65[xx]) begin
          printer.print_field_int("key", xx, 32, UVM_HEX);
          printer.print_object("value", f65[xx]);
    end
    printer.print_array_footer(this.f65.size());
    printer.print_array_header("this.f66", this.f66.size());
    foreach(this.f66[xx]) begin
          printer.print_field_int("key", xx, 32, UVM_HEX);
          printer.print_field_int("value", f66[xx], 32, UVM_HEX);
    end
    printer.print_array_footer(this.f66.size());
    printer.print_array_header("this.f67", this.f67.size());
    foreach(this.f67[xx]) begin
          printer.print_field_int("key", xx, 32, UVM_HEX);
          printer.print_string("value", f67[xx]);
    end
    printer.print_array_footer(this.f67.size());
    printer.print_array_header("this.f68", this.f68.size());
    foreach(this.f68[xx]) begin
          printer.print_string("key", xx);
          printer.print_string("value", f68[xx]);
    end
    printer.print_array_footer(this.f68.size());
  endfunction : do_print

  endclass : Hello


  `include "uvm_macros.svh"
  import uvm_pkg::*;

