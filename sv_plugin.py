#!/usr/bin/env python3
import itertools
import json
import os
import sys

import stringcase

from google.protobuf.compiler import plugin_pb2 as plugin

from google.protobuf.descriptor_pb2 import DescriptorProto, EnumDescriptorProto, FieldDescriptorProto
#import pdb; pdb.set_trace()

PB_PKG = "pb_pkg"

PB_TYPE_NUMBER_TO_PB_TYPE = {
    FieldDescriptorProto.TYPE_BOOL     : 'TYPE_BOOL',
    FieldDescriptorProto.TYPE_BYTES    : 'TYPE_BYTES',
    FieldDescriptorProto.TYPE_DOUBLE   : 'TYPE_DOUBLE',
    FieldDescriptorProto.TYPE_ENUM     : 'TYPE_ENUM',
    FieldDescriptorProto.TYPE_FIXED32  : 'TYPE_FIXED32',
    FieldDescriptorProto.TYPE_FIXED64  : 'TYPE_FIXED64',
    FieldDescriptorProto.TYPE_FLOAT    : 'TYPE_FLOAT',
    FieldDescriptorProto.TYPE_GROUP    : 'TYPE_GROUP',
    FieldDescriptorProto.TYPE_INT32    : 'TYPE_INT32',
    FieldDescriptorProto.TYPE_INT64    : 'TYPE_INT64',
    FieldDescriptorProto.TYPE_MESSAGE  : 'TYPE_MESSAGE',
    FieldDescriptorProto.TYPE_SFIXED32 : 'TYPE_SFIXED32',
    FieldDescriptorProto.TYPE_SFIXED64 : 'TYPE_SFIXED64',
    FieldDescriptorProto.TYPE_SINT32   : 'TYPE_SINT32',
    FieldDescriptorProto.TYPE_SINT64   : 'TYPE_SINT64',
    FieldDescriptorProto.TYPE_STRING   : 'TYPE_STRING',
    FieldDescriptorProto.TYPE_UINT32   : 'TYPE_UINT32',
    FieldDescriptorProto.TYPE_UINT64   : 'TYPE_UINT64',
}

WIRE_TYPE_VARINT = "WIRE_TYPE_VARINT"
WIRE_TYPE_64BIT = "WIRE_TYPE_64BIT"
WIRE_TYPE_DELIMITED = "WIRE_TYPE_DELIMITED"
#WIRE_TYPE_START_GROUP = "WIRE_TYPE_START_GROUP"
#WIRE_TYPE_END_GROUP = "WIRE_TYPE_END_GROUP"
WIRE_TYPE_32BIT = "WIRE_TYPE_32BIT"

# FIXME looking at this, bytes are being handled inappropriately as a single byte, not as an array of bytes
# 0	Varint	int32, int64, uint32, uint64, sint32, sint64, bool, enum
# 1	64-bit	fixed64, sfixed64, double
# 2	Length-delimited	string, bytes, embedded messages, packed repeated fields
# 3	Start group	groups (deprecated)
# 4	End group	groups (deprecated)
# 5	32-bit	fixed32, sfixed32, float
PB_TYPE_NUMBER_TO_WIRE_TYPE = {
    FieldDescriptorProto.TYPE_BOOL     : WIRE_TYPE_VARINT,
    FieldDescriptorProto.TYPE_BYTES    : WIRE_TYPE_DELIMITED,
    FieldDescriptorProto.TYPE_DOUBLE   : WIRE_TYPE_64BIT,
    FieldDescriptorProto.TYPE_ENUM     : WIRE_TYPE_VARINT,
    FieldDescriptorProto.TYPE_FIXED32  : WIRE_TYPE_32BIT,
    FieldDescriptorProto.TYPE_FIXED64  : WIRE_TYPE_64BIT,
    FieldDescriptorProto.TYPE_FLOAT    : WIRE_TYPE_32BIT,
  # FieldDescriptorProto.TYPE_GROUP    : -1, # Unsupported
    FieldDescriptorProto.TYPE_INT32    : WIRE_TYPE_VARINT,
    FieldDescriptorProto.TYPE_INT64    : WIRE_TYPE_VARINT,
    FieldDescriptorProto.TYPE_MESSAGE  : WIRE_TYPE_DELIMITED,
    FieldDescriptorProto.TYPE_SFIXED32 : WIRE_TYPE_32BIT,
    FieldDescriptorProto.TYPE_SFIXED64 : WIRE_TYPE_64BIT,
    FieldDescriptorProto.TYPE_SINT32   : WIRE_TYPE_VARINT,
    FieldDescriptorProto.TYPE_SINT64   : WIRE_TYPE_VARINT,
    FieldDescriptorProto.TYPE_STRING   : WIRE_TYPE_DELIMITED,
    FieldDescriptorProto.TYPE_UINT32   : WIRE_TYPE_VARINT,
    FieldDescriptorProto.TYPE_UINT64   : WIRE_TYPE_VARINT,
}


PB_TYPE_NUMBER_TO_SV_TYPE = {
    FieldDescriptorProto.TYPE_BOOL     : 'bit',
    FieldDescriptorProto.TYPE_BYTES    : 'pb_pkg::bytestream_t',
    FieldDescriptorProto.TYPE_DOUBLE   : 'real',
    FieldDescriptorProto.TYPE_ENUM     : 'enum',
    FieldDescriptorProto.TYPE_FIXED32  : 'int unsigned',
    FieldDescriptorProto.TYPE_FIXED64  : 'longint unsigned',
    FieldDescriptorProto.TYPE_FLOAT    : 'shortreal',
   #FieldDescriptorProto.TYPE_GROUP    : '',
    FieldDescriptorProto.TYPE_INT32    : 'int',
    FieldDescriptorProto.TYPE_INT64    : 'longint',
   #FieldDescriptorProto.TYPE_MESSAGE  : '',
    FieldDescriptorProto.TYPE_SFIXED32 : 'int',
    FieldDescriptorProto.TYPE_SFIXED64 : 'longint',
    FieldDescriptorProto.TYPE_SINT32   : 'int',
    FieldDescriptorProto.TYPE_SINT64   : 'longint',
    FieldDescriptorProto.TYPE_STRING   : 'string',
    FieldDescriptorProto.TYPE_UINT32   : 'int unsigned',
    FieldDescriptorProto.TYPE_UINT64   : 'longint unsigned',
}    

PB_TYPE_NUMBER_TO_UVM_FIELD_MACRO = {
    FieldDescriptorProto.TYPE_BOOL    : 'uvm_field_int',
    FieldDescriptorProto.TYPE_BYTES   : 'uvm_field_array_int',
    FieldDescriptorProto.TYPE_DOUBLE  : 'uvm_field_real',
    FieldDescriptorProto.TYPE_ENUM    : 'uvm_field_enum',
    FieldDescriptorProto.TYPE_FIXED32 : 'uvm_field_int',
    FieldDescriptorProto.TYPE_FIXED64 : 'uvm_field_int',
    FieldDescriptorProto.TYPE_FLOAT   : 'uvm_field_real',
  # FieldDescriptorProto.TYPE_GROUP   : '',
    FieldDescriptorProto.TYPE_INT32   : 'uvm_field_int',
    FieldDescriptorProto.TYPE_INT64   : 'uvm_field_int',
    FieldDescriptorProto.TYPE_MESSAGE : 'uvm_field_object',
    FieldDescriptorProto.TYPE_SFIXED32: 'uvm_field_int',
    FieldDescriptorProto.TYPE_SFIXED64: 'uvm_field_int',
    FieldDescriptorProto.TYPE_SINT32  : 'uvm_field_int',
    FieldDescriptorProto.TYPE_SINT64  : 'uvm_field_int',
    FieldDescriptorProto.TYPE_STRING  : 'uvm_field_string',
    FieldDescriptorProto.TYPE_UINT32  : 'uvm_field_int',
    FieldDescriptorProto.TYPE_UINT64  : 'uvm_field_int',
}

PB_TYPE_NUMBER_REPEATED_TO_UVM_FIELD_MACRO = {
    FieldDescriptorProto.TYPE_BOOL    : 'uvm_field_queue_int',
    FieldDescriptorProto.TYPE_BYTES   : '',
    FieldDescriptorProto.TYPE_DOUBLE  : '',
    FieldDescriptorProto.TYPE_ENUM    : 'uvm_field_queue_enum',
    FieldDescriptorProto.TYPE_FIXED32 : 'uvm_field_queue_int',
    FieldDescriptorProto.TYPE_FIXED64 : 'uvm_field_queue_int',
    FieldDescriptorProto.TYPE_FLOAT   : '',
  # FieldDescriptorProto.TYPE_GROUP   : '',
    FieldDescriptorProto.TYPE_INT32   : 'uvm_field_queue_int',
    FieldDescriptorProto.TYPE_INT64   : 'uvm_field_queue_int',
    FieldDescriptorProto.TYPE_MESSAGE : 'uvm_field_queue_object',
    FieldDescriptorProto.TYPE_SFIXED32: 'uvm_field_queue_int',
    FieldDescriptorProto.TYPE_SFIXED64: 'uvm_field_queue_int',
    FieldDescriptorProto.TYPE_SINT32  : 'uvm_field_queue_int',
    FieldDescriptorProto.TYPE_SINT64  : 'uvm_field_queue_int',
    FieldDescriptorProto.TYPE_STRING  : 'uvm_field_queue_string',
    FieldDescriptorProto.TYPE_UINT32  : 'uvm_field_queue_int',
    FieldDescriptorProto.TYPE_UINT64  : 'uvm_field_queue_int',
}

# See if type should be randomized
PB_TYPE_NUMBER_TO_RAND = {
    FieldDescriptorProto.TYPE_BOOL     : 'rand ',
    FieldDescriptorProto.TYPE_BYTES    : 'rand ',
    FieldDescriptorProto.TYPE_DOUBLE   : '`pb_real_rand ',
    FieldDescriptorProto.TYPE_ENUM     : 'rand ',
    FieldDescriptorProto.TYPE_FIXED32  : 'rand ',
    FieldDescriptorProto.TYPE_FIXED64  : 'rand ',
    FieldDescriptorProto.TYPE_FLOAT    : '`pb_real_rand ',
   #FieldDescriptorProto.TYPE_GROUP    : '',
    FieldDescriptorProto.TYPE_INT32    : 'rand ',
    FieldDescriptorProto.TYPE_INT64    : 'rand ',
    FieldDescriptorProto.TYPE_MESSAGE  : 'rand ',
    FieldDescriptorProto.TYPE_SFIXED32 : 'rand ',
    FieldDescriptorProto.TYPE_SFIXED64 : 'rand ',
    FieldDescriptorProto.TYPE_SINT32   : 'rand ',
    FieldDescriptorProto.TYPE_SINT64   : 'rand ',
    FieldDescriptorProto.TYPE_STRING   : '',
    FieldDescriptorProto.TYPE_UINT32   : 'rand ',
    FieldDescriptorProto.TYPE_UINT64   : 'rand ',
}

PB_LABEL_TO_ENUM = {
    FieldDescriptorProto.LABEL_OPTIONAL : "LABEL_OPTIONAL",
    FieldDescriptorProto.LABEL_REQUIRED : "LABEL_REQUIRED",
    FieldDescriptorProto.LABEL_REPEATED : "LABEL_REPEATED",
}

class GeneratedPackage():
    def __init__(self, package_name):
        self._package_name = package_name
        self._lines = []
        if self._package_name:
            self.append(f"package {self._package_name};")
            self.append("")
            
        self.append("  `include \"uvm_macros.svh\"")
        self.append("  import uvm_pkg::*;")
        self.append("")

    def append(self, line):
        self._lines.append(line)

    def finish(self):
        if self._package_name:
            self.append(f"endpackage : {self._package_name}")
        self.append("")

    def content(self):
        return "\n".join(self._lines)


def signal_last(iterable):
    """Similar to enumerate, but return boolean indicating last loop instead of index count."""
    _iterable = iter(iterable)
    value = next(_iterable)
    for val in _iterable:
        yield False, value
        value = val
    yield True, value

def get_ref_type(package, imports, type_name):
    # If the package name is a blank string, then this should still work
    # because by convention packages are lowercase and message/enum types are
    # pascal-cased. May require refactoring in the future.
    type_name = type_name.lstrip(".")    

    if type_name.startswith(package):
        parts = type_name.lstrip(package).lstrip(".").split(".")
        if len(parts) == 1 or (len(parts) > 1 and parts[0][0] == parts[0][0].upper()):
            # This is the current package, which has nested types flattened.
            # foo.bar_thing => FooBarThing
            cased = [stringcase.pascalcase(part) for part in parts]
            type_name = f'{"".join(cased)}'
    if "." in type_name:
        # This is imported from another package. No need
        # to use a forward ref and we need to add the import.
        parts = type_name.split(".")
        parts[-1] = stringcase.pascalcase(parts[-1])
        imports.add(f"from .{'.'.join(parts[:-2])} import {parts[-2]}")
        type_name = f"{parts[-2]}.{parts[-1]}"
            
    return type_name

class SVFieldDescriptorProto():
    """Helper functions on FieldDescriptorProto specific to this generator."""
    def __init__(self, f, package, imports):
        self.f = f
        self.package = package
        self.imports = imports

    def __getattr__(self, attribute):
        try:
            return super(SVFieldDescriptorProto, self).__getattr__(attribute)
        except AttributeError:
            return getattr(self.f, attribute)

    @property
    def sv_type(self):
        if self.type == FieldDescriptorProto.TYPE_ENUM or self.type == FieldDescriptorProto.TYPE_MESSAGE:
            return f"{get_ref_type(self.package, self.imports, self.type_name)}"
        else:
            try:
                return PB_TYPE_NUMBER_TO_SV_TYPE[self.type]
            except KeyError:
                raise NotImplementedError(f"{PB_TYPE_NUMBER_TO_PB_TYPE[self.type]} not supported in SV")

    @property
    def sv_queue(self):
        return "[$]" if self.label in [self.LABEL_REPEATED] else ""

    @property
    def sv_rand(self):
        return f"{PB_TYPE_NUMBER_TO_RAND[self.type]}"

    @property
    def sv_xxcode_func(self):
        return f"{PB_TYPE_NUMBER_TO_PB_TYPE[self.type].lower()}"

    @property
    def sv_decode_func(self):
        return f"decode_{self.sv_xxcode_func}"

    @property
    def sv_encode_func(self):
        return f"encode_{self.sv_xxcode_func}"

    @property
    def sv_label(self):
        return f"{PB_LABEL_TO_ENUM[self.label]}"

    @property
    def sv_field_macro(self):
        if self.label == self.LABEL_REPEATED:
            macro_type = PB_TYPE_NUMBER_REPEATED_TO_UVM_FIELD_MACRO[self.type]
        else:
            macro_type = PB_TYPE_NUMBER_TO_UVM_FIELD_MACRO[self.type]
        if macro_type == '':
            return ""
        return f"`{macro_type}({self.sv_field_macro_args})"

    @property
    def sv_field_macro_args(self):
        if self.type == FieldDescriptorProto.TYPE_ENUM:
            return f"{self.sv_type}, {self.name}, UVM_ALL_ON"
        else:
            return f"{self.name}, UVM_ALL_ON"

    @property
    def sv_wire_type(self):
        return f"{PB_TYPE_NUMBER_TO_WIRE_TYPE[self.type]}"
    
    @property
    def sv_number(self):
        return f"{self.name}__field_number"

    @property
    def sv_default(self):
        if not self.default_value:
            return ""
        if self.type == self.TYPE_STRING:
            return f" = \"{self.default_value}\""
        if self.type == self.TYPE_BYTES:
            bs = [f"8'h{ord(char):02x}" for char in self.default_value]
            return f' = \'{{{", ".join(bs)}}}'
        else:
            return f" = {self.default_value}"
    
def generate_code(request, response):
    pkgs = {}
    
    for proto_file in request.proto_file:
        # Parse request
        for item, package in traverse(proto_file):
            try:
                pkg = pkgs[package]
            except KeyError:
                pkg = GeneratedPackage(package_name=proto_file.package)
                pkgs[package] = pkg

            # lines.append(item)
            # data = {
            #     'package': proto_file.package or '&lt;root&gt;',
            #     'filename': proto_file.name,
            #     'name': item.name,
            # }

            imports = set()
            if isinstance(item, DescriptorProto):
                #lines.append(str(dir(FieldDescriptorProto)))
                pkg.append(f"  class {item.name} extends uvm_object;")
                pkg.append("")
                
                sv_fields = [SVFieldDescriptorProto(f, package, imports) for f in item.field]

                for f in sv_fields:
                    pkg.append(f"    {f.sv_rand}{f.sv_type} {f.name}{f.sv_queue}{f.sv_default};")
                pkg.append("")

                for f in sv_fields:
                    pkg.append(f"    local const {PB_PKG}::field_number_t {f.sv_number} = {f.number};")
                pkg.append("")

                for f in sv_fields:
                    pkg.append(f"    local const {PB_PKG}::label_e {f.name}__label = {PB_PKG}::{f.sv_label};")
                pkg.append("")

                # TODO
                # Not sure how to set these if not randomizing the object
                # Using getters/setters isn't worthwhile if the member is local
                # Making the member local makes it more difficult to randomize
                for f in sv_fields:
                    # Message fields should be calculated recursively
                    if f.type != FieldDescriptorProto.TYPE_MESSAGE:
                        pkg.append(f"    bit {f.name}__is_initialized = 0;")
                pkg.append("")

                pkg.append(f"    `uvm_object_utils_begin({item.name})")
                for f in sv_fields:
                        pkg.append(f"      {f.sv_field_macro}")
                pkg.append("    `uvm_object_utils_end")
                pkg.append("")
                pkg.append(f"    function new(string name=\"{item.name}\");")
                pkg.append("       super.new(.name(name));")
                pkg.append("    endfunction : new")
                pkg.append("")
                pkg.append(f"    function void serialize(ref {PB_PKG}::bytestream_t _stream);")
                pkg.append(f"      {PB_PKG}::enc_bytestream_t enc_stream;")
                pkg.append("      this._serialize(._stream(enc_stream));")
                pkg.append(f"      {PB_PKG}::_bytestream_queue_to_dynamic_array(._out(_stream), ._in(enc_stream));")
                pkg.append("    endfunction : serialize")
                pkg.append("")
                pkg.append(f"    function void _serialize(ref {PB_PKG}::enc_bytestream_t _stream);")
                pkg.append("       assert (this.is_initialized());")
                for f in sv_fields:
                    # FIXME add assertions that required fields are initialized
                    if f.type == FieldDescriptorProto.TYPE_MESSAGE:
                        if f.sv_queue:
                            pkg.append(f"      foreach (this.{f.name}[ii]) begin")
                            pkg.append(f"        {f.sv_type} tmp = this.{f.name}[ii];")
                        else:
                            pkg.append(f"      begin")
                            # FIXME skip if optional
                            pkg.append(f"        {f.sv_type} tmp = this.{f.name};")
                        pkg.append(f"        {PB_PKG}::enc_bytestream_t sub_stream;")
                        pkg.append(f"        tmp._serialize(._stream(sub_stream));")
                        pkg.append(f"        {PB_PKG}::encode_delimited(._field_number(this.{f.sv_number}),")
                        pkg.append(f"                                 ._delimited_stream(sub_stream),")
                        pkg.append(f"                                 ._stream(_stream));")
                        pkg.append(f"      end")
                    elif f.type in [f.TYPE_STRING, f.TYPE_BYTES]:
                        if f.sv_queue:
                            pkg.append(f"      foreach (this.{f.name}[ii]) begin")
                            pkg.append(f"        {f.sv_type} tmp = this.{f.name}[ii];")
                        else:
                            pkg.append(f"      begin")
                            # FIXME skip if optional
                            pkg.append(f"        {f.sv_type} tmp = this.{f.name};")
                        pkg.append(f"        {PB_PKG}::encode_message_key(._field_number(this.{f.sv_number}),")
                        pkg.append(f"                                   ._wire_type({PB_PKG}::WIRE_TYPE_DELIMITED),")
                        pkg.append(f"                                   ._stream(_stream));")
                        pkg.append(f"        {PB_PKG}::{f.sv_encode_func}(._value(tmp),")
                        pkg.append(f"                                   ._stream(_stream));")
                        pkg.append(f"      end")
                    else:
                        if f.options.packed: # Packed implies repeated
                            pkg.append(f"      if (this.{f.name}.size()) begin")
                            pkg.append(f"        {PB_PKG}::enc_bytestream_t sub_stream;")
                            pkg.append(f"        foreach (this.{f.name}[ii]) begin")
                            pkg.append(f"          {PB_PKG}::{f.sv_encode_func}(._value(this.{f.name}[ii]), ._stream(sub_stream));")
                            pkg.append(f"        end")
                            pkg.append(f"        {PB_PKG}::encode_delimited(._field_number(this.{f.sv_number}),")
                            pkg.append(f"                                 ._delimited_stream(sub_stream),")
                            pkg.append(f"                                 ._stream(_stream));")
                            pkg.append(f"      end")
                        else:
                            if f.sv_queue:
                                pkg.append(f"      foreach (this.{f.name}[ii]) begin")
                                pkg.append(f"        {f.sv_type} tmp = this.{f.name}[ii];")
                            else:
                                pkg.append(f"      begin")
                                # FIXME skip if optional
                                pkg.append(f"        {f.sv_type} tmp = this.{f.name};")
                            pkg.append(f"        {PB_PKG}::encode_message_key(._field_number(this.{f.sv_number}),")
                            pkg.append(f"                                   ._wire_type({PB_PKG}::{f.sv_wire_type}),")
                            pkg.append(f"                                   ._stream(_stream));")
                            pkg.append(f"        {PB_PKG}::{f.sv_encode_func}(._value(tmp), ._stream(_stream));")
                            pkg.append("      end")
                pkg.append("")
                pkg.append("    endfunction : _serialize")
                pkg.append("")
                pkg.append(f"    function void deserialize(ref {PB_PKG}::bytestream_t _stream);")
                pkg.append(f"      {PB_PKG}::cursor_t cursor = 0;")
                pkg.append(f"      {PB_PKG}::cursor_t cursor_stop = -1;")
                pkg.append("      this._deserialize(._stream(_stream), ._cursor(cursor), ._cursor_stop(cursor_stop));")
                pkg.append("    endfunction : deserialize")
                pkg.append("")
                pkg.append(f"    function void _deserialize(ref {PB_PKG}::bytestream_t _stream, ref {PB_PKG}::cursor_t _cursor, input {PB_PKG}::cursor_t _cursor_stop);")
                pkg.append(f"      {PB_PKG}::cursor_t stream_size = _stream.size();")
                pkg.append("      while ((_cursor < stream_size) && (_cursor < _cursor_stop)) begin")
                pkg.append(f"        {PB_PKG}::field_number_t field_number;")
                pkg.append(f"        {PB_PKG}::wire_type_e wire_type;")
                pkg.append(f"        {PB_PKG}::varint_t delimited_length;")
                pkg.append(f"        {PB_PKG}::cursor_t delimited_stop;")
                pkg.append(f"        assert (!{PB_PKG}::decode_message_key(._field_number(field_number),")
                pkg.append("                                            ._wire_type(wire_type),")
                pkg.append("                                            ._stream(_stream),")
                pkg.append("                                            ._cursor(_cursor)));")
                pkg.append(f"        if (wire_type == {PB_PKG}::WIRE_TYPE_DELIMITED) begin")
                pkg.append(f"            assert (!{PB_PKG}::decode_varint(._value(delimited_length),")
                pkg.append("                                           ._stream(_stream),")
                pkg.append("                                           ._cursor(_cursor)));")
                pkg.append("            delimited_stop = _cursor + delimited_length;")
                pkg.append("        end")
                pkg.append("        case (field_number)")
                for f in sv_fields:
                    pkg.append(f"          {f.name}__field_number: begin")
                    result_var = f.name
                    if f.sv_queue:
                        result_var = f"tmp_{f.name}"
                        pkg.append(f"            {f.sv_type} {result_var};")
                    if f.type == FieldDescriptorProto.TYPE_MESSAGE:
                        pkg.append(f"            assert (wire_type == {PB_PKG}::WIRE_TYPE_DELIMITED);")
                        pkg.append(f"            {result_var} = {f.sv_type}::type_id::create();")
                        pkg.append(f"            {result_var}._deserialize(._stream(_stream), ._cursor(_cursor), ._cursor_stop(_cursor + delimited_length));")
                        if f.sv_queue:
                            pkg.append(f"            this.{f.name}.push_back({result_var});")
                    elif f.type in [f.TYPE_STRING, f.TYPE_BYTES]:
                        pkg.append(f"            assert (wire_type == {PB_PKG}::WIRE_TYPE_DELIMITED);")
                        pkg.append(f"            assert (!{PB_PKG}::{f.sv_decode_func}(._result({result_var}), ._stream(_stream), ._cursor(_cursor), ._str_length(delimited_length)));")
                        if f.sv_queue:
                            pkg.append(f"            this.{f.name}.push_back({result_var});")
                    else:
                        pkg.append(f"            assert ((wire_type == {PB_PKG}::WIRE_TYPE_DELIMITED) || (wire_type == {PB_PKG}::{f.sv_wire_type}));")
                        pkg.append(f"            do begin")
                        if f.type == FieldDescriptorProto.TYPE_ENUM:
                            pkg.append(f"              {PB_PKG}::varint_t tmp_varint;")
                            result_var_enum = result_var
                            result_var = "tmp_varint"
                        pkg.append(f"              assert (!{PB_PKG}::{f.sv_decode_func}(._result({result_var}), ._stream(_stream), ._cursor(_cursor)));")
                        if f.type == FieldDescriptorProto.TYPE_ENUM:
                            result_var = result_var_enum
                            pkg.append(f"            {result_var} = {f.sv_type}'(tmp_varint);")
                        if f.sv_queue:
                            pkg.append(f"              this.{f.name}.push_back({result_var});")
                        pkg.append(f"            end while ((wire_type == {PB_PKG}::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));")
                    if f.label == f.LABEL_REQUIRED:
                        if f.type != FieldDescriptorProto.TYPE_MESSAGE:
                            pkg.append(f"            this.{f.name}__is_initialized = 1;")
                    pkg.append(f"          end")

                pkg.append(f"          default : assert (!{PB_PKG}::decode_and_consume_unknown(._wire_type(wire_type), ._stream(_stream), ._cursor(_cursor), ._delimited_length(delimited_length)));")
                pkg.append("        endcase")
                pkg.append(f"        if (wire_type == {PB_PKG}::WIRE_TYPE_DELIMITED) begin")
                pkg.append("          assert (_cursor == delimited_stop) else $display(\"_cursor: %0d delimited_stop: %0d\", _cursor, delimited_stop);")
                pkg.append("        end")
                pkg.append("      end")
                pkg.append("      assert (this.is_initialized());")
                pkg.append("    endfunction : _deserialize")
                pkg.append("")
                pkg.append("    function bit is_initialized();")
                pkg.append("      is_initialized = 1;")
                for f in sv_fields:
                    if f.label == f.LABEL_REQUIRED:
                        if f.type == FieldDescriptorProto.TYPE_MESSAGE:
                            pkg.append(f"      if (this.{f.name} == null) begin")
                            pkg.append(f"        return 0;")
                            pkg.append(f"      end")
                            pkg.append(f"      else begin")
                            pkg.append(f"        is_initialized &= this.{f.name}.is_initialized();")
                            pkg.append(f"      end")
                        else:
                            pkg.append(f"      is_initialized &= this.{f.name}__is_initialized;")
                pkg.append("    endfunction : is_initialized")

                pkg.append("    function void post_randomize();")
                for f in sv_fields:
                    if f.label == f.LABEL_REQUIRED:
                        # TODO
                        # What about strings and floats?
                        # What about rand_mode(0) fields?
                        if f.type != FieldDescriptorProto.TYPE_MESSAGE:
                            pkg.append(f"      this.{f.name}__is_initialized = 1;")
                pkg.append("    endfunction : post_randomize")

                pkg.append("")
                pkg.append(f"  endclass : {item.name}")
                pkg.append("")
                pkg.append("")
            elif isinstance(item, EnumDescriptorProto):
                pkg.append("  typedef enum {")
                for last, v in signal_last(item.value):
                    pkg.append(f"    {v.name} = {v.number}{',' if not last else ''}")
                pkg.append(f"  }} {item.name};")
                pkg.append("")
                pkg.append("")
                    
            # output.append(data)

        # Fill response
        f = response.file.add()
        f.name = os.path.basename(proto_file.name) + '.sv'

        for pkg in pkgs.values():
            pkg.finish()
            f.content += pkg.content()


def traverse(proto_file):

    def _traverse(package, items):
        for item in items:
            yield item, package

            if isinstance(item, DescriptorProto):
                for enum in item.enum_type:
                    yield enum, package

                for nested in item.nested_type:
                    nested_package = package + item.name

                    for nested_item in _traverse(nested, nested_package):
                        yield nested_item, nested_package

    return itertools.chain(
        _traverse(proto_file.package, proto_file.enum_type),
        _traverse(proto_file.package, proto_file.message_type),
    )


if __name__ == '__main__':
    # Read request message from stdin
    data = sys.stdin.buffer.read()

    # Parse request
    request = plugin.CodeGeneratorRequest()
    request.ParseFromString(data)

    # Create response
    response = plugin.CodeGeneratorResponse()

    # Generate code
    generate_code(request, response)

    # Serialise response message
    output = response.SerializeToString()

    # Write to stdout
    sys.stdout.buffer.write(output)
