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

py_binary(
    name = "gen_native_encode_test",
    srcs = ["gen_native_encode_test.py"],
    deps = [":native_py_proto"],
)

genrule(
    name = "native_encode_test_sv",
    srcs = [],
    outs = ["native_encode_test.sv"],
    cmd = "$(location :gen_native_encode_test) > $(@)",
    tools = [":gen_native_encode_test"],
)

sh_test(
    name = "native_encode_test",
    size = "small",
    srcs = ["passthrough.sh"],
    data = [
        "//:pb_pkg.svh",
        "//:pb_decode.svh",
        "//:pb_encode.svh",
        ":native",
        ":native_encode_test_sv",
    ],
    args = ["xrun -licqueue -uvm $(locations //:pb_pkg.svh) $(location :native) $(location :native_encode_test_sv)"],
    tags = ["xrun"],
)
