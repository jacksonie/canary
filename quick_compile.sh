#!/bin/sh

if [ -f "canary" ]; then
  rm -rf canary
fi

if [ -d "build" ]; then
  cd build
else
  mkdir build && cd build
fi

if [ -d "linux-release" ]; then
  cmake --build linux-release
else
  cmake -DCMAKE_TOOLCHAIN_FILE=~/vcpkg/scripts/buildsystems/vcpkg.cmake .. --preset linux-release
  cmake --build linux-release
fi

if [ $? -eq 1 ];
then
  echo "Compilation failed!"
else
  echo "Compilation successful!"
  cd linux-release/bin && cp canary ../../../ && cd ../../../
fi