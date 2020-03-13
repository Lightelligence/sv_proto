load("@verilog_tools//:dv.bzl", "dv_lib")

def sv_proto_library(name, srcs):
    """Generate a SystemVerilog file from a .proto file.
    
    Ideally this would be using the proto_gen rule from com_google_protobuf,
    but there seems to be a bug in that rule when using a plugin. Haven't
    actually filed the issue yet.
    """
    plugin = "//:sv_plugin.py"
    native.genrule(
        name = name + "_sv",
        srcs = srcs,
        outs = [f + ".sv" for f in srcs],
        cmd = "$(location @com_google_protobuf//:protoc) --plugin=protoc-gen-sv=$(location {plugin}) --sv_out=$(@D) $(SRCS)".format(plugin=plugin),
        output_to_bindir = True,
        tools = [
            plugin,
            "@com_google_protobuf//:protoc",
        ],
    )
    # load("@com_google_protobuf//:protobuf.bzl", "proto_gen")
    # proto_gen(
    #     name = name,
    #     srcs = srcs,
    #     plugin = plugin,
    #     protoc = "@com_google_protobuf//:protoc",
    #     plugin_language = "sv",
    #     outs = [f + ".sv" for f in srcs],
    #     gen_cc = False,
    #     gen_py = False,
    # )

    dv_lib(
        name = name,
        srcs = [":{}_sv".format(name)],
        deps = ["//:pb"],
        in_flist = [":{}_sv".format(name)],
    )
