# -*- mode: python -*-
workspace(name = "sv_proto")

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "com_google_protobuf",
    commit = "fe1790ca0df67173702f70d5646b82f48f412b99",
    remote = "https://github.com/protocolbuffers/protobuf",
    # shallow_since = "1558721209 -0700",
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

http_archive(
    name = "rules_verilog",
    urls = ["https://github.com/Lightelligence/rules_verilog/archive/v0.0.0.tar.gz"],
    sha256 = "ab64a872410d22accb383c7ffc6d42e90f4de40a7cd92f43f4c26471c4f14908",
    strip_prefix = "rules_verilog-0.0.0",
)

load("@rules_verilog//:simulator.bzl", "xcelium_setup")
xcelium_setup(name="xcelium")
