#!/bin/bash

STABLE_ONOS=01-stable-onos
MASTER_ONOS=02-master-onos
STABLE_ONOS_APPS=$STABLE_ONOS/apps
MASTER_ONOS_APPS=$MASTER_ONOS/apps
LOCAL_APPS=apps
BAZEL_OUT=bazel-out
SONA_OUT=sona-out
BAZEL=bazel
BASH_PROFILE=tools/dev/bash_profile
PLATFORM=k8

source $BASH_PROFILE

rm -rf $LOCAL_APPS
mkdir -p $LOCAL_APPS

# remove bazel cache
rm -rf /root/.cache/bazel

# copy onos.def from stable source
if [ -f $STABLE_ONOS/onos.defs ]; then
  cp $STABLE_ONOS/onos.defs ./
fi

# copy modules.bzl to stable source (only valid for 2.0.X)
#if [ -f $STABLE_ONOS/tools/build/bazel/modules.bzl ]; then
#  rm -rf $STABLE_ONOS/tools/build/bazel/modules.bzl
#  cp modules.bzl $STABLE_ONOS/tools/build/bazel/
#fi

# copy sona apps into the separated directory
cp -R $MASTER_ONOS_APPS/openstacknetworking $LOCAL_APPS
cp -R $MASTER_ONOS_APPS/openstacknode $LOCAL_APPS
cp -R $MASTER_ONOS_APPS/openstacknetworkingui $LOCAL_APPS
cp -R $MASTER_ONOS_APPS/openstacktelemetry $LOCAL_APPS
cp -R $MASTER_ONOS_APPS/openstackvtap $LOCAL_APPS
cp -R $MASTER_ONOS_APPS/openstacktroubleshoot $LOCAL_APPS
cp -R $MASTER_ONOS_APPS/k8s-networking $LOCAL_APPS
cp -R $MASTER_ONOS_APPS/k8s-node $LOCAL_APPS
cp -R $STABLE_ONOS_APPS/optical-model $LOCAL_APPS
cp -R $STABLE_ONOS_APPS/cpman $LOCAL_APPS
cp -R $STABLE_ONOS_APPS/roadm $LOCAL_APPS
cp -R $STABLE_ONOS_APPS/faultmanagement $LOCAL_APPS

# copy tunnel app if it exists
if [ -f $MASTER_ONOS_APPS/tunnel/api/BUILD ]; then
  cp -R $MASTER_ONOS_APPS/tunnel $LOCAL_APPS
fi

# start to build sona and corresponding artifacts
$BAZEL build onos --define profile=sona

# copy SONA artifacts into the sona-out directory
rm -rf $SONA_OUT
mkdir -p $SONA_OUT
cp $BAZEL_OUT/$PLATFORM-fastbuild/bin/apps/openstacknetworking/onos-apps-openstacknetworking-oar.oar $SONA_OUT/openstacknetworking.oar
cp $BAZEL_OUT/$PLATFORM-fastbuild/bin/apps/openstacknode/onos-apps-openstacknode-oar.oar $SONA_OUT/openstacknode.oar
cp $BAZEL_OUT/$PLATFORM-fastbuild/bin/apps/openstacknetworkingui/onos-apps-openstacknetworkingui-oar.oar $SONA_OUT/openstacknetworkingui.oar
cp $BAZEL_OUT/$PLATFORM-fastbuild/bin/apps/openstacktelemetry/onos-apps-openstacktelemetry-oar.oar $SONA_OUT/openstacktelemetry.oar
cp $BAZEL_OUT/$PLATFORM-fastbuild/bin/apps/openstackvtap/onos-apps-openstackvtap-oar.oar $SONA_OUT/openstackvtap.oar
cp $BAZEL_OUT/$PLATFORM-fastbuild/bin/apps/openstacktroubleshoot/onos-apps-openstacktroubleshoot-oar.oar $SONA_OUT/openstacktroubleshoot.oar
