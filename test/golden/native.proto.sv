  `include "uvm_macros.svh"
  import uvm_pkg::*;

  class Hello extends uvm_object;

    rand bit bool_0;
    rand bit bool_1;
    rand bit bool_2[$];
    rand bit bool_3[$];
    `pb_real_rand real double_0;
    `pb_real_rand real double_1;
    `pb_real_rand real double_2[$];
    `pb_real_rand real double_3[$];
    rand int unsigned fixed32_0;
    rand int unsigned fixed32_1;
    rand int unsigned fixed32_2[$];
    rand int unsigned fixed32_3[$];
    rand longint unsigned fixed64_0;
    rand longint unsigned fixed64_1;
    rand longint unsigned fixed64_2[$];
    rand longint unsigned fixed64_3[$];
    `pb_real_rand shortreal float_0;
    `pb_real_rand shortreal float_1;
    `pb_real_rand shortreal float_2[$];
    `pb_real_rand shortreal float_3[$];
    rand int int32_0;
    rand int int32_1;
    rand int int32_2[$];
    rand int int32_3[$];
    rand longint int64_0;
    rand longint int64_1;
    rand longint int64_2[$];
    rand longint int64_3[$];
    rand int sfixed32_0;
    rand int sfixed32_1;
    rand int sfixed32_2[$];
    rand int sfixed32_3[$];
    rand longint sfixed64_0;
    rand longint sfixed64_1;
    rand longint sfixed64_2[$];
    rand longint sfixed64_3[$];
    rand int sint32_0;
    rand int sint32_1;
    rand int sint32_2[$];
    rand int sint32_3[$];
    rand longint sint64_0;
    rand longint sint64_1;
    rand longint sint64_2[$];
    rand longint sint64_3[$];
    rand int unsigned uint32_0;
    rand int unsigned uint32_1;
    rand int unsigned uint32_2[$];
    rand int unsigned uint32_3[$];
    rand longint unsigned uint64_0;
    rand longint unsigned uint64_1;
    rand longint unsigned uint64_2[$];
    rand longint unsigned uint64_3[$];

    local const pb_pkg::field_number_t bool_0__field_number = 1;
    local const pb_pkg::field_number_t bool_1__field_number = 2;
    local const pb_pkg::field_number_t bool_2__field_number = 3;
    local const pb_pkg::field_number_t bool_3__field_number = 4;
    local const pb_pkg::field_number_t double_0__field_number = 5;
    local const pb_pkg::field_number_t double_1__field_number = 6;
    local const pb_pkg::field_number_t double_2__field_number = 7;
    local const pb_pkg::field_number_t double_3__field_number = 8;
    local const pb_pkg::field_number_t fixed32_0__field_number = 9;
    local const pb_pkg::field_number_t fixed32_1__field_number = 10;
    local const pb_pkg::field_number_t fixed32_2__field_number = 11;
    local const pb_pkg::field_number_t fixed32_3__field_number = 12;
    local const pb_pkg::field_number_t fixed64_0__field_number = 13;
    local const pb_pkg::field_number_t fixed64_1__field_number = 14;
    local const pb_pkg::field_number_t fixed64_2__field_number = 15;
    local const pb_pkg::field_number_t fixed64_3__field_number = 16;
    local const pb_pkg::field_number_t float_0__field_number = 17;
    local const pb_pkg::field_number_t float_1__field_number = 18;
    local const pb_pkg::field_number_t float_2__field_number = 19;
    local const pb_pkg::field_number_t float_3__field_number = 20;
    local const pb_pkg::field_number_t int32_0__field_number = 21;
    local const pb_pkg::field_number_t int32_1__field_number = 22;
    local const pb_pkg::field_number_t int32_2__field_number = 23;
    local const pb_pkg::field_number_t int32_3__field_number = 24;
    local const pb_pkg::field_number_t int64_0__field_number = 25;
    local const pb_pkg::field_number_t int64_1__field_number = 26;
    local const pb_pkg::field_number_t int64_2__field_number = 27;
    local const pb_pkg::field_number_t int64_3__field_number = 28;
    local const pb_pkg::field_number_t sfixed32_0__field_number = 29;
    local const pb_pkg::field_number_t sfixed32_1__field_number = 30;
    local const pb_pkg::field_number_t sfixed32_2__field_number = 31;
    local const pb_pkg::field_number_t sfixed32_3__field_number = 32;
    local const pb_pkg::field_number_t sfixed64_0__field_number = 33;
    local const pb_pkg::field_number_t sfixed64_1__field_number = 34;
    local const pb_pkg::field_number_t sfixed64_2__field_number = 35;
    local const pb_pkg::field_number_t sfixed64_3__field_number = 36;
    local const pb_pkg::field_number_t sint32_0__field_number = 37;
    local const pb_pkg::field_number_t sint32_1__field_number = 38;
    local const pb_pkg::field_number_t sint32_2__field_number = 39;
    local const pb_pkg::field_number_t sint32_3__field_number = 40;
    local const pb_pkg::field_number_t sint64_0__field_number = 41;
    local const pb_pkg::field_number_t sint64_1__field_number = 42;
    local const pb_pkg::field_number_t sint64_2__field_number = 43;
    local const pb_pkg::field_number_t sint64_3__field_number = 44;
    local const pb_pkg::field_number_t uint32_0__field_number = 45;
    local const pb_pkg::field_number_t uint32_1__field_number = 46;
    local const pb_pkg::field_number_t uint32_2__field_number = 47;
    local const pb_pkg::field_number_t uint32_3__field_number = 48;
    local const pb_pkg::field_number_t uint64_0__field_number = 49;
    local const pb_pkg::field_number_t uint64_1__field_number = 50;
    local const pb_pkg::field_number_t uint64_2__field_number = 51;
    local const pb_pkg::field_number_t uint64_3__field_number = 52;

    local const pb_pkg::label_e bool_0__label = pb_pkg::LABEL_OPTIONAL;
    local const pb_pkg::label_e bool_1__label = pb_pkg::LABEL_REQUIRED;
    local const pb_pkg::label_e bool_2__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e bool_3__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e double_0__label = pb_pkg::LABEL_OPTIONAL;
    local const pb_pkg::label_e double_1__label = pb_pkg::LABEL_REQUIRED;
    local const pb_pkg::label_e double_2__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e double_3__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e fixed32_0__label = pb_pkg::LABEL_OPTIONAL;
    local const pb_pkg::label_e fixed32_1__label = pb_pkg::LABEL_REQUIRED;
    local const pb_pkg::label_e fixed32_2__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e fixed32_3__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e fixed64_0__label = pb_pkg::LABEL_OPTIONAL;
    local const pb_pkg::label_e fixed64_1__label = pb_pkg::LABEL_REQUIRED;
    local const pb_pkg::label_e fixed64_2__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e fixed64_3__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e float_0__label = pb_pkg::LABEL_OPTIONAL;
    local const pb_pkg::label_e float_1__label = pb_pkg::LABEL_REQUIRED;
    local const pb_pkg::label_e float_2__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e float_3__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e int32_0__label = pb_pkg::LABEL_OPTIONAL;
    local const pb_pkg::label_e int32_1__label = pb_pkg::LABEL_REQUIRED;
    local const pb_pkg::label_e int32_2__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e int32_3__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e int64_0__label = pb_pkg::LABEL_OPTIONAL;
    local const pb_pkg::label_e int64_1__label = pb_pkg::LABEL_REQUIRED;
    local const pb_pkg::label_e int64_2__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e int64_3__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e sfixed32_0__label = pb_pkg::LABEL_OPTIONAL;
    local const pb_pkg::label_e sfixed32_1__label = pb_pkg::LABEL_REQUIRED;
    local const pb_pkg::label_e sfixed32_2__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e sfixed32_3__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e sfixed64_0__label = pb_pkg::LABEL_OPTIONAL;
    local const pb_pkg::label_e sfixed64_1__label = pb_pkg::LABEL_REQUIRED;
    local const pb_pkg::label_e sfixed64_2__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e sfixed64_3__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e sint32_0__label = pb_pkg::LABEL_OPTIONAL;
    local const pb_pkg::label_e sint32_1__label = pb_pkg::LABEL_REQUIRED;
    local const pb_pkg::label_e sint32_2__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e sint32_3__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e sint64_0__label = pb_pkg::LABEL_OPTIONAL;
    local const pb_pkg::label_e sint64_1__label = pb_pkg::LABEL_REQUIRED;
    local const pb_pkg::label_e sint64_2__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e sint64_3__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e uint32_0__label = pb_pkg::LABEL_OPTIONAL;
    local const pb_pkg::label_e uint32_1__label = pb_pkg::LABEL_REQUIRED;
    local const pb_pkg::label_e uint32_2__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e uint32_3__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e uint64_0__label = pb_pkg::LABEL_OPTIONAL;
    local const pb_pkg::label_e uint64_1__label = pb_pkg::LABEL_REQUIRED;
    local const pb_pkg::label_e uint64_2__label = pb_pkg::LABEL_REPEATED;
    local const pb_pkg::label_e uint64_3__label = pb_pkg::LABEL_REPEATED;

    bit bool_0__is_initialized = 0;
    bit bool_1__is_initialized = 0;
    bit bool_2__is_initialized = 0;
    bit bool_3__is_initialized = 0;
    bit double_0__is_initialized = 0;
    bit double_1__is_initialized = 0;
    bit double_2__is_initialized = 0;
    bit double_3__is_initialized = 0;
    bit fixed32_0__is_initialized = 0;
    bit fixed32_1__is_initialized = 0;
    bit fixed32_2__is_initialized = 0;
    bit fixed32_3__is_initialized = 0;
    bit fixed64_0__is_initialized = 0;
    bit fixed64_1__is_initialized = 0;
    bit fixed64_2__is_initialized = 0;
    bit fixed64_3__is_initialized = 0;
    bit float_0__is_initialized = 0;
    bit float_1__is_initialized = 0;
    bit float_2__is_initialized = 0;
    bit float_3__is_initialized = 0;
    bit int32_0__is_initialized = 0;
    bit int32_1__is_initialized = 0;
    bit int32_2__is_initialized = 0;
    bit int32_3__is_initialized = 0;
    bit int64_0__is_initialized = 0;
    bit int64_1__is_initialized = 0;
    bit int64_2__is_initialized = 0;
    bit int64_3__is_initialized = 0;
    bit sfixed32_0__is_initialized = 0;
    bit sfixed32_1__is_initialized = 0;
    bit sfixed32_2__is_initialized = 0;
    bit sfixed32_3__is_initialized = 0;
    bit sfixed64_0__is_initialized = 0;
    bit sfixed64_1__is_initialized = 0;
    bit sfixed64_2__is_initialized = 0;
    bit sfixed64_3__is_initialized = 0;
    bit sint32_0__is_initialized = 0;
    bit sint32_1__is_initialized = 0;
    bit sint32_2__is_initialized = 0;
    bit sint32_3__is_initialized = 0;
    bit sint64_0__is_initialized = 0;
    bit sint64_1__is_initialized = 0;
    bit sint64_2__is_initialized = 0;
    bit sint64_3__is_initialized = 0;
    bit uint32_0__is_initialized = 0;
    bit uint32_1__is_initialized = 0;
    bit uint32_2__is_initialized = 0;
    bit uint32_3__is_initialized = 0;
    bit uint64_0__is_initialized = 0;
    bit uint64_1__is_initialized = 0;
    bit uint64_2__is_initialized = 0;
    bit uint64_3__is_initialized = 0;

    `uvm_object_utils_begin(Hello)
      `uvm_field_int(bool_0, UVM_ALL_ON)
      `uvm_field_int(bool_1, UVM_ALL_ON)
      `uvm_field_queue_int(bool_2, UVM_ALL_ON)
      `uvm_field_queue_int(bool_3, UVM_ALL_ON)
      `uvm_field_real(double_0, UVM_ALL_ON)
      `uvm_field_real(double_1, UVM_ALL_ON)
      `uvm_field_queue_real(double_2, UVM_ALL_ON)
      `uvm_field_queue_real(double_3, UVM_ALL_ON)
      `uvm_field_int(fixed32_0, UVM_ALL_ON)
      `uvm_field_int(fixed32_1, UVM_ALL_ON)
      `uvm_field_queue_int(fixed32_2, UVM_ALL_ON)
      `uvm_field_queue_int(fixed32_3, UVM_ALL_ON)
      `uvm_field_int(fixed64_0, UVM_ALL_ON)
      `uvm_field_int(fixed64_1, UVM_ALL_ON)
      `uvm_field_queue_int(fixed64_2, UVM_ALL_ON)
      `uvm_field_queue_int(fixed64_3, UVM_ALL_ON)
      `uvm_field_real(float_0, UVM_ALL_ON)
      `uvm_field_real(float_1, UVM_ALL_ON)
      `uvm_field_queue_real(float_2, UVM_ALL_ON)
      `uvm_field_queue_real(float_3, UVM_ALL_ON)
      `uvm_field_int(int32_0, UVM_ALL_ON)
      `uvm_field_int(int32_1, UVM_ALL_ON)
      `uvm_field_queue_int(int32_2, UVM_ALL_ON)
      `uvm_field_queue_int(int32_3, UVM_ALL_ON)
      `uvm_field_int(int64_0, UVM_ALL_ON)
      `uvm_field_int(int64_1, UVM_ALL_ON)
      `uvm_field_queue_int(int64_2, UVM_ALL_ON)
      `uvm_field_queue_int(int64_3, UVM_ALL_ON)
      `uvm_field_int(sfixed32_0, UVM_ALL_ON)
      `uvm_field_int(sfixed32_1, UVM_ALL_ON)
      `uvm_field_queue_int(sfixed32_2, UVM_ALL_ON)
      `uvm_field_queue_int(sfixed32_3, UVM_ALL_ON)
      `uvm_field_int(sfixed64_0, UVM_ALL_ON)
      `uvm_field_int(sfixed64_1, UVM_ALL_ON)
      `uvm_field_queue_int(sfixed64_2, UVM_ALL_ON)
      `uvm_field_queue_int(sfixed64_3, UVM_ALL_ON)
      `uvm_field_int(sint32_0, UVM_ALL_ON)
      `uvm_field_int(sint32_1, UVM_ALL_ON)
      `uvm_field_queue_int(sint32_2, UVM_ALL_ON)
      `uvm_field_queue_int(sint32_3, UVM_ALL_ON)
      `uvm_field_int(sint64_0, UVM_ALL_ON)
      `uvm_field_int(sint64_1, UVM_ALL_ON)
      `uvm_field_queue_int(sint64_2, UVM_ALL_ON)
      `uvm_field_queue_int(sint64_3, UVM_ALL_ON)
      `uvm_field_int(uint32_0, UVM_ALL_ON)
      `uvm_field_int(uint32_1, UVM_ALL_ON)
      `uvm_field_queue_int(uint32_2, UVM_ALL_ON)
      `uvm_field_queue_int(uint32_3, UVM_ALL_ON)
      `uvm_field_int(uint64_0, UVM_ALL_ON)
      `uvm_field_int(uint64_1, UVM_ALL_ON)
      `uvm_field_queue_int(uint64_2, UVM_ALL_ON)
      `uvm_field_queue_int(uint64_3, UVM_ALL_ON)
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
        bit tmp = this.bool_0;
        pb_pkg::encode_message_key(._field_number(this.bool_0__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_bool(._value(tmp), ._stream(_stream));
      end
      begin
        bit tmp = this.bool_1;
        pb_pkg::encode_message_key(._field_number(this.bool_1__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_bool(._value(tmp), ._stream(_stream));
      end
      foreach (this.bool_2[ii]) begin
        bit tmp = this.bool_2[ii];
        pb_pkg::encode_message_key(._field_number(this.bool_2__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_bool(._value(tmp), ._stream(_stream));
      end
      if (this.bool_3.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.bool_3[ii]) begin
          pb_pkg::encode_type_bool(._value(this.bool_3[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.bool_3__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        real tmp = this.double_0;
        pb_pkg::encode_message_key(._field_number(this.double_0__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_64BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_double(._value(tmp), ._stream(_stream));
      end
      begin
        real tmp = this.double_1;
        pb_pkg::encode_message_key(._field_number(this.double_1__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_64BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_double(._value(tmp), ._stream(_stream));
      end
      foreach (this.double_2[ii]) begin
        real tmp = this.double_2[ii];
        pb_pkg::encode_message_key(._field_number(this.double_2__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_64BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_double(._value(tmp), ._stream(_stream));
      end
      if (this.double_3.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.double_3[ii]) begin
          pb_pkg::encode_type_double(._value(this.double_3[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.double_3__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        int unsigned tmp = this.fixed32_0;
        pb_pkg::encode_message_key(._field_number(this.fixed32_0__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_32BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_fixed32(._value(tmp), ._stream(_stream));
      end
      begin
        int unsigned tmp = this.fixed32_1;
        pb_pkg::encode_message_key(._field_number(this.fixed32_1__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_32BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_fixed32(._value(tmp), ._stream(_stream));
      end
      foreach (this.fixed32_2[ii]) begin
        int unsigned tmp = this.fixed32_2[ii];
        pb_pkg::encode_message_key(._field_number(this.fixed32_2__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_32BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_fixed32(._value(tmp), ._stream(_stream));
      end
      if (this.fixed32_3.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.fixed32_3[ii]) begin
          pb_pkg::encode_type_fixed32(._value(this.fixed32_3[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.fixed32_3__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        longint unsigned tmp = this.fixed64_0;
        pb_pkg::encode_message_key(._field_number(this.fixed64_0__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_64BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_fixed64(._value(tmp), ._stream(_stream));
      end
      begin
        longint unsigned tmp = this.fixed64_1;
        pb_pkg::encode_message_key(._field_number(this.fixed64_1__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_64BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_fixed64(._value(tmp), ._stream(_stream));
      end
      foreach (this.fixed64_2[ii]) begin
        longint unsigned tmp = this.fixed64_2[ii];
        pb_pkg::encode_message_key(._field_number(this.fixed64_2__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_64BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_fixed64(._value(tmp), ._stream(_stream));
      end
      if (this.fixed64_3.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.fixed64_3[ii]) begin
          pb_pkg::encode_type_fixed64(._value(this.fixed64_3[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.fixed64_3__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        shortreal tmp = this.float_0;
        pb_pkg::encode_message_key(._field_number(this.float_0__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_32BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_float(._value(tmp), ._stream(_stream));
      end
      begin
        shortreal tmp = this.float_1;
        pb_pkg::encode_message_key(._field_number(this.float_1__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_32BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_float(._value(tmp), ._stream(_stream));
      end
      foreach (this.float_2[ii]) begin
        shortreal tmp = this.float_2[ii];
        pb_pkg::encode_message_key(._field_number(this.float_2__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_32BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_float(._value(tmp), ._stream(_stream));
      end
      if (this.float_3.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.float_3[ii]) begin
          pb_pkg::encode_type_float(._value(this.float_3[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.float_3__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        int tmp = this.int32_0;
        pb_pkg::encode_message_key(._field_number(this.int32_0__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_int32(._value(tmp), ._stream(_stream));
      end
      begin
        int tmp = this.int32_1;
        pb_pkg::encode_message_key(._field_number(this.int32_1__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_int32(._value(tmp), ._stream(_stream));
      end
      foreach (this.int32_2[ii]) begin
        int tmp = this.int32_2[ii];
        pb_pkg::encode_message_key(._field_number(this.int32_2__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_int32(._value(tmp), ._stream(_stream));
      end
      if (this.int32_3.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.int32_3[ii]) begin
          pb_pkg::encode_type_int32(._value(this.int32_3[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.int32_3__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        longint tmp = this.int64_0;
        pb_pkg::encode_message_key(._field_number(this.int64_0__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_int64(._value(tmp), ._stream(_stream));
      end
      begin
        longint tmp = this.int64_1;
        pb_pkg::encode_message_key(._field_number(this.int64_1__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_int64(._value(tmp), ._stream(_stream));
      end
      foreach (this.int64_2[ii]) begin
        longint tmp = this.int64_2[ii];
        pb_pkg::encode_message_key(._field_number(this.int64_2__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_int64(._value(tmp), ._stream(_stream));
      end
      if (this.int64_3.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.int64_3[ii]) begin
          pb_pkg::encode_type_int64(._value(this.int64_3[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.int64_3__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        int tmp = this.sfixed32_0;
        pb_pkg::encode_message_key(._field_number(this.sfixed32_0__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_32BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sfixed32(._value(tmp), ._stream(_stream));
      end
      begin
        int tmp = this.sfixed32_1;
        pb_pkg::encode_message_key(._field_number(this.sfixed32_1__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_32BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sfixed32(._value(tmp), ._stream(_stream));
      end
      foreach (this.sfixed32_2[ii]) begin
        int tmp = this.sfixed32_2[ii];
        pb_pkg::encode_message_key(._field_number(this.sfixed32_2__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_32BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sfixed32(._value(tmp), ._stream(_stream));
      end
      if (this.sfixed32_3.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.sfixed32_3[ii]) begin
          pb_pkg::encode_type_sfixed32(._value(this.sfixed32_3[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.sfixed32_3__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        longint tmp = this.sfixed64_0;
        pb_pkg::encode_message_key(._field_number(this.sfixed64_0__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_64BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sfixed64(._value(tmp), ._stream(_stream));
      end
      begin
        longint tmp = this.sfixed64_1;
        pb_pkg::encode_message_key(._field_number(this.sfixed64_1__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_64BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sfixed64(._value(tmp), ._stream(_stream));
      end
      foreach (this.sfixed64_2[ii]) begin
        longint tmp = this.sfixed64_2[ii];
        pb_pkg::encode_message_key(._field_number(this.sfixed64_2__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_64BIT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sfixed64(._value(tmp), ._stream(_stream));
      end
      if (this.sfixed64_3.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.sfixed64_3[ii]) begin
          pb_pkg::encode_type_sfixed64(._value(this.sfixed64_3[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.sfixed64_3__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        int tmp = this.sint32_0;
        pb_pkg::encode_message_key(._field_number(this.sint32_0__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sint32(._value(tmp), ._stream(_stream));
      end
      begin
        int tmp = this.sint32_1;
        pb_pkg::encode_message_key(._field_number(this.sint32_1__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sint32(._value(tmp), ._stream(_stream));
      end
      foreach (this.sint32_2[ii]) begin
        int tmp = this.sint32_2[ii];
        pb_pkg::encode_message_key(._field_number(this.sint32_2__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sint32(._value(tmp), ._stream(_stream));
      end
      if (this.sint32_3.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.sint32_3[ii]) begin
          pb_pkg::encode_type_sint32(._value(this.sint32_3[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.sint32_3__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        longint tmp = this.sint64_0;
        pb_pkg::encode_message_key(._field_number(this.sint64_0__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sint64(._value(tmp), ._stream(_stream));
      end
      begin
        longint tmp = this.sint64_1;
        pb_pkg::encode_message_key(._field_number(this.sint64_1__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sint64(._value(tmp), ._stream(_stream));
      end
      foreach (this.sint64_2[ii]) begin
        longint tmp = this.sint64_2[ii];
        pb_pkg::encode_message_key(._field_number(this.sint64_2__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_sint64(._value(tmp), ._stream(_stream));
      end
      if (this.sint64_3.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.sint64_3[ii]) begin
          pb_pkg::encode_type_sint64(._value(this.sint64_3[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.sint64_3__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        int unsigned tmp = this.uint32_0;
        pb_pkg::encode_message_key(._field_number(this.uint32_0__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_uint32(._value(tmp), ._stream(_stream));
      end
      begin
        int unsigned tmp = this.uint32_1;
        pb_pkg::encode_message_key(._field_number(this.uint32_1__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_uint32(._value(tmp), ._stream(_stream));
      end
      foreach (this.uint32_2[ii]) begin
        int unsigned tmp = this.uint32_2[ii];
        pb_pkg::encode_message_key(._field_number(this.uint32_2__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_uint32(._value(tmp), ._stream(_stream));
      end
      if (this.uint32_3.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.uint32_3[ii]) begin
          pb_pkg::encode_type_uint32(._value(this.uint32_3[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.uint32_3__field_number),
                                 ._delimited_stream(sub_stream),
                                 ._stream(_stream));
      end
      begin
        longint unsigned tmp = this.uint64_0;
        pb_pkg::encode_message_key(._field_number(this.uint64_0__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_uint64(._value(tmp), ._stream(_stream));
      end
      begin
        longint unsigned tmp = this.uint64_1;
        pb_pkg::encode_message_key(._field_number(this.uint64_1__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_uint64(._value(tmp), ._stream(_stream));
      end
      foreach (this.uint64_2[ii]) begin
        longint unsigned tmp = this.uint64_2[ii];
        pb_pkg::encode_message_key(._field_number(this.uint64_2__field_number),
                                   ._wire_type(pb_pkg::WIRE_TYPE_VARINT),
                                   ._stream(_stream));
        pb_pkg::encode_type_uint64(._value(tmp), ._stream(_stream));
      end
      if (this.uint64_3.size()) begin
        pb_pkg::enc_bytestream_t sub_stream;
        foreach (this.uint64_3[ii]) begin
          pb_pkg::encode_type_uint64(._value(this.uint64_3[ii]), ._stream(sub_stream));
        end
        pb_pkg::encode_delimited(._field_number(this.uint64_3__field_number),
                                 ._delimited_stream(sub_stream),
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
          bool_0__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_bool(._result(bool_0), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          bool_1__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_bool(._result(bool_1), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.bool_1__is_initialized = 1;
          end
          bool_2__field_number: begin
            bit tmp_bool_2;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_bool(._result(tmp_bool_2), ._stream(_stream), ._cursor(_cursor)));
              this.bool_2.push_back(tmp_bool_2);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          bool_3__field_number: begin
            bit tmp_bool_3;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_bool(._result(tmp_bool_3), ._stream(_stream), ._cursor(_cursor)));
              this.bool_3.push_back(tmp_bool_3);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          double_0__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_double(._result(double_0), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          double_1__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_double(._result(double_1), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.double_1__is_initialized = 1;
          end
          double_2__field_number: begin
            real tmp_double_2;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_double(._result(tmp_double_2), ._stream(_stream), ._cursor(_cursor)));
              this.double_2.push_back(tmp_double_2);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          double_3__field_number: begin
            real tmp_double_3;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_double(._result(tmp_double_3), ._stream(_stream), ._cursor(_cursor)));
              this.double_3.push_back(tmp_double_3);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          fixed32_0__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_fixed32(._result(fixed32_0), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          fixed32_1__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_fixed32(._result(fixed32_1), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.fixed32_1__is_initialized = 1;
          end
          fixed32_2__field_number: begin
            int unsigned tmp_fixed32_2;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_fixed32(._result(tmp_fixed32_2), ._stream(_stream), ._cursor(_cursor)));
              this.fixed32_2.push_back(tmp_fixed32_2);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          fixed32_3__field_number: begin
            int unsigned tmp_fixed32_3;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_fixed32(._result(tmp_fixed32_3), ._stream(_stream), ._cursor(_cursor)));
              this.fixed32_3.push_back(tmp_fixed32_3);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          fixed64_0__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_fixed64(._result(fixed64_0), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          fixed64_1__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_fixed64(._result(fixed64_1), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.fixed64_1__is_initialized = 1;
          end
          fixed64_2__field_number: begin
            longint unsigned tmp_fixed64_2;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_fixed64(._result(tmp_fixed64_2), ._stream(_stream), ._cursor(_cursor)));
              this.fixed64_2.push_back(tmp_fixed64_2);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          fixed64_3__field_number: begin
            longint unsigned tmp_fixed64_3;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_fixed64(._result(tmp_fixed64_3), ._stream(_stream), ._cursor(_cursor)));
              this.fixed64_3.push_back(tmp_fixed64_3);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          float_0__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_float(._result(float_0), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          float_1__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_float(._result(float_1), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.float_1__is_initialized = 1;
          end
          float_2__field_number: begin
            shortreal tmp_float_2;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_float(._result(tmp_float_2), ._stream(_stream), ._cursor(_cursor)));
              this.float_2.push_back(tmp_float_2);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          float_3__field_number: begin
            shortreal tmp_float_3;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_float(._result(tmp_float_3), ._stream(_stream), ._cursor(_cursor)));
              this.float_3.push_back(tmp_float_3);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          int32_0__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_int32(._result(int32_0), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          int32_1__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_int32(._result(int32_1), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.int32_1__is_initialized = 1;
          end
          int32_2__field_number: begin
            int tmp_int32_2;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_int32(._result(tmp_int32_2), ._stream(_stream), ._cursor(_cursor)));
              this.int32_2.push_back(tmp_int32_2);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          int32_3__field_number: begin
            int tmp_int32_3;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_int32(._result(tmp_int32_3), ._stream(_stream), ._cursor(_cursor)));
              this.int32_3.push_back(tmp_int32_3);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          int64_0__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_int64(._result(int64_0), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          int64_1__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_int64(._result(int64_1), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.int64_1__is_initialized = 1;
          end
          int64_2__field_number: begin
            longint tmp_int64_2;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_int64(._result(tmp_int64_2), ._stream(_stream), ._cursor(_cursor)));
              this.int64_2.push_back(tmp_int64_2);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          int64_3__field_number: begin
            longint tmp_int64_3;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_int64(._result(tmp_int64_3), ._stream(_stream), ._cursor(_cursor)));
              this.int64_3.push_back(tmp_int64_3);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          sfixed32_0__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_sfixed32(._result(sfixed32_0), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          sfixed32_1__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_sfixed32(._result(sfixed32_1), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.sfixed32_1__is_initialized = 1;
          end
          sfixed32_2__field_number: begin
            int tmp_sfixed32_2;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_sfixed32(._result(tmp_sfixed32_2), ._stream(_stream), ._cursor(_cursor)));
              this.sfixed32_2.push_back(tmp_sfixed32_2);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          sfixed32_3__field_number: begin
            int tmp_sfixed32_3;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_32BIT));
            do begin
              assert (!pb_pkg::decode_type_sfixed32(._result(tmp_sfixed32_3), ._stream(_stream), ._cursor(_cursor)));
              this.sfixed32_3.push_back(tmp_sfixed32_3);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          sfixed64_0__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_sfixed64(._result(sfixed64_0), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          sfixed64_1__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_sfixed64(._result(sfixed64_1), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.sfixed64_1__is_initialized = 1;
          end
          sfixed64_2__field_number: begin
            longint tmp_sfixed64_2;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_sfixed64(._result(tmp_sfixed64_2), ._stream(_stream), ._cursor(_cursor)));
              this.sfixed64_2.push_back(tmp_sfixed64_2);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          sfixed64_3__field_number: begin
            longint tmp_sfixed64_3;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_64BIT));
            do begin
              assert (!pb_pkg::decode_type_sfixed64(._result(tmp_sfixed64_3), ._stream(_stream), ._cursor(_cursor)));
              this.sfixed64_3.push_back(tmp_sfixed64_3);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          sint32_0__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_sint32(._result(sint32_0), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          sint32_1__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_sint32(._result(sint32_1), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.sint32_1__is_initialized = 1;
          end
          sint32_2__field_number: begin
            int tmp_sint32_2;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_sint32(._result(tmp_sint32_2), ._stream(_stream), ._cursor(_cursor)));
              this.sint32_2.push_back(tmp_sint32_2);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          sint32_3__field_number: begin
            int tmp_sint32_3;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_sint32(._result(tmp_sint32_3), ._stream(_stream), ._cursor(_cursor)));
              this.sint32_3.push_back(tmp_sint32_3);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          sint64_0__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_sint64(._result(sint64_0), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          sint64_1__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_sint64(._result(sint64_1), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.sint64_1__is_initialized = 1;
          end
          sint64_2__field_number: begin
            longint tmp_sint64_2;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_sint64(._result(tmp_sint64_2), ._stream(_stream), ._cursor(_cursor)));
              this.sint64_2.push_back(tmp_sint64_2);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          sint64_3__field_number: begin
            longint tmp_sint64_3;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_sint64(._result(tmp_sint64_3), ._stream(_stream), ._cursor(_cursor)));
              this.sint64_3.push_back(tmp_sint64_3);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          uint32_0__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_uint32(._result(uint32_0), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          uint32_1__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_uint32(._result(uint32_1), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.uint32_1__is_initialized = 1;
          end
          uint32_2__field_number: begin
            int unsigned tmp_uint32_2;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_uint32(._result(tmp_uint32_2), ._stream(_stream), ._cursor(_cursor)));
              this.uint32_2.push_back(tmp_uint32_2);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          uint32_3__field_number: begin
            int unsigned tmp_uint32_3;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_uint32(._result(tmp_uint32_3), ._stream(_stream), ._cursor(_cursor)));
              this.uint32_3.push_back(tmp_uint32_3);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          uint64_0__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_uint64(._result(uint64_0), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          uint64_1__field_number: begin
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_uint64(._result(uint64_1), ._stream(_stream), ._cursor(_cursor)));
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
            this.uint64_1__is_initialized = 1;
          end
          uint64_2__field_number: begin
            longint unsigned tmp_uint64_2;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_uint64(._result(tmp_uint64_2), ._stream(_stream), ._cursor(_cursor)));
              this.uint64_2.push_back(tmp_uint64_2);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
          end
          uint64_3__field_number: begin
            longint unsigned tmp_uint64_3;
            assert ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) || (wire_type == pb_pkg::WIRE_TYPE_VARINT));
            do begin
              assert (!pb_pkg::decode_type_uint64(._result(tmp_uint64_3), ._stream(_stream), ._cursor(_cursor)));
              this.uint64_3.push_back(tmp_uint64_3);
            end while ((wire_type == pb_pkg::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));
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
      is_initialized &= this.bool_1__is_initialized;
      is_initialized &= this.double_1__is_initialized;
      is_initialized &= this.fixed32_1__is_initialized;
      is_initialized &= this.fixed64_1__is_initialized;
      is_initialized &= this.float_1__is_initialized;
      is_initialized &= this.int32_1__is_initialized;
      is_initialized &= this.int64_1__is_initialized;
      is_initialized &= this.sfixed32_1__is_initialized;
      is_initialized &= this.sfixed64_1__is_initialized;
      is_initialized &= this.sint32_1__is_initialized;
      is_initialized &= this.sint64_1__is_initialized;
      is_initialized &= this.uint32_1__is_initialized;
      is_initialized &= this.uint64_1__is_initialized;
    endfunction : is_initialized
    function void post_randomize();
      this.bool_1__is_initialized = 1;
      this.double_1__is_initialized = 1;
      this.fixed32_1__is_initialized = 1;
      this.fixed64_1__is_initialized = 1;
      this.float_1__is_initialized = 1;
      this.int32_1__is_initialized = 1;
      this.int64_1__is_initialized = 1;
      this.sfixed32_1__is_initialized = 1;
      this.sfixed64_1__is_initialized = 1;
      this.sint32_1__is_initialized = 1;
      this.sint64_1__is_initialized = 1;
      this.uint32_1__is_initialized = 1;
      this.uint64_1__is_initialized = 1;
    endfunction : post_randomize

  endclass : Hello


