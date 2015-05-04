#!/bin/bash
#
# Clean Script: Javilonas, 24-04-2015
# Javilonas <admin@lonasdigital.com>
#

TOOLCHAIN="/home/lonas/Kernel_Lonas/toolchains/arm-cortex_a15-linux-gnueabihf-linaro_4.8.4-2014.11/bin/arm-eabi-"
DIR="/home/lonas/Kernel_Lonas/Stock_Plus"
export KERNELDIR=`readlink -f .`

echo "#################### Eliminando Restos ####################"
if [ -e boot.img ]; then
	rm boot.img
fi

if [ -e dt.img ]; then
	rm dt.img
fi

if [ -e boot.dt.img ]; then
	rm boot.dt.img
fi

if [ -e compile.log ]; then
	rm compile.log
fi

if [ -e ramdisk.cpio ]; then
	rm ramdisk.cpio
fi

if [ -e ramdisk.cpio.gz ]; then
        rm ramdisk.cpio.gz
fi

echo "#################### Eliminando build anterior ####################"

find -name '*.ko' -exec rm -rf {} \;
rm -rf $KERNELDIR/arch/arm/boot/zImage > /dev/null 2>&1
rm -rf $KERNELDIR/arch/arm/boot/zImage-dtb > /dev/null 2>&1
rm -rf $KERNELDIR/arch/arm/boot/Image > /dev/null 2>&1
rm -rf $KERNELDIR/arch/arm/boot/dt.img > /dev/null 2>&1
rm -rf $KERNELDIR/arch/arm/boot/*.img > /dev/null 2>&1
rm -rf $KERNELDIR/arch/arm/boot/dts/*.dtb > /dev/null 2>&1
rm -rf $KERNELDIR/arch/arm/boot/dts/*.reverse.dts > /dev/null 2>&1

rm -rf $KERNELDIR/output/arch/arm/boot/zImage > /dev/null 2>&1
rm -rf $KERNELDIR/output/arch/arm/boot/zImage-dtb > /dev/null 2>&1
rm -rf $KERNELDIR/output/arch/arm/boot/Image > /dev/null 2>&1
rm -rf $KERNELDIR/output/arch/arm/boot/dt.img > /dev/null 2>&1
rm -rf $KERNELDIR/output/arch/arm/boot/*.img > /dev/null 2>&1
rm -rf $KERNELDIR/output/arch/arm/boot/dts/*.dtb > /dev/null 2>&1
rm -rf $KERNELDIR/output/arch/arm/boot/dts/*.reverse.dts > /dev/null 2>&1

rm $KERNELDIR/zImage > /dev/null 2>&1
rm $KERNELDIR/zImage-dtb > /dev/null 2>&1
rm $KERNELDIR/boot.dt.img > /dev/null 2>&1
rm $KERNELDIR/boot.img > /dev/null 2>&1
rm $KERNELDIR/*.ko > /dev/null 2>&1
rm $KERNELDIR/*.img > /dev/null 2>&1

#make distclean
make clean && make mrproper
rm Module.symvers > /dev/null 2>&1

# clean ccache
read -t 6 -p "Eliminar ccache, (y/n)?"
if [ "$REPLY" == "y" ]; then
	ccache -C
fi

echo "ramfs_tmp = $RAMFS_TMP"

echo "#################### Eliminando build anterior ####################"

echo "Cleaning latest build"
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN -j`grep 'processor' /proc/cpuinfo | wc -l` mrproper
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN -j`grep 'processor' /proc/cpuinfo | wc -l` clean

find -name '*.ko' -exec rm -rf {} \;
rm -f $DIR/releasetools/tar/*.tar > /dev/null 2>&1
rm -f $DIR/releasetools/zip/*.zip > /dev/null 2>&1
rm -rf $DIR/arch/arm/boot/zImage > /dev/null 2>&1
rm -rf $DIR/arch/arm/boot/zImage-dtb > /dev/null 2>&1
rm -f $DIR/arch/arm/boot/*.dtb > /dev/null 2>&1
rm -f $DIR/arch/arm/boot/*.cmd > /dev/null 2>&1
rm -rf $DIR/arch/arm/boot/Image > /dev/null 2>&1

rm -rf $DIR/output/arch/arm/boot/zImage > /dev/null 2>&1
rm -rf $DIR/output/arch/arm/boot/zImage-dtb > /dev/null 2>&1
rm -f $DIR/output/arch/arm/boot/*.dtb > /dev/null 2>&1
rm -f $DIR/output/arch/arm/boot/*.cmd > /dev/null 2>&1
rm -rf $DIR/output/arch/arm/boot/Image > /dev/null 2>&1

rm $DIR/boot.img > /dev/null 2>&1
rm $DIR/zImage > /dev/null 2>&1
rm $DIR/zImage-dtb > /dev/null 2>&1
rm $DIR/boot.dt.img > /dev/null 2>&1
rm $DIR/dt.img > /dev/null 2>&1
rm -rf $KERNELDIR/output/* > /dev/null 2>&1
rm -rf $KERNELDIR/output/.* > /dev/null 2>&1
rm -rf $KERNELDIR/output > /dev/null 2>&1

rm -f $KERNELDIR/releasetools/tar/*.tar > /dev/null 2>&1
rm -f $KERNELDIR/releasetools/zip/*.zip > /dev/null 2>&1
