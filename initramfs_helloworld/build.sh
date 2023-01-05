#create initramfs
echo "building initramfs"
cd initramfs
rm -rf initramfs.cpio.gz
./mk-initramfs.sh
cd ..

#compile kernel
echo "compile kernel"
cp kernel_config linux/.config
cd linux
time make -j8
cd ../

#create image
cd image
rm -rf linux-boot.img
dd if=/dev/zero of=linux-boot.img bs=1k count=1440
mkdosfs linux-boot.img
syslinux --install linux-boot.img
sudo mount -o loop linux-boot.img /mnt
sudo cp ../linux/arch/x86/boot/bzImage /mnt
sudo cp syslinux.cfg /mnt
cd ..
#cp rootfs.cpio.gz /mnt

#unmount
sudo umount /mnt

#start emulation
#qemu-system-x86_64 -drive format=raw,file=image/linux-boot.img
#
#qemu-system-x86_64 -kernel linux/arch/x86/boot/bzImage
