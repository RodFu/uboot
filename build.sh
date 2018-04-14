#!/bin/sh

ROOT_DIR=$(pwd)
SEC_PATH="$ROOT_DIR/CodeSign4SecureBoot"
BOARD_NAME=iTop4412

rm -rf u-boot.bin

make ${BOARD_NAME}_defconfig
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
# eMMC layout:
# +------------+------------------------------------------------------------+
# | |
# | | | | | |
# | 8K(bl1) | 16k(bl2) | 512k(u-boot) | 16k(ENV) |
# | | | | | |
# | |
# +------------+------------------------------------------------------------+
#
cat $SEC_PATH/E4412_N.bl1.SCP2G.bin spl/${BOARD_NAME}-spl.bin u-boot.bin > u-boot-${BOARD_NAME}.bin

echo "build complete successfully......"


