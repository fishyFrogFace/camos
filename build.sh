#!/bin/bash

#if test "`whoami`" != "root" ; then
#    echo "You need root to build!"
#    exit
#fi

rm -rf try && rm camos.flp

nasm -O0 -w+orphan-labels -f bin -o bootloader.bin bootloader.asm

nasm -O0 -w+orphan-labels -f bin -o kernel.bin kernel.asm

mkdosfs -C camos.flp 1440

dd status=noxfer conv=notrunc if=bootloader.bin of=camos.flp

mkdir tmp && sudo mount -o loop -t vfat camos.flp tmp && sudo cp kernel.bin tmp/

sudo umount tmp/

rm -rf tmp/
