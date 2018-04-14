#!/bin/sh

ROOT_DIR=$(pwd)
SEC_PATH="$ROOT_DIR/CodeSign4SecureBoot"

rm -rf u-boot.bin

make landrover_defconfig
make -j$CPU_JOB_NUM

if [ ! -f u-boot.bin ]
then
	echo "Failed to find u-boot.bin......"
    exit
fi

####################################################
#./mkbl2 spl/u-boot-spl.bin bl2-checksum.bin 14336
#cat bl2-checksum.bin pad00.bin > bl2.bin
####################################################

echo "fusing u-boot image......"

# SD MMC layout:
# +------------+------------------------------------------------------------+
# | |
# | | | | | |
# | 512B | 8K(bl1) | 16k(bl2) | 512k(u-boot) | 16k(ENV) |
# | | | | | |
# | |
# +------------+------------------------------------------------------------+
#
cat $SEC_PATH/E4412_N.bl1.SCP2G.bin spl/landrover-spl.bin u-boot.bin $SEC_PATH/env.bin > u-boot-iTop4412-sd.bin

# eMMC layout:
# +------------+------------------------------------------------------------+
# | |
# | | | | | |
# | 8K(bl1) | 16k(bl2) | 512k(u-boot) |
# | | | | | |
# | |
# +------------+------------------------------------------------------------+
#
cat $SEC_PATH/E4412_N.bl1.SCP2G.bin spl/landrover-spl.bin u-boot.bin > u-boot-iTop4412-emmc.bin

echo "build complete successfully......"


