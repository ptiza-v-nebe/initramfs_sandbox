cd root
find . | cpio -ov --format=newc | gzip -9 >../initramfs.cpio.gz
cd ../
