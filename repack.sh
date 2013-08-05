#!/bin/bash
#now=$(date +"%Y%m%d_%H%M")
now=$(cat /home/poonchitim/kernel_build_environment/kernel/.version)
cd /home/poonchitim/kernel_build_environment/build
cp -f zImage* ../packing
cd ../packing
rm lgstock_boot.img
rm cm_boot.img
mkbootimg --kernel zImage_lgstock --ramdisk lgstock.cpio.gz -o lgstock_boot.img
mkbootimg --kernel zImage_cm --ramdisk cm.cpio.gz -o cm_boot.img
#LG Stock
rm -rf /home/poonchitim/kernel_build_environment/release/system/lib
rm /home/poonchitim/kernel_build_environment/release/*.img
cp /home/poonchitim/kernel_build_environment/packing/lgstock_boot.img /home/poonchitim/kernel_build_environment/release
cp -R /home/poonchitim/kernel_build_environment/build/lgstock/system/lib /home/poonchitim/kernel_build_environment/release/system/lib
cd /home/poonchitim/kernel_build_environment/release/
zip -r eoa_kernel_$(echo $now)_lgstock.zip *
mv *.zip /home/poonchitim/kernel_build_environment/update/
#CM
rm -rf /home/poonchitim/kernel_build_environment/release/system/lib
rm /home/poonchitim/kernel_build_environment/release/*.img
cp /home/poonchitim/kernel_build_environment/packing/cm_boot.img /home/poonchitim/kernel_build_environment/release
cp -R /home/poonchitim/kernel_build_environment/build/cm/system/lib /home/poonchitim/kernel_build_environment/release/system/lib
cd /home/poonchitim/kernel_build_environment/release/
zip -r eoa_kernel_$(echo $now)_cm.zip *
mv *.zip /home/poonchitim/kernel_build_environment/update/
