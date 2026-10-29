# Cross Compiling Temporary Tools

For this part you have to follow the same rules as before chapter.

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

---

## The Tools

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
16. [Binutils.pass2](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/binutils-pass2.html)
17. [Gcc.pass2](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/gcc-pass2.html)


