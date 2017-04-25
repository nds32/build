export NDS32_ROOT=`pwd`

rm -rf build/{binutils,gcc1,gcc2,newlib}
mkdir -p build/{binutils,gcc1,gcc2,newlib}

echo "Building binutils..."
cd $NDS32_ROOT/build/binutils
../../src/binutils/configure --target=nds32le-elf --with-arch=v3m --prefix=$NDS32_ROOT/toolchain --disable-nls --enable-plugins --enable-16m-addr=yes
make
make install

if [ -L $NDS32_ROOT/src/gcc/cloog ]; then
    echo "Prerequisites exist, bypass download..."
else
    echo "Download prerequisites..."
    cd $NDS32_ROOT/src/gcc
    ./contrib/download_prerequisites
fi
export PATH=$PATH:$NDS32_ROOT/toolchain/bin/

echo "Building init gcc..."
cd $NDS32_ROOT/build/gcc1
../../src/gcc/configure --target=nds32le-elf --with-arch=v3m --with-cpu=n8 --enable-default-relax=yes --prefix=$NDS32_ROOT/toolchain --disable-nls --enable-lto --with-nds32-lib=newlib --enable-threads=single --with-newlib --disable-shared --disable-libssp --enable-languages=c --enable-checking=no
make
make install

echo "Building newlib..."
cd $NDS32_ROOT/build/newlib
../../src/newlib/configure --target=nds32le-elf --prefix=$NDS32_ROOT/toolchain --enable-newlib-io-c99-formats --enable-newlib-io-long-long
make
make install

echo "Building final gcc..."
cd $NDS32_ROOT/build/gcc2
../../src/gcc/configure --target=nds32le-elf --with-arch=v3m --with-cpu=n8 --enable-default-relax=yes --prefix=$NDS32_ROOT/toolchain --disable-nls --enable-languages=c,c++ --enable-lto --with-newlib --disable-shared --enable-threads=single --with-headers=$NDS32_ROOT/toolchain/nds32le-elf/include --with-nds32-lib=newlib --enable-checking=no
make
make install


