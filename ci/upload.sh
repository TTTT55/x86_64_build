#!/usr/bin/env bash
set -e
cd ~/roms/$rom_name
jars=$(ls aosp/out/target/common/obj/JAVA_LIBRARIES/framework_intermediates/)
jarzip=$(ls out/target/product/$device/*-ota-*.zip | grep -v "hentai" | grep -v "evolution" || true)
rm -rf $jars $jarzip
## Pending
