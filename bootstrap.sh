#!/bin/bash

################################################################################
# dependencies
################################################################################
echo ============================
echo "[INFO] Dependencies ..."
echo ============================
rm -rf libs && mkdir libs

echo "algo: Simple algorithms"
git clone https://github.com/ntessore/algo.git libs/algo

if [ "$1" == "argtable3" ]; then
  echo "Argtable3: A single-file, ANSI C, command-line parsing library that parses GNU-style command-line options"
  curl -L https://github.com/argtable/argtable3/releases/download/v3.2.1.52f24e5/argtable-v3.2.1.52f24e5.tar.gz --output libs/argtable-v3.2.1.52f24e5.tar.gz --silent 
  tar -xf libs/argtable-v3.2.1.52f24e5.tar.gz --directory libs/
  cd libs/argtable-v3.2.1.52f24e5
  mkdir build
  cd build
  cmake -DBUILD_SHARED_LIBS=ON ..
  cmake --build . --config Release
  cmake --install . --prefix /usr/local
  cd ../../..
  rm -rf libs/argtable-v3.2.1.52f24e5
  exit
fi

if [ "$1" == "jansson" ]; then
  echo "Jansson: C library for encoding, decoding and manipulating JSON data"
  curl -L https://github.com/akheron/jansson/releases/download/v2.14/jansson-2.14.tar.gz --output libs/jansson-2.14.tar.gz --silent
  tar -xf libs/jansson-2.14.tar.gz --directory libs/
  cd libs/jansson-2.14
  mkdir build
  cd build
  cmake -DJANSSON_BUILD_DOCS=OFF -DJANSSON_BUILD_SHARED_LIBS=ON ..
  cmake --build . --config Release
  cmake --install . --prefix /usr/local
  cd ../../..
  rm -rf libs/jansson-2.14
  exit
fi

if [ "$1" == "civetweb" ]; then
  echo ============================
  echo "[INFO] Dependecies: Civetweb: Embedded C/C++ web server"
  echo ============================
  curl -L https://github.com/civetweb/civetweb/archive/refs/tags/v1.15.tar.gz --output libs/civetweb-1.15.tar.gz --silent
  tar -xvf libs/civetweb-1.15.tar.gz --directory libs/
  cd libs/civetweb-1.15
  mkdir build_dir
  cd build_dir
  cmake -DCIVETWEB_ENABLE_SSL=OFF -DCIVETWEB_ENABLE_SERVER_EXECUTABLE=OFF -DCIVETWEB_ENABLE_DEBUG_TOOLS=OFF -DCIVETWEB_BUILD_TESTING=OFF -DBUILD_TESTING=OFF -DCIVETWEB_ENABLE_WEBSOCKETS=ON -DBUILD_SHARED_LIBS=ON ..
  cmake --build . --config Release
  cmake --install . --prefix /usr/local
  cd ../../..
  rm -rf libs/civetweb-1.15
  exit
fi

if [ "$1" == "serialport" ]; then
  echo "Libserialport: Minimal, cross-platform shared library written in C"
  curl -L https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/libserialport/0.1.1-4/libserialport_0.1.1.orig.tar.xz --output libs/libserialport-0.1.1-4.tar.xz --silent
  mkdir libs/libserialport-0.1.1-4/
  tar -xf libs/libserialport-0.1.1-4.tar.xz --directory libs/libserialport-0.1.1-4/
  cd libs/libserialport-0.1.1-4/
  ./autogen.sh
  ./configure --prefix=/usr/local
  make
  sudo make install
  cd ../../
  rm -rf libs/libserialport-0.1.1-4/
  exit
fi

rm -rf build && mkdir build && cd build
################################################################################
# build and install
################################################################################
echo ============================
echo "[INFO] Building ..."
echo ============================
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release ..
make

echo ============================
echo "[INFO] Installing ..." 
echo ============================
make install 

cd .. 