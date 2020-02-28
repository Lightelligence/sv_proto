#!/usr/bin/env python3
import itertools
import json
import os
import sys

import stringcase

from google.protobuf.compiler import plugin_pb2 as plugin

from google.protobuf.descriptor_pb2 import DescriptorProto, EnumDescriptorProto, FieldDescriptorProto
#import pdb; pdb.set_trace()

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

WIRE_TYPE_VARINT = 0
WIRE_TYPE_64BIT = 1
WIRE_TYPE_DELIMITED = 2
#WIRE_TYPE_START_GROUP = 3
#WIRE_TYPE_END_GROUP = 4
WIRE_TYPE_32BIT = 5

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
    FieldDescriptorProto.TYPE_BYTES    : 'byte',
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

def map_sv_type(pb_type_number):
    try:
        return PB_TYPE_NUMBER_TO_SV_TYPE[pb_type_number]
    except KeyError:
        raise NotImplementedError(f"{PB_TYPE_NUMBER_TO_PB_TYPE[pb_type_number]} not supported in SV")

PB_TYPE_NUMBER_TO_UVM_FIELD_MACRO = {
    FieldDescriptorProto.TYPE_BOOL    : 'int',
    FieldDescriptorProto.TYPE_BYTES   : 'int',
    FieldDescriptorProto.TYPE_DOUBLE  : 'real',
    FieldDescriptorProto.TYPE_ENUM    : 'enum',
    FieldDescriptorProto.TYPE_FIXED32 : 'int',
    FieldDescriptorProto.TYPE_FIXED64 : 'int',
    FieldDescriptorProto.TYPE_FLOAT   : 'real',
   #FieldDescriptorProto.TYPE_GROUP   : '',
    FieldDescriptorProto.TYPE_INT32   : 'int',
    FieldDescriptorProto.TYPE_INT64   : 'int',
    FieldDescriptorProto.TYPE_MESSAGE : 'object',
    FieldDescriptorProto.TYPE_SFIXED32: 'int',
    FieldDescriptorProto.TYPE_SFIXED64: 'int',
    FieldDescriptorProto.TYPE_SINT32  : 'int',
    FieldDescriptorProto.TYPE_SINT64  : 'int',
    FieldDescriptorProto.TYPE_STRING  : 'string',
    FieldDescriptorProto.TYPE_UINT32  : 'int',
    FieldDescriptorProto.TYPE_UINT64  : 'int',
}

# See if type should be randomized
PB_TYPE_NUMBER_TO_RAND = {
    FieldDescriptorProto.TYPE_BOOL     : 'rand ',
    FieldDescriptorProto.TYPE_BYTES    : 'rand ',
    FieldDescriptorProto.TYPE_DOUBLE   : '',
    FieldDescriptorProto.TYPE_ENUM     : 'rand ',
    FieldDescriptorProto.TYPE_FIXED32  : 'rand ',
    FieldDescriptorProto.TYPE_FIXED64  : 'rand ',
    FieldDescriptorProto.TYPE_FLOAT    : '',
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

def map_uvm_field_macro(pb_type_number):
    try:
        return PB_TYPE_NUMBER_TO_UVM_FIELD_MACRO[pb_type_number]
    except KeyError:
        raise NotImplementedError(f"{PB_TYPE_NUMBER_TO_PB_TYPE[pb_type_number]} not supported in SV")


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
                for f in item.field:
                    is_queue = "[$]" if f.label in [f.LABEL_REPEATED] else ""
                    if f.type == FieldDescriptorProto.TYPE_ENUM or f.type == FieldDescriptorProto.TYPE_MESSAGE:
                        pkg.append(f"    {PB_TYPE_NUMBER_TO_RAND[f.type]}{get_ref_type(package, imports, f.type_name)} {f.name}{is_queue};")
                    else:
                        pkg.append(f"    {PB_TYPE_NUMBER_TO_RAND[f.type]}{map_sv_type(f.type)} {f.name}{is_queue};")

                pkg.append("")

                for f in item.field:
                    pkg.append(f"    local const pb_pkg::label_e label__{f.name} = pb_pkg::{PB_LABEL_TO_ENUM[f.label]};")

                pkg.append("")
                pkg.append(f"    `uvm_object_utils_begin({item.name})")
                for f in item.field:
                    is_queue = "_queue" if f.label in [f.LABEL_REPEATED] else ""
                    if f.type == FieldDescriptorProto.TYPE_ENUM:
                        pkg.append(f"      `uvm_field{is_queue}_enum({get_ref_type(package, imports, f.type_name)}, {f.name}, UVM_ALL_ON)")
                    else:
                        pkg.append(f"      `uvm_field{is_queue}_{map_uvm_field_macro(f.type)}({f.name}, UVM_ALL_ON)")
                pkg.append("    `uvm_object_utils_end")
                pkg.append("")
                pkg.append(f"    function new(string name=\"{item.name}\");")
                pkg.append("       super.new(.name(name));")
                pkg.append("    endfunction : new")
                pkg.append("")
                pkg.append("    function void serialize(ref pb_pkg::bytestream_t _stream)")
                pkg.append("      pb_pkg::enc_stream_t enc_stream;")
                pkg.append("      this._serialize(._stream(enc_stream));")
                pkg.append("      assert (!pb_pkg::_bytestream_queue_to_dynamic_array(._out(_stream), ._in(enc_stream)));")
                pkg.append("    endfunction : serialize")
                pkg.append("")
                pkg.append("    function void _serialize(ref pb_pkg::enc_bytestream_t _stream);")
                for f in item.field:
                    # FIXME add assertions that required fields are initialized
                    is_queue = f.label in [f.LABEL_REPEATED]
                    if f.type == FieldDescriptorProto.TYPE_MESSAGE:
                        if is_queue:
                            pkg.append(f"      foreach (this.{f.name}[ii]) begin")
                            pkg.append(f"        {get_ref_type(package, imports, f.type_name)} tmp = this.{f.name}[ii];")
                        else:
                            pkg.append(f"      begin")
                            # FIXME skip if optional
                            pkg.append(f"        {get_ref_type(package, imports, f.type_name)} tmp = this.{f.name};")
                        pkg.append(f"        pb_pkg::enc_bytestream_t sub_stream;")
                        pkg.append(f"        tmp._serialize(._stream(sub_stream));")
                        pkg.append(f"        pb_pkg::encode_message_key(._field_number({f.number}),")
                        pkg.append(f"                                   ._wire_type(2),")
                        pkg.append(f"                                   ._stream(_stream));")
                        pkg.append(f"        pb_pkg::encode_varint(._value(sub_stream.size()),")
                        pkg.append(f"                              ._stream(_stream));")
                        pkg.append(f"        pb_pkg::queue_extend(._modify(_stream), ._discard(sub_stream));")
                        pkg.append(f"      end")
                    elif f.type == FieldDescriptorProto.TYPE_STRING:
                        if is_queue:
                            pkg.append(f"      foreach (this.{f.name}[ii]) begin")
                            pkg.append(f"        string tmp = this.{f.name}[ii];")
                        else:
                            pkg.append(f"      begin")
                            # FIXME skip if optional
                            pkg.append(f"        string tmp = this.{f.name};")
                        pkg.append(f"        pb_pkg::encode_message_key(._field_number({f.number}),")
                        pkg.append(f"                                   ._wire_type(2),")
                        pkg.append(f"                                   ._stream(_stream));")
                        pkg.append(f"        pb_pkg::encode_type_string(._value(tmp),")
                        pkg.append(f"                                   ._stream(_stream));")
                        pkg.append(f"      end")
                    else:
                        if f.options.packed: # Packed implies repeated?
                            pkg.append(f"      begin")
                            pkg.append(f"        pb_pkg::enc_stream_t sub_stream;")
                            pkg.append(f"        foreach (this.{f.name}[ii]) begin")
                            pkg.append(f"          pb_pkg::encode_{PB_TYPE_NUMBER_TO_PB_TYPE[f.type].lower()}(._value(this.{f.name}[ii]), ._stream(sub_stream));")
                            pkg.append(f"        end")
                            pkg.append(f"        pb_pkg::encode_message_key(._field_number({f.number}),")
                            pkg.append(f"                                   ._wire_type({WIRE_TYPE_DELIMITED}),")
                            pkg.append(f"                                   ._stream(_stream));")
                            pkg.append(f"        pb_pkg::encode_varint(._value(sub_stream.size()),")
                            pkg.append(f"                              ._stream(_stream));")
                            pkg.append(f"        pb_pkg::queue_extend(._modify(_stream), ._discard(sub_stream));")
                            pkg.append(f"      end")
                        else:
                            if is_queue:
                                pkg.append(f"      foreach (this.{f.name}[ii]) begin")
                                pkg.append(f"        {map_sv_type(f.type)} tmp = this.{f.name}[ii];")
                            else:
                                pkg.append(f"      begin")
                                # FIXME skip if optional
                                pkg.append(f"        {map_sv_type(f.type)} tmp = this.{f.name};")
                            pkg.append(f"        pb_pkg::encode_message_key(._field_number({f.number}),")
                            pkg.append(f"                                   ._wire_type({PB_TYPE_NUMBER_TO_WIRE_TYPE[f.type]}),")
                            pkg.append(f"                                   ._stream(_stream));")
                            pkg.append(f"        pb_pkg::encode_{PB_TYPE_NUMBER_TO_PB_TYPE[f.type].lower()}(._value(this.{f.name}), ._stream(_stream));")
                            pkg.append("      end")
                pkg.append("")
                pkg.append("    endfunction : _serialize")
                pkg.append("")
                pkg.append("    function void deserialize(ref pb_pkg::bytestream_t _stream);")
                pkg.append("      pb_pkg::cursor_t cursor = 0;")
                pkg.append("      pb_pkg::cursor_t cursor_stop = -1;")
                pkg.append("      this._deserialize(._stream(_stream), ._cursor(cursor), ._cursor_stop(cursor_stop));")
                pkg.append("    endfunction : deserialize")
                pkg.append("")
                pkg.append("    function void _deserialize(ref pb_pkg::bytestream_t _stream, ref pb_pkg::cursor_t _cursor, input pb_pkg::cursor_t _cursor_stop);")
                pkg.append("      pb_pkg::cursor_t stream_size = _stream.size();")
                pkg.append("      while ((_cursor < stream_size) && (_cursor < _cursor_stop)) begin")
                pkg.append("        pb_pkg::field_number_t field_number;")
                pkg.append("        pb_pkg::wire_type_t wire_type;")
                pkg.append("        pb_pkg::varint_t wire_type_2_length;")
                pkg.append("        pb_pkg::cursor_t packed_stop;")
                pkg.append("        assert (!pb_pkg::decode_message_key(._field_number(field_number),")
                pkg.append("                                            ._wire_type(wire_type),")
                pkg.append("                                            ._stream(_stream),")
                pkg.append("                                            ._cursor(_cursor)));")
                pkg.append("        if (wire_type == 2) begin")
                pkg.append("            assert (!pb_pkg::decode_varint(._varint(wire_type_2_length),")
                pkg.append("                                           ._stream(_stream),")
                pkg.append("                                           ._cursor(_cursor)));")
                pkg.append("            packed_stop = _cursor + wire_type_2_length;")
                pkg.append("        end")
                pkg.append("        case (field_number)")
                for f in item.field:
                    is_queue = f.label in [f.LABEL_REPEATED]
                    pkg.append(f"          {f.number}: begin")
                    # FIXME add assertions that appropriate wire_type was received if not delimited
                    if f.type == FieldDescriptorProto.TYPE_MESSAGE:
                        result_var = f.name
                        if is_queue:
                            result_var = f"tmp_{f.name}"
                            pkg.append(f"            {get_ref_type(package, imports, f.type_name)} {result_var};")
                        pkg.append(f"            assert (wire_type == 2);")
                        pkg.append(f"            {result_var} = {get_ref_type(package, imports, f.type_name)}::type_id::create();")
                        pkg.append(f"            {result_var}._deserialize(._stream(_stream), ._cursor(_cursor), ._cursor_stop(_cursor + wire_type_2_length));")
                        if is_queue:
                            pkg.append(f"            this.{f.name}.push_back({result_var});")
                    elif f.type == FieldDescriptorProto.TYPE_STRING:
                        result_var = f.name
                        if is_queue:
                            result_var = f"tmp_{f.name}"
                            pkg.append(f"            {map_sv_type(f.type)} {result_var};")
                        pkg.append(f"            assert (wire_type == 2);")
                        pkg.append(f"            assert (!pb_pkg::decode_{PB_TYPE_NUMBER_TO_PB_TYPE[f.type].lower()}(._result({result_var}), ._stream(_stream), ._cursor(_cursor), ._str_length(wire_type_2_length)));")
                        if is_queue:
                            pkg.append(f"            this.{f.name}.push_back({result_var});")
                    else:
                        result_var = f.name
                        if is_queue:
                            result_var = f"tmp_{f.name}"
                            pkg.append(f"            {map_sv_type(f.type)} {result_var};")
                        pkg.append(f"            do begin")
                        pkg.append(f"              assert (!pb_pkg::decode_{PB_TYPE_NUMBER_TO_PB_TYPE[f.type].lower()}(._result({result_var}), ._stream(_stream), ._cursor(_cursor)));")
                        if is_queue:
                            pkg.append(f"              this.{f.name}.push_back({result_var});")
                        pkg.append(f"            end while ((wire_type == 2) && (_cursor < packed_stop));")
                    pkg.append(f"          end")

                pkg.append("          default : assert (!pb_pkg::decode_and_consume_unknown(._wire_type(wire_type), ._stream(_stream), ._cursor(_cursor), ._wire_type_2_length(wire_type_2_length)));")
                pkg.append("        endcase")
                pkg.append("        if (wire_type == 2) begin")
                pkg.append("          assert (_cursor == packed_stop) else $display(\"_cursor: %0d packed_stop: %0d\", _cursor, packed_stop);")
                pkg.append("        end")
                pkg.append("      end")
                # FIXME add assertions that required fields were initialized
                pkg.append("    endfunction : _deserialize")
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
