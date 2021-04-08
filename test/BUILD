load("@com_google_protobuf//:protobuf.bzl", "py_proto_library")

load(":test.bzl", "golden_test_glob")
load("@rules_verilog//verilog:defs.bzl", "verilog_dv_library", "verilog_dv_unit_test")
load("//:sv_proto.bzl", "sv_proto_library")

golden_test_glob(glob(["proto/*.proto"]))

verilog_dv_library(
    name = "pb_pkg_test_lib",
    srcs = ["pb_pkg_test.sv"],
    deps = ["//:pb"],
    in_flist = ["pb_pkg_test.sv"],
)

verilog_dv_unit_test(
    name = "pb_pkg_test",
    deps = [":pb_pkg_test_lib"],
)

verilog_dv_library(
    name = "native_loopback_test_lib",
    srcs = ["native_loopback_test.sv"],
    in_flist = ["native_loopback_test.sv"],
    deps = [":native"],
)    

verilog_dv_unit_test(
    name = "native_loopback_test",
    deps = [":native_loopback_test_lib"],
)

py_proto_library(
    name = "native_py_proto",
    srcs = ["proto/native.proto"],
)

py_binary(
    name = "cross_language",
    srcs = ["cross_language.py"],
    deps = ["native_py_proto"],
)

verilog_dv_library(
    name = "native_cross_language_test_lib",
    srcs = ["native_cross_language_test.sv"],
    in_flist = ["native_cross_language_test.sv"],
    deps = [":native"],
)

# Requires the following command in another shell before execution:
# bazel run //test:cross_language -- `pwd`/cross_language_socket
# Then run
# bazel run //test:native_cross_language_test -- +socket_name=`pwd`/cross_language_socket
verilog_dv_unit_test(
    name = "native_cross_language_test",
    deps = [":native_cross_language_test_lib"],
)
