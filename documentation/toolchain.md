# Cross Compiling Sources

## Pre-Ressources

> [!NOTE]
> Those screenshot are from my personnal computer

<div align="center">
  <img src="./images/cross_triplet.png"/>
</div>

```bash
gcc -dumpmachine
```

<br>

<div align="center">
  <img src="./images/cross_interpreter.png"/>
</div>

```bash
readelf -l <name of binary> | grep interpreter
```

- [Toolchain Technical Notes](https://www.linuxfromscratch.org/lfs/view/stable/partintro/toolchaintechnotes.html)


## Compilation Instructions

> [!NOTE]
> DO NOT USE ROOT (use lfs user)
> Compile all packages in a directory accessible by chroot (into $LFS)
> All compilation are not the same follow the manual

Compiling a sources package : 

1. Untar the archive ```tar -xf <package>.tar.gz```
2. Enter the created directory ```cd <package>```
3. Follow guide for specific compilation 
4. return to sources ```cd $LFS/sources```
5. delete the extracted directory ```rm -rf <packages>```

## All the Tools from Cross-Tool-Chain

1. [Compile binutils](https://www.linuxfromscratch.org/lfs/view/stable/chapter05/binutils-pass1.html)
2. [Compile cross GCC](https://www.linuxfromscratch.org/lfs/view/stable/chapter05/gcc-pass1.html)
3. [Install linux API header](https://www.linuxfromscratch.org/lfs/view/stable/chapter05/linux-headers.html)
4. [Compile GlibC](https://www.linuxfromscratch.org/lfs/view/stable/chapter05/glibc.html)
5. [Compile Libstdc](https://www.linuxfromscratch.org/lfs/view/stable/chapter05/gcc-libstdc++.html)

<br><br><br>

# Next part : [Cross Compiling Temporary Tools](./temptools.md)