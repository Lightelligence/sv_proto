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
    8  : 'TYPE_BOOL',
    12 : 'TYPE_BYTES',
    1  : 'TYPE_DOUBLE',
    14 : 'TYPE_ENUM',
    7  : 'TYPE_FIXED32',
    6  : 'TYPE_FIXED64',
    2  : 'TYPE_FLOAT',
    10 : 'TYPE_GROUP',
    5  : 'TYPE_INT32',
    3  : 'TYPE_INT64',
    11 : 'TYPE_MESSAGE',
    15 : 'TYPE_SFIXED32',
    16 : 'TYPE_SFIXED64',
    17 : 'TYPE_SINT32',
    18 : 'TYPE_SINT64',
    9  : 'TYPE_STRING',
    13 : 'TYPE_UINT32',
    4  : 'TYPE_UINT64',
}

PB_TYPE_NUMBER_TO_SV_TYPE = {
    8  : 'bit'              , # TYPE_BOOL
    12 : 'byte'             , # TYPE_BYTES
    1  : 'real'             , # TYPE_DOUBLE
    14 : 'enum'             , # TYPE_ENUM # FIXME
    # 7  : ''               , # TYPE_FIXED32
    # 6  : ''               , # TYPE_FIXED64
    2  : 'shortreal'        , # TYPE_FLOAT
    # 10 : ''               , # TYPE_GROUP
    5  : 'int'              , # TYPE_INT32
    3  : 'longint'          , # TYPE_INT64
    # 11 : ''               , # TYPE_MESSAGE
    # 15 : ''               , # TYPE_SFIXED32
    # 16 : ''               , # TYPE_SFIXED64
    # 17 : ''               , # TYPE_SINT32
    # 18 : ''               , # TYPE_SINT64
    9  : 'string'           , # TYPE_STRING
    13 : 'int unsigned'     , # TYPE_UINT32
    4  : 'longint unsigned' , # TYPE_UINT64
}    

def map_sv_type(pb_type_number):
    try:
        return PB_TYPE_NUMBER_TO_SV_TYPE[pb_type_number]
    except KeyError:
        raise NotImplementedError(f"{PB_TYPE_NUMBER_TO_PB_TYPE[pb_type_number]} not supported in SV")

PB_TYPE_NUMBER_TO_UVM_FIELD_MACRO = {
    8  : 'int'    , # TYPE_BOOL
    12 : 'int'    , # TYPE_BYTES
    1  : 'real'   , # TYPE_DOUBLE
    14 : 'enum'   , # TYPE_ENUM # FIXME
    # 7  : ''     , # TYPE_FIXED32
    # 6  : ''     , # TYPE_FIXED64
    2  : 'real'   , # TYPE_FLOAT
    # 10 : ''     , # TYPE_GROUP
    5  : 'int'    , # TYPE_INT32
    3  : 'int'    , # TYPE_INT64
    # 11 : ''     , # TYPE_MESSAGE
    # 15 : ''     , # TYPE_SFIXED32
    # 16 : ''     , # TYPE_SFIXED64
    # 17 : ''     , # TYPE_SINT32
    # 18 : ''     , # TYPE_SINT64
    9  : 'string' , # TYPE_STRING
    13 : 'int'    , # TYPE_UINT32
    4  : 'int'    , # TYPE_UINT64
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
                    if f.type == FieldDescriptorProto.TYPE_ENUM:
                        pkg.append(f"    {get_ref_type(package, imports, f.type_name)} {f.name};")
                    else:
                        pkg.append(f"    {map_sv_type(f.type)} {f.name};")

                pkg.append("")
                pkg.append(f"    `uvm_object_utils_begin({item.name})")
                for f in item.field:
                    if f.type == FieldDescriptorProto.TYPE_ENUM:
                        pkg.append(f"      `uvm_field_enum({get_ref_type(package, imports, f.type_name)}, {f.name}, UVM_ALL_ON)")
                    else:
                        pkg.append(f"      `uvm_field_{map_uvm_field_macro(f.type)}({f.name}, UVM_ALL_ON)")
                pkg.append("    `uvm_object_utils_end")
                pkg.append("")
                pkg.append(f"    function new(string name=\"{item.name}\");")
                pkg.append("       super.new(.name(name));")
                pkg.append("    endfunction : new")
                pkg.append("")
                pkg.append("    function void deserialize(ref pb_pkg::bytestream_t _stream, ref pb_pkg::cursor_t _cursor, ref pb_pkg::cursor_t _cursor_stop);")
                pkg.append("      pb_pkg::cursor_t stream_size = _stream.size();")
                pkg.append("      while ((_cursor < stream_size) && (_cursor < _cursor_stop)) begin")
                pkg.append("        pb_pkg::field_number_t field_number;")
                pkg.append("        pb_pkg::wire_type_t wire_type;")
                pkg.append("        assert (!pb_pkg::decode_message_key(._field_number(field_number),")
                pkg.append("                                            ._wire_type(field_number),")
                pkg.append("                                            ._stream(_stream),")
                pkg.append("                                            ._cursor(_cursor)));")
                pkg.append("        case (field_number)")
                for f in item.field:
                    pkg.append(f"          {f.number}: assert (!pb_pkg::decode_{PB_TYPE_NUMBER_TO_PB_TYPE[f.type].lower()}(._result({f.name}), ._stream(_stream), ._cursor(_cursor)));")
                pkg.append("          default : assert (!pb_pkg::decode_and_consume_unknown(._wire_type(wire_type), ._stream(_stream), ._cursor(_cursor)));")
                pkg.append("        endcase")
                pkg.append("      end")
                pkg.append("    endfunction : deserialize")
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
