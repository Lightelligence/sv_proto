load("//:sv_proto.bzl", "sv_proto_library")
load("@rules_verilog//verilog:defs.bzl", "verilog_dv_unit_test")

def golden_test(name):
    """Compares a generated file to a statically checked in file."""

    sv_proto_library(
        name = name,
        srcs = ["proto/{}.proto".format(name)],
    )

    native.sh_test(
        name = "{}_gold_test".format(name),
        size = "small",
        srcs = ["passthrough.sh"],
        data = [
            ":{}_sv".format(name),
            "golden/{}.proto.sv".format(name),
        ],
        args = ["diff $(location :{name}_sv) $(location golden/{name}.proto.sv)".format(name=name)],
        tags = ["gold"],
    )

    verilog_dv_unit_test(
        name = "{}_compile_test".format(name),
        deps = [
            ":{}".format(name),
        ],
    )

def golden_test_glob(proto_files):
    """Runs all golden tests"""
    for proto in proto_files:
        proto = proto.rsplit('/', 1)[1]
        proto = proto[:-6]
        golden_test(proto)
