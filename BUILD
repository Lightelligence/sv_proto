load("@rules_verilog//verilog:defs.bzl", "verilog_dv_library")

py_binary(
    name = "sv_plugin",
    srcs = ["sv_plugin.py"],
    visibility = ["//visibility:public"],
)

cc_binary(
    name = "pb_socket.so",
    srcs = ["pb_socket.cc", "@xcelium//:dpi_headers"],
    # Bazel doesn't seem to give access to the headers correctly when this repo
    # is used as an external
    copts = ["-I external/xcelium"],
    linkshared=True,
)

verilog_dv_library(
    name = "pb",
    srcs = [
        "pb_pkg.svh",
        "pb_decode.svh",
        "pb_encode.svh",
        "pb_socket.svh",
    ],
    dpi = [":pb_socket.so"],
    in_flist = ["pb_pkg.svh"],
    visibility = ["//visibility:public"],
)

exports_files([
    "sv_plugin.py",
])
