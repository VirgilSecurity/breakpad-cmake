cd build
cmake -G"Ninja" ^
  -DCMAKE_MAKE_PROGRAM="C:\app\android-sdk\cmake\3.6.4111459\bin\ninja.exe" ^
  -DANDROID_NDK=C:\app\android-sdk\ndk-bundle ^
  -DCMAKE_TOOLCHAIN_FILE="C:\app\android-sdk\ndk-bundle\build\cmake\android.toolchain.cmake" ^
  -DANDROID_TOOLCHAIN=clang ^
  -DANDROID_PLATFORM=android-21 ^
  -DANDROID_ABI=armeabi-v7a ^
  -DANDROID_STL=gnustl_static ^
  -DANDROID_DISABLE_FORMAT_STRING_CHECKS=TRUE ^
  ../

cd ..
