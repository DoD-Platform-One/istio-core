#!/bin/bash

# this script merges upstream versions of charts into local

# kpt update to VERSION of the upstream charts using a specified DIR
VERSION=1.23.2
DIR=./charts

echo -e "\n⏳ kpt updating to v$VERSION for base, istiod, and gateway using: $DIR\n"

cd $DIR
kpt pkg update base@$VERSION --strategy alpha-git-patch
kpt pkg update istiod@$VERSION --strategy alpha-git-patch
kpt pkg update gateway@$VERSION --strategy alpha-git-patch

echo -e "\n✅ kpt update complete\n"
