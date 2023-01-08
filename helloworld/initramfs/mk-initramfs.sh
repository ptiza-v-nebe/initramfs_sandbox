myinit/compile.sh

mkdir -p output

cp myinit/myinit output/init
mkdir output/dev
sudo mknod --mode=0600 output/dev/console c 5 1

cd output

find . | cpio -o -H newc | gzip > ../initramfs.cpio.gz

cd ..

rm -rf output
