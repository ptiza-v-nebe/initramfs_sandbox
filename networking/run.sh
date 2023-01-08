#start emulation
qemu-system-x86_64 -nographic -kernel output/bzImage -initrd output/rootfs.cpio.gz -append "console=tty0 console=ttyS0"
