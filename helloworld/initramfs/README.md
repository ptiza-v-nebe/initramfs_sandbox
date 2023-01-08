https://stackoverflow.com/questions/10603104/the-difference-between-initrd-and-initramfs

Minimal runnable QEMU examples and newbie explanation

In this answer, I will:

provide a minimal runnable Buildroot + QEMU example for you to test things out
explain the most fundamental difference between both for the very beginners who are likely googling this
Hopefully these will serve as a basis to verify and understand the more internals specifics details of the difference.

The minimal setup is fully automated here, and this is the corresponding getting started.

The setup prints out the QEMU commands as they are run, and as explained in that repo, we can easily produce the three following working types of boots:

root filesystem is in an ext2 "hard disk":

qemu-system-x86_64 -kernel normal/bzImage -drive file=rootfs.ext2
root filesystem is in initrd:

qemu-system-x86_64 -kernel normal/bzImage -initrd rootfs.cpio
-drive is not given.

rootfs.cpio contains the same files as rootfs.ext2, except that they are in CPIO format, which is similar to .tar: it serializes directories without compressing them.

root filesystem is in initramfs:

qemu-system-x86_64 -kernel with_initramfs/bzImage
Neither -drive nor -initrd are given.

with_initramfs/bzImage is a kernel compiled with options identical to normal/bzImage, except for one: CONFIG_INITRAMFS_SOURCE=rootfs.cpio pointing to the exact same CPIO as from the -initrd example.

By comparing the setups, we can conclude the most fundamental properties of each:

in the hard disk setup, QEMU loads bzImage into memory.

This work is normally done by bootloaders / firmware do in real hardware such as GRUB.

The Linux kernel boots, then using its drivers reads the root filesystem from disk.

in the initrd setup, QEMU does some further bootloader work besides loading the kernel into memory: it also:

loads the rootfs.cpio into memory
informs the kernel about it: https://unix.stackexchange.com/questions/89923/how-does-linux-load-the-initrd-image
This time then, the kernel just uses the rootfs.cpio from memory directly, since no hard disk is present.

Writes are not persistent across reboots, since everything is in memory

in the initramfs setup, we build the kernel a bit differently: we also give the rootfs.cpio to the kernel build system.

The kernel build system then knows how to stick the kernel image and the CPIO together into a single image.

Therefore, all we need to do is to pass the bzImage to QEMU. QEMU loads it into image, just like it did for the other setups, but nothing else is required: the CPIO also gets loaded into memory since it is glued to the kernel image!
