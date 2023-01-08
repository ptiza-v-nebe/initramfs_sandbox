dd if=/dev/zero of=linux-boot.img bs=1k count=2000
mkdosfs linux-boot.img
syslinux --install linux-boot.img
sudo mount -o loop linux-boot.img /mnt
sudo cp bzImage /mnt
sudo cp initramfs.cpio.gz /mnt
sudo cp syslinux.cfg /mnt
sudo umount /mnt
