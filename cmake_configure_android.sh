#!/bin/bash

cmake -G"Ninja" \
    -DCMAKE_MAKE_PROGRAM=$ANDROID_SDK/cmake/3.6.4111459/bin/ninja \
    -DCMAKE_TOOLCHAIN_FILE=$ANDROID_SDK/ndk-bundle/build/cmake/android.toolchain.cmake \
    -DANDROID_ARM_NEON=TRUE \
    -DANDROID_TOOLCHAIN=clang \
    -DANDROID_DISABLE_FORMAT_STRING_CHECKS=TRUE \
   $1 

