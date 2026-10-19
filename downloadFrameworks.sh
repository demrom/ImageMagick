#!/bin/bash
set -euo pipefail

curl --fail --location --retry 3 -O https://github.com/holzschu/ios_system/releases/download/v3.0.5/ios_error.h
echo '51d46b912eb30399cbb5c36c8c8f15eb1a44adcfc9ee581304ac9d3739a84716  ios_error.h' | shasum -a 256 -c -
mkdir -p Python-aux
pushd Python-aux
curl --fail --location --retry 3 -O https://github.com/holzschu/Python-aux/releases/download/1.0/libjpeg.xcframework.zip
curl --fail --location --retry 3 -O https://github.com/holzschu/Python-aux/releases/download/1.0/libtiff.xcframework.zip
curl --fail --location --retry 3 -O https://github.com/holzschu/Python-aux/releases/download/1.0/freetype.xcframework.zip
curl --fail --location --retry 3 -O https://github.com/holzschu/Python-aux/releases/download/1.0/harfbuzz.xcframework.zip
curl --fail --location --retry 3 -O https://github.com/holzschu/Python-aux/releases/download/1.0/libpng.xcframework.zip
curl --fail --location --retry 3 -O https://github.com/holzschu/ios_system/releases/download/v3.0.5/ios_system.xcframework.zip

shasum -a 256 -c - <<'CHECKSUMS'
0a12c912f464763601c5b91167ff50d6d6f60c9b23d56412c583be45bff0d76b  libjpeg.xcframework.zip
0678de08083fd13256d4375f8c06e802e12dcabd5f41b80f64b84c065f86d2ad  libtiff.xcframework.zip
8fdf22c7911a2ea47c60df723a0ee268bd5606a1153023f338b3e6395149089e  freetype.xcframework.zip
9a983795826d1662ba354f563b19a7b980e4c744138b3afb68491991e2c8a66a  harfbuzz.xcframework.zip
30ff80e9a2c20d7f266e7f788e94e44b2e105ac9c8107b44eb91f6869d6d8aa4  libpng.xcframework.zip
d429e68102926f58bedd8e8b7105dcd169478cd6da1cef494a5f468482d1c8f5  ios_system.xcframework.zip
CHECKSUMS

rm -rf ios_system.xcframework libjpeg.xcframework libtiff.xcframework freetype.xcframework harfbuzz.xcframework libpng.xcframework
unzip -q libjpeg.xcframework.zip
unzip -q libtiff.xcframework.zip
unzip -q freetype.xcframework.zip
unzip -q harfbuzz.xcframework.zip
unzip -q libpng.xcframework.zip
unzip -q ios_system.xcframework.zip

popd

PREFIX=$PWD
XCFRAMEWORKS_DIR=$PREFIX/Python-aux/
mkdir -p Frameworks_iphoneos
mkdir -p Frameworks_iphoneos/include
mkdir -p Frameworks_iphoneos/lib
rm -rf Frameworks_iphoneos/{ios_system,freetype,harfbuzz,libpng}.framework
cp -r $XCFRAMEWORKS_DIR/ios_system.xcframework/ios-arm64/ios_system.framework $PREFIX/Frameworks_iphoneos
cp -r $XCFRAMEWORKS_DIR/freetype.xcframework/ios-arm64/freetype.framework $PREFIX/Frameworks_iphoneos
cp -r $XCFRAMEWORKS_DIR/harfbuzz.xcframework/ios-arm64/harfbuzz.framework $PREFIX/Frameworks_iphoneos
cp -r $XCFRAMEWORKS_DIR/libpng.xcframework/ios-arm64/libpng.framework $PREFIX/Frameworks_iphoneos
cp -r $XCFRAMEWORKS_DIR/libjpeg.xcframework/ios-arm64/Headers/* $PREFIX/Frameworks_iphoneos/include/
cp -r $XCFRAMEWORKS_DIR/libtiff.xcframework/ios-arm64/Headers/* $PREFIX/Frameworks_iphoneos/include/
cp -r $XCFRAMEWORKS_DIR/freetype.xcframework/ios-arm64/freetype.framework/Headers/* $PREFIX/Frameworks_iphoneos/include/
# Need to copy all libs after each make clean: 
cp $XCFRAMEWORKS_DIR/libjpeg.xcframework/ios-arm64/libjpeg.a $PREFIX/Frameworks_iphoneos/lib/
cp $XCFRAMEWORKS_DIR/libtiff.xcframework/ios-arm64/libtiff.a $PREFIX/Frameworks_iphoneos/lib/

mkdir -p Frameworks_iphonesimulator
mkdir -p Frameworks_iphonesimulator/include
mkdir -p Frameworks_iphonesimulator/lib
rm -rf Frameworks_iphonesimulator/{ios_system,freetype,harfbuzz,libpng}.framework
cp -r $XCFRAMEWORKS_DIR/ios_system.xcframework/ios-arm64_x86_64-simulator/ios_system.framework $PREFIX/Frameworks_iphonesimulator
cp -r $XCFRAMEWORKS_DIR/freetype.xcframework/ios-x86_64-simulator/freetype.framework $PREFIX/Frameworks_iphonesimulator
cp -r $XCFRAMEWORKS_DIR/harfbuzz.xcframework/ios-x86_64-simulator/harfbuzz.framework $PREFIX/Frameworks_iphonesimulator
cp -r $XCFRAMEWORKS_DIR/libpng.xcframework/ios-x86_64-simulator/libpng.framework $PREFIX/Frameworks_iphonesimulator
cp -r $XCFRAMEWORKS_DIR/libjpeg.xcframework/ios-x86_64-simulator/Headers/* $PREFIX/Frameworks_iphonesimulator/include/
cp -r $XCFRAMEWORKS_DIR/libtiff.xcframework/ios-x86_64-simulator/Headers/* $PREFIX/Frameworks_iphonesimulator/include/
cp -r $XCFRAMEWORKS_DIR/freetype.xcframework/ios-x86_64-simulator/freetype.framework/Headers/* $PREFIX/Frameworks_iphonesimulator/include/
# Need to copy all libs after each make clean: 
cp $XCFRAMEWORKS_DIR/libjpeg.xcframework/ios-x86_64-simulator/libjpeg.a $PREFIX/Frameworks_iphonesimulator/lib/
cp $XCFRAMEWORKS_DIR/libtiff.xcframework/ios-x86_64-simulator/libtiff.a $PREFIX/Frameworks_iphonesimulator/lib/

