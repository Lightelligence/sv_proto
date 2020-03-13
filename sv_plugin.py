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
        
    def extend(self, lines):
        self._lines.extend(lines)

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
    def __init__(self, f, package, imports, maps):
        self.f = f
        self.package = package
        self.imports = imports
        self.maps = maps
        try:
            self.sv_map = self.maps[self.type_name.rsplit(".")[-1]]
        except KeyError:
            self.sv_map = False

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
    def sv_var_declaration(self):
        if self.sv_map:
            rand = PB_TYPE_NUMBER_TO_RAND[self.sv_map.sv_value.type]
            return f"{rand}{self.sv_map.sv_value.sv_type} {self.name}[{self.sv_map.sv_key.sv_type}];"
        else:
            return f"{self.sv_rand}{self.sv_type} {self.name}{self.sv_queue}{self.sv_default};"

    @property
    def sv_wire_type(self):
        return f"{PB_TYPE_NUMBER_TO_WIRE_TYPE[self.type]}"
    
    def sv_number(self, prefix=""):
        return f"{prefix}{self.name}__field_number"

    def sv_number_declaration_lines(self, prefix=""):
        lines = []
        lines.append(f"    local const {PB_PKG}::field_number_t {prefix}{self.sv_number()} = {self.number};")
        if self.sv_map:
            lines.extend(self.sv_map.sv_number_declaration_lines(prefix=f"{self.name}_"))
        return lines

    def sv_do_compare_lines(self, indent=0, varname=""):
        lines = []
        if self.sv_map:
            lines.extend(self.sv_map.sv_do_compare_lines(indent=2, varname=self.name))
        else:
            if not varname:
                varname = self.name
            if self.type == self.TYPE_MESSAGE:
                if self.label == self.LABEL_REPEATED:
                    lines.append(f"res &= (this.{self.name}.size() == rhs_cast.{self.name}.size());")
                    lines.append(f"foreach (this.{self.name}[xx]) begin")
                    varname = f"{self.name}[xx]"
                lines.append(f"  res &= this.{varname}.do_compare(rhs_cast.{varname}, comparer);")
                if self.label == self.LABEL_REPEATED:
                    lines.append("end")
            else:
                lines.append(f"res &= (this.{varname} == rhs_cast.{varname});")
        return [" "*indent + line for line in lines]

    def sv_do_print_lines(self, indent=4, var="", var_name=""):
        lines = []
        if not var:
            var = f"this.{self.name}"
            var_name = f'"{self.name}"'
        orig_var = var
        if self.label == self.LABEL_REPEATED:
            lines.append(f"printer.print_array_header(\"{var}\", {var}.size());")
            lines.append(f"foreach({var}[xx]) begin")
            if not self.sv_map:
                var = f"{var}[xx]"
                var_name = f'$sformatf("%0d", xx)'
        if self.sv_map:
            lines.extend(self.sv_map.sv_do_print_lines(indent=2, var_name=self.name))
        elif self.type == self.TYPE_MESSAGE:
            lines.append(f"  printer.print_object({var_name}, {var});")
        elif self.type in [self.TYPE_STRING]:
            lines.append(f"  printer.print_string({var_name}, {var});")
        elif self.type in [self.TYPE_BYTES]:
            lines.append(f"  printer.print_generic({var_name}, \"bytes\", {var}.size(), $sformatf(\"%p\", {var}));")
        elif self.type in [self.TYPE_FLOAT, self.TYPE_DOUBLE]:
            lines.append(f"  printer.print_real({var_name}, {var});")
        else:
            if self.type in [self.TYPE_BOOL]:
                size = 1
                radix = "UVM_BIN"
            elif self.type in [self.TYPE_FIXED32,
                               self.TYPE_INT32,
                               self.TYPE_SFIXED32,
                               self.TYPE_SINT32]:
                size = 32
                radix = "UVM_DEC"
            elif self.type in [self.TYPE_UINT32]:
                size = 32
                radix = "UVM_HEX"
            elif self.type in [self.TYPE_FIXED64,
                               self.TYPE_INT64,
                               self.TYPE_SFIXED64,
                               self.TYPE_SINT64]:
                size = 64
                radix = "UVM_DEC"
            elif self.type in [self.TYPE_UINT64]:
                size = 64
                radix = "UVM_HEX"
            elif self.type in [self.TYPE_ENUM]:
                size = 32
                radix = "UVM_ENUM"
            else:
                raise ValueError("Unknown field type")
            lines.append(f"  printer.print_field_int({var_name}, {var}, {size}, {radix});")
        if self.label == self.LABEL_REPEATED:
            lines.append("end")
            lines.append(f"printer.print_array_footer({orig_var}.size());")
        return [" "*indent + line for line in lines]

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

    def sv_deserialize(self, indent, result_var="", field_number_prefix=""):
        lines = []
        lines.append(f"////////////////////////////////")
        lines.append(f"// {self.name}")
        lines.append(f"{self.sv_number(prefix=field_number_prefix)}: begin")

        if self.sv_map:
            lines.extend(self.sv_map.sv_deserialize(indent=2, varname=self.name, field_number_prefix=f"{self.name}_"))
        else:
            if result_var == "":
                result_var = self.name
            if self.sv_queue:
                result_var = f"tmp_{self.name}"
                lines.append(f"  {self.sv_type} {result_var};")
            if self.type == self.TYPE_MESSAGE:
                lines.append(f"  assert (wire_type == {PB_PKG}::WIRE_TYPE_DELIMITED);")
                lines.append(f"  {result_var} = {self.sv_type}::type_id::create();")
                lines.append(f"  {result_var}._deserialize(._stream(_stream), ._cursor(_cursor), ._cursor_stop(_cursor + delimited_length));")
                if self.sv_queue:
                    lines.append(f"  this.{self.name}.push_back({result_var});")
            elif self.type in [self.TYPE_STRING, self.TYPE_BYTES]:
                lines.append(f"  assert (wire_type == {PB_PKG}::WIRE_TYPE_DELIMITED);")
                lines.append(f"  assert (!{PB_PKG}::{self.sv_decode_func}(._result({result_var}), ._stream(_stream), ._cursor(_cursor), ._str_length(delimited_length)));")
                if self.sv_queue:
                    lines.append(f"  this.{self.name}.push_back({result_var});")
            else:
                lines.append(f"  assert ((wire_type == {PB_PKG}::WIRE_TYPE_DELIMITED) || (wire_type == {PB_PKG}::{self.sv_wire_type}));")
                lines.append(f"  do begin")
                if self.type == self.TYPE_ENUM:
                    lines.append(f"    {PB_PKG}::varint_t tmp_varint;")
                    result_var_enum = result_var
                    result_var = "tmp_varint"
                lines.append(f"    assert (!{PB_PKG}::{self.sv_decode_func}(._result({result_var}), ._stream(_stream), ._cursor(_cursor)));")
                if self.type == self.TYPE_ENUM:
                    result_var = result_var_enum
                    lines.append(f"    {result_var} = {self.sv_type}'(tmp_varint);")
                if self.sv_queue:
                    lines.append(f"    this.{self.name}.push_back({result_var});")
                lines.append(f"  end while ((wire_type == {PB_PKG}::WIRE_TYPE_DELIMITED) && (_cursor < delimited_stop));")
            if self.label == self.LABEL_REQUIRED:
                if self.type != FieldDescriptorProto.TYPE_MESSAGE:
                    lines.append(f"  this.m_is_initialized[\"{self.name}\"] = 1;")
        if self.HasField("oneof_index"):
            lines.append(f"  this.{self.sv_oneof_inst} = {self.sv_oneof_value};")
        lines.append(f"end")
        return [" "*indent + line for line in lines]

    def sv_serialize_lines(self, indent, stream="_stream", result_var="", field_number_prefix=""):
        lines = []
        # FIXME add assertions that required fields are initialized
        if self.HasField("oneof_index"):
            lines.append(f"if ({self.sv_oneof_inst} == {self.sv_oneof_value}) begin")

        if self.sv_map:
            lines.extend(self.sv_map.sv_serialize_lines(indent=0, varname=self.name, field_number_prefix=f"{self.name}_"))
        elif self.type == self.TYPE_MESSAGE:
            if self.sv_queue:
                lines.append(f"foreach (this.{self.name}[ii]) begin")
                result_var = f"this.{self.name}[ii]"
            else:
                if not result_var:
                    result_var = f"this.{self.name}"
                lines.append(f"if ({result_var}) begin")
                # FIXME error if required
            lines.append(f"  {PB_PKG}::enc_bytestream_t sub_stream;")
            lines.append(f"  {result_var}._serialize(._stream(sub_stream));")
            lines.append(f"  {PB_PKG}::encode_delimited(._field_number(this.{self.sv_number(field_number_prefix)}),")
            lines.append(f"                           ._delimited_stream(sub_stream),")
            lines.append(f"                           ._stream({stream}));")
            lines.append(f"end")
        elif self.type in [self.TYPE_STRING, self.TYPE_BYTES]:
            if self.sv_queue:
                lines.append(f"foreach (this.{self.name}[ii]) begin")
                result_var = f"this.{self.name}[ii]"
            else:
                if not result_var:
                    result_var = f"this.{self.name}"
                size_func = "len" if self.type == self.TYPE_STRING else "size"
                lines.append(f"if ({result_var}.{size_func}()) begin")
                # FIXME error if required
            lines.append(f"  {PB_PKG}::encode_message_key(._field_number(this.{self.sv_number(field_number_prefix)}),")
            lines.append(f"                             ._wire_type({PB_PKG}::WIRE_TYPE_DELIMITED),")
            lines.append(f"                             ._stream({stream}));")
            lines.append(f"  {PB_PKG}::{self.sv_encode_func}(._value({result_var}),")
            lines.append(f"                             ._stream({stream}));")
            lines.append(f"end")
        else:
            if self.options.packed: # Packed implies repeated
                lines.append(f"if (this.{self.name}.size()) begin")
                lines.append(f"  {PB_PKG}::enc_bytestream_t sub_stream;")
                lines.append(f"  foreach (this.{self.name}[ii]) begin")
                lines.append(f"    {PB_PKG}::{self.sv_encode_func}(._value(this.{self.name}[ii]), ._stream(sub_stream));")
                lines.append(f"  end")
                lines.append(f"  {PB_PKG}::encode_delimited(._field_number(this.{self.sv_number(field_number_prefix)}),")
                lines.append(f"                           ._delimited_stream(sub_stream),")
                lines.append(f"                           ._stream({stream}));")
                lines.append(f"end")
            else:
                if self.sv_queue:
                    lines.append(f"foreach (this.{self.name}[ii]) begin")
                    lines.append(f"  {self.sv_type} tmp = this.{self.name}[ii];")
                    result_var = f"this.{self.name}[ii]"

                else:
                    if not self.HasField("oneof_index"):
                        lines.append(f"begin")
                    # FIXME skip if optional
                    if not result_var:
                        result_var = f"this.{self.name}"
                lines.append(f"  {PB_PKG}::encode_message_key(._field_number(this.{self.sv_number(field_number_prefix)}),")
                lines.append(f"                             ._wire_type({PB_PKG}::{self.sv_wire_type}),")
                lines.append(f"                             ._stream({stream}));")
                lines.append(f"  {PB_PKG}::{self.sv_encode_func}(._value({result_var}), ._stream({stream}));")
                if not self.HasField("oneof_index"):
                    lines.append("end")
        if self.HasField("oneof_index"):
            lines.append("end")
        return [' '*indent + line for line in lines]


class SVDescriptorProto():

    def __init__(self, item, package, imports):
        self.item = item
        self.package = package
        self.imports = imports

        # Need to expand maps
        maps = {}
        for nt in self.nested_type:
            if nt.options.map_entry:
                maps[nt.name] = SVMapDescriptorProto(nt, package, imports)

        self.sv_fields = [SVFieldDescriptorProto(f, package, imports, maps) for f in self.field]

    def __getattr__(self, attribute):
        try:
            return super(SVDescriptorProto, self).__getattr__(attribute)
        except AttributeError:
            return getattr(self.item, attribute)

class SVMapDescriptorProto(SVDescriptorProto):
    def __init__(self, *args, **kwargs):
        super(SVMapDescriptorProto, self).__init__(*args, **kwargs)
        for f in self.sv_fields:
            if f.name == "key":
                self.sv_key = f
            if f.name == "value":
                self.sv_value = f

    def sv_number_declaration_lines(self, prefix=""):
        lines = []
        for f in self.sv_fields:
            lines.append(f"    local const {PB_PKG}::field_number_t {prefix}{f.sv_number()} = {f.number};")
        return lines

    def sv_do_print_lines(self, indent=0, var_name=""):
        lines = []
        lines.extend(self.sv_key.sv_do_print_lines(indent=indent, var='xx', var_name='"key"'))
        lines.extend(self.sv_value.sv_do_print_lines(indent=indent, var=f"{var_name}[xx]", var_name='"value"'))
        return [" "*indent + line for line in lines]

    def sv_do_compare_lines(self, indent=0, varname=""):
        lines = []
        lines.append(f"res &= (this.{varname}.size() == rhs_cast.{varname}.size());")
        lines.append(f"foreach (this.{varname}[xx]) begin")
        lines.append(f"  if (!rhs_cast.{varname}.exists(xx)) begin")
        lines.append(f"    res = 0;")
        lines.append(f"  end")
        lines.append(f"  else begin")
        lines.extend(self.sv_value.sv_do_compare_lines(indent=4, varname=f"{varname}[xx]"))
        lines.append(f"  end")
        lines.append(f"end")
        return [" "*indent + line for line in lines]

    def sv_deserialize(self, indent, varname, field_number_prefix):
        lines = []
        lines.append(f"  {self.sv_key.sv_type} found_key;")
        lines.append(f"  {self.sv_value.sv_type} found_value;")
        lines.append(f"  assert (wire_type == {PB_PKG}::WIRE_TYPE_DELIMITED);")
        lines.append(f"  while ((_cursor < stream_size) && (_cursor < delimited_stop)) begin")
        lines.append(f"    assert (!pb_pkg::decode_message_key(._field_number(field_number),")
        lines.append(f"                                        ._wire_type(wire_type),")
        lines.append(f"                                        ._stream(_stream),")
        lines.append(f"                                        ._cursor(_cursor)));")
        lines.append(f"    if (wire_type == {PB_PKG}::WIRE_TYPE_DELIMITED) begin")
        lines.append(f"        assert (!{PB_PKG}::decode_varint(._value(delimited_length),")
        lines.append("                                       ._stream(_stream),")
        lines.append("                                       ._cursor(_cursor)));")
        lines.append("    end")
        #lines.append(f"    $display(\"sub field_number=%0d\", field_number);")
        lines.append(f"    case (field_number)")
        lines.extend(self.sv_key.sv_deserialize(indent=6, result_var='found_key', field_number_prefix=field_number_prefix))
        lines.extend(self.sv_value.sv_deserialize(indent=6, result_var='found_value', field_number_prefix=field_number_prefix))
        lines.append(f"      default : assert (!pb_pkg::decode_and_consume_unknown(._wire_type(wire_type), ._stream(_stream), ._cursor(_cursor), ._delimited_length(delimited_length)));")
        lines.append(f"    endcase")
        lines.append(f"  end")
        #lines.append(f"  $display(\"{varname}[%0d] = %0d\", found_key, found_value);")
        # lines.append(f"  $display(\"{varname}[%0d] = %s\", found_key, found_value);")
        lines.append(f"  {varname}[found_key] = found_value;")

        return [" "*indent + line for line in lines]

    def sv_serialize_lines(self, indent, varname, field_number_prefix=""):
        lines = []
        substream = f"{varname}_sub_stream"
        lines.append("begin")
        lines.append(f"  foreach (this.{varname}[xx]) begin")
        lines.append(f"    {PB_PKG}::enc_bytestream_t {substream};")
        lines.append(f"    {self.sv_key.sv_type} found_key = xx;")
        lines.append(f"    {self.sv_value.sv_type} found_value = this.{varname}[xx];")
        lines.extend(self.sv_key.sv_serialize_lines(indent=4, result_var='found_key', field_number_prefix=field_number_prefix, stream=substream))
        lines.extend(self.sv_value.sv_serialize_lines(indent=4, result_var='found_value', field_number_prefix=field_number_prefix, stream=substream))
        lines.append(f"    {PB_PKG}::encode_delimited(._field_number({varname}__field_number),")
        lines.append(f"                             ._delimited_stream({substream}),")
        lines.append(f"                             ._stream(_stream));")
        lines.append(f"  end")
        lines.append("end")
        return [" "*indent + line for line in lines]

    
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

                item = SVDescriptorProto(item, package, imports)
                #lines.append(str(dir(FieldDescriptorProto)))
                pkg.append(f"  class {item.name} extends uvm_object;")
                pkg.append("")

                pkg.append("    ///////////////////////////////////////////////////////////////////////////")
                pkg.append("    // Public Variables")
                
                for f in item.sv_fields:
                    pkg.append(f"    {f.sv_var_declaration}")
                pkg.append("")

                pkg.append("    ///////////////////////////////////////////////////////////////////////////")
                pkg.append("    // Bookkeeping Variables")
                for i, oneof in enumerate(item.oneof_decl):
                    oneof_inst = f"oneof__{oneof.name}"
                    oneof_type = f"{oneof_inst}_e"
                    pkg.append(f"    typedef enum {{")
                    pkg.append(f"      {oneof_inst}__uninitialized")
                    for f in item.sv_fields:
                        if f.HasField("oneof_index") and \
                           f.oneof_index == i:
                            f.sv_oneof_inst = oneof_inst;
                            f.sv_oneof_value = f"{oneof_inst}__{f.name}"
                            pkg.append(f"     ,{f.sv_oneof_value}")
                    pkg.append(f"    }} {oneof_type};")
                    pkg.append(f"    rand {oneof_type} {oneof_inst} = {oneof_inst}__uninitialized;")
                    pkg.append(f"    constraint {oneof_inst}_cnstr {{")
                    pkg.append(f"      {oneof_inst} != {oneof_inst}__uninitialized;")
                    pkg.append(f"    }}")
                    pkg.append("")
                
                for f in item.sv_fields:
                    pkg.extend(f.sv_number_declaration_lines())
                pkg.append("")

                # TODO
                # Not sure how to set these if not randomizing the object
                # Using getters/setters isn't worthwhile if the member is local
                # Making the member local makes it more difficult to randomize
                pkg.append("    bit m_is_initialized[string];");
                pkg.append("")

                pkg.append(f"    `uvm_object_utils({item.name})")
                pkg.append("")
                pkg.append(f"    function new(string name=\"{item.name}\");")
                pkg.append("       super.new(.name(name));")
                for f in item.sv_fields:
                    if f.label == f.LABEL_REQUIRED:
                      # Message fields should be calculated recursively, do they don't need an entry in this map
                      if f.type != FieldDescriptorProto.TYPE_MESSAGE:
                          pkg.append(f"    this.m_is_initialized[\"{f.name}\"] = 0;")
                pkg.append("    endfunction : new")
                pkg.append("")
                pkg.append(f"    function void serialize(ref {PB_PKG}::bytestream_t _stream);")
                pkg.append(f"      {PB_PKG}::enc_bytestream_t enc_stream;")
                pkg.append("      this._serialize(._stream(enc_stream));")
                pkg.append(f"      {PB_PKG}::_bytestream_queue_to_dynamic_array(._out(_stream), ._in(enc_stream));")
                pkg.append("    endfunction : serialize")
                pkg.append("")
                pkg.append(f"    function void _serialize(ref {PB_PKG}::enc_bytestream_t _stream);")
                pkg.append(f"      assert (this.is_initialized());")
                for f in item.sv_fields:
                    pkg.extend(f.sv_serialize_lines(indent=6))
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
                # pkg.append(f"    $display(\"field_number=%0d\", field_number);")
                pkg.append("        case (field_number)")
                for f in item.sv_fields:
                    pkg.extend(f.sv_deserialize(indent=10))
                pkg.append(f"          default : assert (!{PB_PKG}::decode_and_consume_unknown(._wire_type(wire_type), ._stream(_stream), ._cursor(_cursor), ._delimited_length(delimited_length)));")
                pkg.append("        endcase")
                pkg.append(f"        if (wire_type == {PB_PKG}::WIRE_TYPE_DELIMITED) begin")
                pkg.append("          assert (_cursor == delimited_stop) else $display(\"_cursor: %0d delimited_stop: %0d\", _cursor, delimited_stop);")
                pkg.append("        end")
                pkg.append("      end")
                pkg.append("      if (!this.is_initialized()) begin")
                pkg.append("        `uvm_error(this.get_name(), \"Deserialize didn't result in proper initialization\")")
                pkg.append("      end")
                pkg.append("    endfunction : _deserialize")
                pkg.append("")
                pkg.append("    function bit is_initialized();")
                pkg.append("      is_initialized = 1;")
                pkg.append("      foreach (this.m_is_initialized[field_name]) begin")
                pkg.append("        if (!this.m_is_initialized[field_name]) begin")
                pkg.append("          `uvm_warning(this.get_name(), $sformatf(\"required field '%s' was not initialized\", field_name))")
                pkg.append("          is_initialized = 0;")
                pkg.append("        end")
                pkg.append("      end")
                for f in item.sv_fields:
                    if f.label == f.LABEL_REQUIRED:
                        if f.type == FieldDescriptorProto.TYPE_MESSAGE:
                            pkg.append(f"      if (this.{f.name} == null) begin")
                            pkg.append(f"        `uvm_warning(this.get_name(), \"required field '{f.name}' is null\")")
                            pkg.append(f"        is_initialized = 0;")
                            pkg.append(f"      end")
                            pkg.append(f"      else begin")
                            pkg.append(f"        is_initialized &= this.{f.name}.is_initialized();")
                            pkg.append(f"      end")
                for i, oneof in enumerate(item.oneof_decl):
                    oneof_inst = f"oneof__{oneof.name}"
                    oneof_type = f"{oneof_inst}_e"
                    pkg.append(f"      if ({oneof_inst} == {oneof_inst}__uninitialized) begin")
                    pkg.append(f"        `uvm_warning(this.get_name(), \"oneof '{oneof.name}' has no initialized member\")")
                    pkg.append(f"        is_initialized = 0;")
                    pkg.append(f"      end")
                pkg.append("    endfunction : is_initialized")
                pkg.append("")
                pkg.append("    function void post_randomize();")
                for f in item.sv_fields:
                    if f.label == f.LABEL_REQUIRED:
                        # TODO
                        # What about strings and floats?
                        # What about rand_mode(0) fields?
                        if f.type != FieldDescriptorProto.TYPE_MESSAGE:
                            pkg.append(f"      this.m_is_initialized[\"{f.name}\"] = 1;")
                pkg.append("    endfunction : post_randomize")
                pkg.append("")
                pkg.append(f"  virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);")
                pkg.append(f"    bit res;")
                pkg.append(f"    {item.name} rhs_cast;")
                pkg.append(f"    $cast(rhs_cast, rhs);")
                pkg.append(f"    res = super.do_compare(rhs, comparer);")
                for i, oneof in enumerate(item.oneof_decl):
                    pkg.append(f"    case (this.oneof__{oneof.name})")
                    for f in item.sv_fields:
                        if f.HasField("oneof_index") and f.oneof_index == i:
                            pkg.append(f"      {f.sv_oneof_value}: begin")
                            pkg.extend(f.sv_do_compare_lines(indent=6))
                            pkg.append("end")
                    pkg.append("      default: begin")
                    pkg.append("        `uvm_error(this.get_name(), \"oneof_{oneof.name} uninitialized in do_compare\")")
                    pkg.append("        res = 0;")
                    pkg.append("      end")
                    pkg.append("    endcase")
                for f in item.sv_fields:
                    if f.HasField("oneof_index"):
                        pass # Created above when looping through oneofs
                    else:
                        pkg.extend(f.sv_do_compare_lines(indent=2))
                pkg.append(f"    return res;")
                pkg.append(f"  endfunction : do_compare")
                pkg.append("")
                pkg.append("  virtual function void do_print( uvm_printer printer );")
                pkg.append("    super.do_print( printer );")
                for i, oneof in enumerate(item.oneof_decl):
                    pkg.append(f"    case (this.oneof__{oneof.name})")
                    for f in item.sv_fields:
                        if f.HasField("oneof_index") and f.oneof_index == i:
                            pkg.append(f"      {f.sv_oneof_value}: begin")
                            pkg.extend(f.sv_do_print_lines(indent=8))
                            pkg.append(f"      end")
                    pkg.append("      default: begin")
                    pkg.append("        `uvm_error(this.get_name(), \"oneof_{oneof.name} uninitialized in do_print\")")
                    pkg.append("      end")
                    pkg.append("    endcase")
                for f in item.sv_fields:
                    if f.HasField("oneof_index"):
                        pass # Created above when looping through oneofs
                    else:
                        pkg.extend(f.sv_do_print_lines(indent=4))
                pkg.append("  endfunction : do_print")
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

    # with open("/u/wstucker/w/mosaic/sv_proto/stdin.txt", 'wb') as f:
    #     f.write(data)

    # with open("/u/wstucker/w/mosaic/sv_proto/stdin.txt", 'rb') as f:
    #     data = f.read()

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

