cd initramfs
./mk-initramfs.sh
cd ../

echo "compile kernel"
cd linux
make allnoconfig ARCH=x86_64 KCONFIG_ALLCONFIG=../network.config
time make -j8
cd ../

rm -rf output
mkdir -p output
cp linux/arch/x86/boot/bzImage output/
cp initramfs/rootfs.cpio.gz output/
