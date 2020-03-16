#!/bin/bash

STABLE_ONOS=01-stable-onos

if [ "$#" -lt 1 ]; then
    echo "$# is Illegal number of parameters."
    echo "Usage: $0 [options]"
    exit 0
fi

sed -i 's,https://repo1.maven.org/maven2,'$1',g' $STABLE_ONOS/tools/build/bazel/generate_workspace.bzl
