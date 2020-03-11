py_binary(
    name = "sv_plugin",
    srcs = ["sv_plugin.py"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "pb",
    srcs = [
        "pb_pkg.svh",
        "pb_decode.svh",
        "pb_encode.svh",
        "pb_socket.svh",
    ],
    visibility = ["//visibility:public"],
)

cc_binary(
    name = "pb_socket.so",
    srcs = ["pb_socket.cc", "@xcelium//:dpi_headers"],
    linkshared=True,
    visibility = ["//visibility:public"],
)

exports_files([
    "sv_plugin.py",
    "pb_pkg.svh",
    "pb_decode.svh",
    "pb_encode.svh",
])
