#!/bin/bash

shopt -s extglob

sed -i "/telephony/d" feeds.conf.default
sed -i -E "s#git\.openwrt\.org/(openwrt|feed|project)#github.com/openwrt#" feeds.conf.default

./scripts/feeds update -a
./scripts/feeds install -a

sed -i 's/--set=llvm\.download-ci-llvm=true/--set=llvm.download-ci-llvm=false/' feeds/packages/lang/rust/Makefile

cp -f devices/common/.config .config

sed -i '/WARNING: Makefile/d' scripts/package-metadata.pl

sed -i "s#false; \\\#true; \\\#" include/download.mk

cp -f devices/common/po2lmo staging_dir/host/bin/po2lmo
chmod +x staging_dir/host/bin/po2lmo
