#!/usr/bin/bash
bazel build //test/...
cp ../bazel-bin/test/*proto*.sv golden/
chmod +w golden/*.sv
