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
    ],
    visibility = ["//visibility:public"],
)
    

exports_files([
    "sv_plugin.py",
    "pb_pkg.svh",
    "pb_decode.svh",
    "pb_encode.svh",
])
