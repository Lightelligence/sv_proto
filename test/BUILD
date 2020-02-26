load(":test.bzl", "golden_test_glob")

golden_test_glob(glob(["proto/*.proto"]))


sh_test(
    name = "pb_pkg_test",
    size = "small",
    srcs = ["passthrough.sh"],
    data = [
        "//:pb_pkg.svh",
        "pb_pkg_test.sv",
    ],
    args = ["xrun -licqueue -uvm $(location //:pb_pkg.svh) $(location pb_pkg_test.sv)"],
    tags = ["xrun"],
)


sh_test(
    name = "native_encode_test",
    size = "small",
    srcs = ["passthrough.sh"],
    data = [
        "//:pb_pkg.svh",
        ":native",
        "native_encode_test.sv",
    ],
    args = ["xrun -licqueue -uvm $(location //:pb_pkg.svh) $(location :native) $(location :native_encode_test.sv)"],
    tags = ["xrun"],
)
