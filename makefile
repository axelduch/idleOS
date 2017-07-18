default: write-to-floppy-file

compile:
	nasm -f bin -o ./build/bootloader.bin bootloader.asm


write-to-floppy-file: compile
	dd conv=notrunc bs=512 count=1 if=./build/bootloader.bin of=build/bootloader.flp

write-to-usb-device: compile
	dd oflag=direct bs=512 count=1 if=./build/bootloader.bin of=/dev/sdc
