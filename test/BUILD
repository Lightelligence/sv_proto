load("@com_google_protobuf//:protobuf.bzl", "py_proto_library")

load(":test.bzl", "golden_test_glob")

golden_test_glob(glob(["proto/*.proto"]))

sh_test(
    name = "pb_pkg_test",
    size = "small",
    srcs = ["passthrough.sh"],
    data = [
        "//:pb_pkg.svh",
        "//:pb_decode.svh",
        "//:pb_encode.svh",
        "pb_pkg_test.sv",
    ],
    args = ["xrun -licqueue -uvm $(locations //:pb_pkg.svh) $(location pb_pkg_test.sv)"],
    tags = ["xrun"],
)


py_proto_library(
    name = "native_py_proto",
    srcs = ["proto/native.proto"],
)

sh_test(
    name = "native_loopback_test",
    size = "small",
    srcs = ["passthrough.sh"],
    data = [
        "//:pb_pkg.svh",
        "//:pb",
        ":native",
        "native_loopback_test.sv",
    ],
    args = ["xrun -licqueue -access rwc -linedebug -createdebugdb -uvm $(locations //:pb_pkg.svh) $(location :native) $(location native_loopback_test.sv)"],
    tags = ["xrun"],
)

py_binary(
    name = "cross_language",
    srcs = ["cross_language.py"],
    deps = ["native_py_proto"],
)

sh_test(
    name = "native_cross_language_test",
    size = "small",
    srcs = ["passthrough.sh"],
    data = [
        "//:pb_pkg.svh",
        "//:pb",
        "//:pb_socket.so",
        ":native",
        "native_cross_language_test.sv",
    ],
    args = ["xrun -64 -licqueue -access rwc -linedebug -createdebugdb -uvm -sv_lib $(location //:pb_socket.so) $(locations //:pb_pkg.svh) $(location :native) $(location native_cross_language_test.sv)"],
    tags = ["xrun"],
)
