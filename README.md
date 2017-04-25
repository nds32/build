# build BSP410 nds32-elf-newlib-v3m target
This build script helps to build nds32-elf-newlib-v3m target
- gcc-4.9.3
- binutils-2.24
- newlib-2.2.0

## Get build script
``` bash
mkdir nds32-bsp410
cd nds32-bsp410
git clone https://github.com/nds32/build.git -b BSP410-nds32-elf-newlib-v3m
```

## Build nds32 toolchain for nds32-elf-newlib-v3m target
```
./build/build-nds32-toolchain.sh
```

## Get toolchain
If build successfully, you can get nds32 toolchain at **toolchain** folder
