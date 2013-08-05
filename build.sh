#!/bin/bash
KBE_PATH=/home/poonchitim
KERNEL_DIR=lge-kernel-p880
KERNEL_PATH=${KBE_PATH}/${KERNEL_DIR}
TOOLCHAIN=arm-linux-eabi-
BUILD_DIR=build
BUILD_LOG="../build.log"
NUM_THREADS=6
cd $KBE_PATH
cd $KERNEL_PATH
rm $BUILD_LOG
#LG Stock
echo "Initializing LG Stock build..."
make clean >> $BUILD_LOG 2>&1
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN clean >> $BUILD_LOG 2>&1
cat arch/arm/configs/pzt_x3_defconfig > .config
echo "Building kernel..."
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN -j$NUM_THREADS >> $BUILD_LOG 2>&1
#echo "Building module..."
#make ARCH=arm CROSS_COMPILE=$TOOLCHAIN -C drivers/net/wireless/compat-wireless_R5.SP2.03 KLIB=`pwd` KLIB_BUILD=`pwd` clean >> $BUILD_LOG 2>&1
#make ARCH=arm CROSS_COMPILE=$TOOLCHAIN -C drivers/net/wireless/compat-wireless_R5.SP2.03 KLIB=`pwd` KLIB_BUILD=`pwd` -j$NUM_THREADS >> $BUILD_LOG 2>&1
echo "Saving binaries..."
cd ..
rm -rf build/*
cp $KERNEL_DIR/arch/arm/boot/zImage $BUILD_DIR/zImage_lgstock
MOD_DIR=$BUILD_DIR/lgstock/system/lib/modules
mkdir -p $MOD_DIR
find $KERNEL_DIR/arch -type f -name '*.ko' -exec cp -f {} $MOD_DIR \;
find $KERNEL_DIR/crypto -type f -name '*.ko' -exec cp -f {} $MOD_DIR \;
find $KERNEL_DIR/fs -type f -name '*.ko' -exec cp -f {} $MOD_DIR \;
find $KERNEL_DIR/ipc -type f -name '*.ko' -exec cp -f {} $MOD_DIR \; 
find $KERNEL_DIR/net -type f -name '*.ko' -exec cp -f {} $MOD_DIR \;
find $KERNEL_DIR/drivers -type f -name '*.ko' -exec cp -f {} $MOD_DIR \;
#find $KERNEL_DIR/drivers/net/wireless/compat-wireless_R5.SP2.03 -type f -name '*.ko' -exec cp -f {} $MOD_DIR \;
echo "LG Stock build done."
#LG Stock end
#CM
cd $KERNEL_PATH
ver=$(cat .version)
ver=$(($ver-1))
echo $ver > .version
echo "Initializing CM build..."
make clean >> $BUILD_LOG 2>&1
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN clean >> $BUILD_LOG 2>&1
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN pzt_x3_defconfig >> $BUILD_LOG 2>&1
echo "Building kernel..."
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN -j$NUM_THREADS >> $BUILD_LOG 2>&1
#echo "Building module..."
#make ARCH=arm CROSS_COMPILE=$TOOLCHAIN -C drivers/net/wireless/compat-wireless_R5.SP2.03 KLIB=`pwd` KLIB_BUILD=`pwd` clean >> $BUILD_LOG 2>&1
#make ARCH=arm CROSS_COMPILE=$TOOLCHAIN -C drivers/net/wireless/compat-wireless_R5.SP2.03 KLIB=`pwd` KLIB_BUILD=`pwd` -j$NUM_THREADS >> $BUILD_LOG 2>&1
echo "Saving binaries..."
cd ..
cp $KERNEL_DIR/arch/arm/boot/zImage $BUILD_DIR/zImage_cm
MOD_DIR=$BUILD_DIR/cm/system/lib/modules
mkdir -p $MOD_DIR
find $KERNEL_DIR/arch -type f -name '*.ko' -exec cp -f {} $MOD_DIR \;
find $KERNEL_DIR/crypto -type f -name '*.ko' -exec cp -f {} $MOD_DIR \;
find $KERNEL_DIR/fs -type f -name '*.ko' -exec cp -f {} $MOD_DIR \;
find $KERNEL_DIR/ipc -type f -name '*.ko' -exec cp -f {} $MOD_DIR \; 
find $KERNEL_DIR/net -type f -name '*.ko' -exec cp -f {} $MOD_DIR \;
find $KERNEL_DIR/drivers -type f -name '*.ko' -exec cp -f {} $MOD_DIR \;
#find $KERNEL_DIR/drivers/net/wireless/compat-wireless_R5.SP2.03 -type f -name '*.ko' -exec cp -f {} $MOD_DIR \;
echo "CM build done."
#AOSP end
