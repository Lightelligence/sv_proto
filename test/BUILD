load("@com_google_protobuf//:protobuf.bzl", "py_proto_library")

load(":test.bzl", "golden_test_glob")

golden_test_glob(glob(["proto/*.proto"]))

sh_test(
    name = "pb_pkg_test",
    size = "small",
    srcs = ["passthrough.sh"],
    data = [
        "//:pb_pkg.svh",
        "//:pb",
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
        "//:pb_decode.svh",
        "//:pb_encode.svh",
        ":native",
        "native_loopback_test.sv",
    ],
    args = ["xrun -licqueue -uvm $(locations //:pb_pkg.svh) $(location :native) $(location native_loopback_test.sv)"],
    tags = ["xrun"],
)
