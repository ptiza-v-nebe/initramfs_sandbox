mkdir -p output
sudo cp -r rootfs/* output/

cd output
sudo find . | cpio -o -H newc | gzip > ../rootfs.cpio.gz
cd ..

sudo rm -rf output
