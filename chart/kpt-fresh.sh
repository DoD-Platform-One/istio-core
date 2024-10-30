#!/bin/bash

# this script pulls down a `fresh` copy of upstream that can be used as a basis for comparison

# kpt get VERSION of the upstream charts to a specified DIR
VERSION=1.23.0
DIR=./charts-fresh

echo -e "\n⏳ kpt getting v$VERSION of base, istiod, and gateway to: $DIR\n"

rm -rf $DIR
mkdir -p $DIR

kpt pkg get "https://github.com/istio/istio.git/manifests/charts/base@$VERSION" "$DIR/base"
kpt pkg get "https://github.com/istio/istio.git/manifests/charts/istio-control/istio-discovery@$VERSION" "$DIR/istiod"
kpt pkg get "https://github.com/istio/istio.git/manifests/charts/gateway@$VERSION" "$DIR/gateway"

echo -e "\n✅ kpt get complete\n"
