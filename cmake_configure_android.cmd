@echo off

cmake -G"Ninja" ^
    -DCMAKE_MAKE_PROGRAM="C:\app\android-sdk\cmake\3.6.4111459\bin\ninja.exe" ^
    -DCMAKE_TOOLCHAIN_FILE="C:\app\android-sdk\ndk-bundle\build\cmake\android.toolchain.cmake" ^
    -DANDROID_ARM_NEON=TRUE ^
    -DANDROID_TOOLCHAIN=clang ^
    -DANDROID_DISABLE_FORMAT_STRING_CHECKS=TRUE ^
    ../
