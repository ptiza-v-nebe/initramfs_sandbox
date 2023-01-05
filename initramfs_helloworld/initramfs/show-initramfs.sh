mkdir -p extracted
cd extracted
zcat ../initramfs.cpio.gz | cpio -i -d -H newc --no-absolute-filenames
cd ..
