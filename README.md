# camos

An amazing operating system

## Getting Started

To get this operating system up and running, you need to follow the steps here. It's super easy, I promise.

### Prerequisites

Install Nasm to be able to assemble the project. This is needed regardless of where you would like to run the OS.

```
sudo apt-get install build-essential nasm
```
Run the build script
```
./build.sh
```

### 1. Booting from .iso

Follow this instruction if you want to boot it on your computer, which is obviously the best choice. Or in VirtualBox if you're totally lame and don't know if camos is for you.

Create an .iso

```
mkisofs -o bootloader.iso -b bootloader.flp .
```

That's it. Now you can burn it as a CD image and boot it from your CD drive. Or well, not burn it and use VirtualBox.

### 2. Using Qemu

Install Qemu

```
sudo apt-get install build-essential qemu
```
Boot camos

```
qemu-system-i386 -fda camos.flp
```

### Start having fun
You will now be welcomed into your shiny, new OS. Camos supports typing characters from your keyboard infinitely many times. If you make a typo, just press enter for a fresh start! Type 'q' to quit typing.

## Acknowledgments

* bootloader.asm shamelessly stolen from the [MikeOS project](http://mikeos.sourceforge.net/)
