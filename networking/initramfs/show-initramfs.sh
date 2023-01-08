sudo rm -rf extracted
mkdir -p extracted
cd extracted
sudo zcat ../rootfs.cpio.gz | sudo cpio -i -d -H newc --no-absolute-filenames
cd ..
