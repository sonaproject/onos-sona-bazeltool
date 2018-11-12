#!/bin/bash
BAZEL=bazel

# run unit test for SONA apps
$BAZEL query 'tests(//apps/openstacknode/...)' | xargs $BAZEL test
$BAZEL query 'tests(//apps/openstacknetworking/...)' | xargs $BAZEL test
$BAZEL query 'tests(//apps/openstacknetworkingui/...)' | xargs $BAZEL test
$BAZEL query 'tests(//apps/openstacktelemetry/...)' | xargs $BAZEL test
$BAZEL query 'tests(//apps/openstackvtap/...)' | xargs $BAZEL test
$BAZEL query 'tests(//apps/openstacktroubleshoot/...)' | xargs $BAZEL test
