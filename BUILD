load("@verilog_tools//:dv.bzl", "dv_lib")

py_binary(
    name = "sv_plugin",
    srcs = ["sv_plugin.py"],
    visibility = ["//visibility:public"],
)

cc_binary(
    name = "pb_socket.so",
    srcs = ["pb_socket.cc", "@xcelium//:dpi_headers"],
    linkshared=True,
)

dv_lib(
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
