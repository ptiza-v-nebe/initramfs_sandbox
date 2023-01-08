#compile kernel
echo "compile kernel"
cp kernel_config linux/.config
cd linux
time make -j8
cd ../

#create image
cd image
rm -rf linux-boot.img
dd if=/dev/zero of=linux-boot.img bs=1k count=1540
mkdosfs linux-boot.img
syslinux --install linux-boot.img
sudo mount -o loop linux-boot.img /mnt
sudo cp ../linux/arch/x86/boot/bzImage /mnt
sudo cp syslinux.cfg /mnt
cd ..
#cp rootfs.cpio.gz /mnt

#unmount
sudo umount /mnt
