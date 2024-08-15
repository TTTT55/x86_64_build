#!/usr/bin/env bash

set -e
cd ~/roms/$rom_name
export CCACHE_DIR=~/ccache/$rom_name/$device
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 8G
ccache -z
if [[ " AOSP-aosp-13.0 " == *"$rom_name"* ]]; then sudo mkdir -p /usr/share/man/man1; sudo apt update; sudo apt install openjdk-8-jdk --no-install-recommends -y; sudo ln -sf /usr/bin/python2 /usr/bin/python; fi
sudo apt-get install git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc unzip
command=$(tail $CIRRUS_WORKING_DIR/build_rom.sh -n +$(expr $(grep 'build/envsetup.sh' $CIRRUS_WORKING_DIR/build_rom.sh -n | cut -f1 -d:) - 1)| head -n -1 | grep -v 'rclone copy')
bash -c "$command"

succeed_date=$(date +%s)
curl -X PATCH "$two?cirrus_build_id=eq.https://cirrus-ci.com/build/$CIRRUS_BUILD_ID" -H "Content-Type: application/json" -H "Prefer: return=minimal" -d "{ \"succeed_date\": \"$succeed_date\" }"
