# idleOS
This was meant to be built on a Linux x86_64 architecture. (Fedora Workstation in my case)

## Packages needed to compile:
 - nasm
 - dd

## Packages needed to execute run.sh:
 - qemu (qemu-kvm)

## To compile bootloader.asm

```
make
```

## To use it from a terminal
```
./run.sh
```

## Disclaimer
I made this for my own educational purpose, be careful with the targets in the makefile, one of them actually erases a usb device (/dev/sdc) previous data.
