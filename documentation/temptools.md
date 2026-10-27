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