# Cross-Compiling the Temporary Tools

For this chapter, follow the same rules as in the previous chapter.

> [!NOTE]
> Do not use the `root` user. Use the `lfs` user.
> Compile all packages in a directory that is accessible from the chroot environment, such as `$LFS`.
> The compilation steps differ between packages. Follow the LFS book for each package.

To compile a source package:

1. Extract the archive with `tar -xf <package>.tar.gz`.
2. Enter the extracted directory with `cd <package>`.
3. Follow the package-specific compilation instructions.
4. Return to the sources directory with `cd $LFS/sources`.
5. Remove the extracted directory with `rm -rf <package>`.

---

## Temporary Tools

1. [M4](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/m4.html)
2. [Ncurses](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/ncurses.html)
3. [Bash](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/bash.html)
4. [Coreutils](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/coreutils.html)
5. [Diffutils](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/diffutils.html)
6. [File](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/file.html)
7. [Findutils](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/findutils.html)
8. [Gawk](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/gawk.html)
9. [Grep](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/grep.html)
10. [Gzip](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/gzip.html)
11. [Make](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/make.html)
12. [Patch](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/patch.html)
13. [Sed](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/sed.html)
14. [Tar](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/tar.html)
15. [Xz](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/xz.html)
16. [Binutils pass 2](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/binutils-pass2.html)
17. [GCC pass 2](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/gcc-pass2.html)


