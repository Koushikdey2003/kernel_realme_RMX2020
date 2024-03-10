#!/bin/bash

function compile() 
{
rm -rf AnyKernel
source ~/.bashrc && source ~/.profile
export LC_ALL=C && export USE_CCACHE=1
export ARCH=arm64
export KBUILD_BUILD_HOST=neolit
export KBUILD_BUILD_USER="sarthakroy2002"
wget https://github.com/ZyCromerZ/Clang/releases/download/18.0.0git-20240124-release/Clang-18.0.0git-20240124.tar.gz -O "ZyC-clang.tar.gz"
mkdir clang && tar -xf ZyC-clang.tar.gz -C clang && rm -rf ZyC-clang.tar.gz

[ -d "out" ] && rm -rf out || mkdir -p out

make O=out ARCH=arm64 RMX2020_defconfig

PATH="${PWD}/clang/bin:${PATH}" \
make -j$(nproc --all) O=out \
                      CC="clang" \
                      LLVM=1 \
                      CONFIG_NO_ERROR_ON_MISMATCH=y
}

function zipping()
{
git clone --depth=1 https://github.com/sarthakroy2002/AnyKernel3.git AnyKernel
cp out/arch/arm64/boot/Image.gz-dtb AnyKernel
cd AnyKernel
zip -r9 Test-OSS-KERNEL-RMX2020-NEOLIT.zip *
}

compile
zipping
