# Preparing the Host System

## Host system requirements

I used the following script from the LFS book to verify that my host system met all the requirements.

```bash
cat > version-check.sh << "EOF"
#!/bin/bash
# A script to list version numbers of critical development tools

# If you have tools installed in other directories, adjust PATH here AND
# in ~lfs/.bashrc (section 4.4) as well.

LC_ALL=C 
PATH=/usr/bin:/bin

bail() { echo "FATAL: $1"; exit 1; }
grep --version > /dev/null 2> /dev/null || bail "grep does not work"
sed '' /dev/null || bail "sed does not work"
sort   /dev/null || bail "sort does not work"

ver_check()
{
   if ! type -p $2 &>/dev/null
   then 
     echo "ERROR: Cannot find $2 ($1)"; return 1; 
   fi
   v=$($2 --version 2>&1 | grep -E -o '[0-9]+\.[0-9\.]+[a-z]*' | head -n1)
   if printf '%s\n' $3 $v | sort --version-sort --check &>/dev/null
   then 
     printf "OK:    %-9s %-6s >= $3\n" "$1" "$v"; return 0;
   else 
     printf "ERROR: %-9s is TOO OLD ($3 or later required)\n" "$1"; 
     return 1; 
   fi
}

ver_kernel()
{
   kver=$(uname -r | grep -E -o '^[0-9\.]+')
   if printf '%s\n' $1 $kver | sort --version-sort --check &>/dev/null
   then 
     printf "OK:    Linux Kernel $kver >= $1\n"; return 0;
   else 
     printf "ERROR: Linux Kernel ($kver) is TOO OLD ($1 or later required)\n" "$kver"; 
     return 1; 
   fi
}

# Coreutils first because --version-sort needs Coreutils >= 7.0
ver_check Coreutils      sort     8.1 || bail "Coreutils too old, stop"
ver_check Bash           bash     3.2
ver_check Binutils       ld       2.13.1
ver_check Bison          bison    2.7
ver_check Diffutils      diff     2.8.1
ver_check Findutils      find     4.2.31
ver_check Gawk           gawk     4.0.1
ver_check GCC            gcc      5.4
ver_check "GCC (C++)"    g++      5.4
ver_check Grep           grep     2.5.1a
ver_check Gzip           gzip     1.3.12
ver_check M4             m4       1.4.10
ver_check Make           make     4.0
ver_check Patch          patch    2.5.4
ver_check Perl           perl     5.8.8
ver_check Python         python3  3.4
ver_check Sed            sed      4.1.5
ver_check Tar            tar      1.22
ver_check Texinfo        texi2any 5.0
ver_check Xz             xz       5.0.0
ver_kernel 5.4

if mount | grep -q 'devpts on /dev/pts' && [ -e /dev/ptmx ]
then echo "OK:    Linux Kernel supports UNIX 98 PTY";
else echo "ERROR: Linux Kernel does NOT support UNIX 98 PTY"; fi

alias_check() {
   if $1 --version 2>&1 | grep -qi $2
   then printf "OK:    %-4s is $2\n" "$1";
   else printf "ERROR: %-4s is NOT $2\n" "$1"; fi
}
echo "Aliases:"
alias_check awk GNU
alias_check yacc Bison
alias_check sh Bash

echo "Compiler check:"
if printf "int main(){}" | g++ -x c++ -
then echo "OK:    g++ works";
else echo "ERROR: g++ does NOT work"; fi
rm -f a.out

if [ "$(nproc)" = "" ]; then
   echo "ERROR: nproc is not available or it produces empty output"
else
   echo "OK: nproc reports $(nproc) logical cores are available"
fi
EOF

bash version-check.sh
```

The checker reported several `ERROR` messages, so I had to make a few adjustments.


> This fixed the Coreutils version problem. The installed package came from the `uutils` project instead of GNU.
```bash
sudo apt install --allow-remove-essential coreutils-from-gnu coreutils-from-uutils-
```

> The script reported `bison`, `gawk`, `m4`, and `texi2any` as missing, so I installed them.
```bash
sudo apt install bison gawk m4 texinfo
```

> My `sh` shell was not symlinked to Bash.
```bash
sudo ln -sf bash /bin/sh && ls -l /bin/sh
```

> You should have zero `ERROR` messages before continuing.
<div align="center">
  <img src="../images/hostrequirements.png"/>
</div>

## Creating Partitions

[Chapter 2: Creating Partitions](https://www.linuxfromscratch.org/lfs/view/stable/chapter02/creatingpartition.html)

Partitioning is commonly done with one of two tools: [cfdisk](https://fr.wikipedia.org/wiki/Cfdisk) or [fdisk](https://fr.wikipedia.org/wiki/Fdisk). The main difference between them is that `cfdisk` provides a graphical interface.

> [!NOTE]
> In this guide, I use `fdisk`.

Here you can find the [Fdisk man](https://man.archlinux.org/man/fdisk.8.en).

The first option I use is `-l`, which **lists all partitions** on your **host system**.
```bash
sudo fdisk -l # You can run this safely on a personal laptop for educational purposes.
```

> You may see several `/dev/loopX` devices. Linux uses them to mount packages as virtual disks without extracting them.
<div align="center">
  <img src="../images/part_fdiskloop.png"/>
</div>

> The important part is the virtual disk, which contains two partitions:
- `/dev/sda1`, with a size of 1 MB, is used to store the boot files.
- `/dev/sda2`, with a size of 25 GB, is used for the root directory and its contents.
<div align="center">
  <img src="../images/part_fdisksda.png"/>
</div>

The next step is to create the partitions for the new distribution.

> [!CAUTION]
> Course requirement:
> You must use at least three partitions: `/`, `/boot`, and a swap partition. You can create additional partitions if needed.


### Partitions Explanation

> [!WARNING]
> You can choose the size of each partition, but refer to the tutorial for the minimum requirements.

- **root** - *35 GB*: This contains the entire Linux file system and is the only partition required for Linux to operate. Common file systems include `ext4`, `btrfs`, and `xfs`.
- **`/boot`** - *1 GB*: This contains the files required to start the system. It is commonly separated from the root partition when the root file system is encrypted or when complex storage such as RAID is used.
- **swap** - *4 GB*: This partition acts as an extension of RAM on disk. When RAM is full, the system can move temporarily inactive data to swap to avoid freezing. During hibernation, it can also store the contents of RAM so they can be restored when the system resumes.

---

To simplify exporting my LFS system and make development more convenient, I will create a new virtual disk attached to the host system.

<div align="center">
  <img src="../images/part_createhdisk.png"/>
</div>

<div align="center">
  <img src="../images/part_paramhdisk.png"/>
</div>

We can now create the partitions. I used [this tutorial](https://doc.ubuntu-fr.org/fdisk), which explains how to use the `fdisk` utilities.

List all partitions with `sudo fdisk -l`.

> [!CAUTION]
> The new virtual disk will usually be `/dev/sdb`, but it may have a different name if other virtual disks are present. This guide assumes the disk is `sdb`; adapt the commands to your system.

<div align="center">
  <img src="../images/part_showsdb.png"/>
</div>

Enter editing mode with `fdisk` by running `sudo fdisk /dev/sdb`.

To start with a clean partition table, enter `o`. This creates a new [MBR partition table](https://en.wikipedia.org/wiki/Master_boot_record).
<div align="center">
  <img src="../images/part_showsdb.png"/>
</div>

### Creating the `/boot` Partition

> [!WARNING]
> On my screenshots i forgot to add the `G` after end size sector
> Ex: +1G

```bash
# in fdisk console
n -> new partition
p -> primary partition
1 -> first partition
ENTER -> default first sector
+1G -> 1go Partition
a -> make the partition bootable
```
<div align="center">
  <img src="../images/part_createboot.png"/>
</div>

### Creating the Swap Partition

> [!WARNING]
> On my screenshots i forgot to add the `G` after end size sector
> Ex: +4G

```bash
# in fdisk console
n -> new partition
p -> primary partition
2 -> second partition
ENTER -> default first sector
+4G -> 4go Partition

t -> change type of partition
2 -> second partition
82 -> linux swap hex code
```
<div align="center">
  <img src="../images/part_createswap.png"/>
</div>

### Creating the Root Partition

```bash
# in fdisk console
n -> new partition
p -> primary partition
3 -> third partition
ENTER -> default first sector
ENTER -> fill the rest of vdisk
```
<div align="center">
  <img src="../images/part_createroot.png"/>
</div>

### Exiting the `fdisk` Console

To save the changes and exit the `fdisk` console, enter `w`.

## Creating a file system 

> [!TIP]
> If you dont understand why those partitions need to be formated please read the chapter02 link below.

[Chapter02 : Creating a file system](https://www.linuxfromscratch.org/lfs/view/stable/chapter02/creatingfilesystem.html) 


Normaly the "name" of each partition will follow the order we make them. 

We can take a look again with `sudo fdisk -l` to make sure.
<div align="center">
  <img src="../images/part_checksdb.png"/>
</div>

We want /boot and /root to be in the last version of ext `4`, the first thing to do is using [mkfs](https://linux.die.net/man/8/mkfs).

> [!CAUTION]
> Dont forget to change numbers if your boot/root is different

```bash
sudo mkfs -v -t ext4 /dev/sdb1
sudo mkfs -v -t ext4 /dev/sdb3
```

```
-V
Produce verbose output, including all file system-specific commands that are executed. Specifying this option more than once inhibits execution of any file system-specific commands. This is really only useful for testing.

-t fstype
Specifies the type of file system to be built. If not specified, the default file system type (currently ext2) is used.
```

Next step is to make the swap partiton swapable with [mkswap](https://manpages.ubuntu.com/manpages/trusty/man8/mkswap.8.html)

```bash
sudo mkswap /dev/sdb2
```

[Comparison_of_file_systems](https://en.wikipedia.org/wiki/Comparison_of_file_systems)

## Setting LFS variable and umask

[Chapter02 : LFS VAR/UMASK](https://www.linuxfromscratch.org/lfs/view/stable/chapter02/aboutlfs.html)


To ease ourself, we make a env variable pointing the directory we want our LFS to be mounted.
```bash
export LFS=/mnt/lfs
```

And set the mode creation mask to `022`
```bash
umask 022
``` 
> Setting the umask to 022 ensures that newly created files and directories are only writable by their owner, but are readable and searchable (only for directories) by anyone

## Mounting the new root partition

[Chapter02 : Mounting the New Partition](https://www.linuxfromscratch.org/lfs/view/stable/chapter02/mounting.html)

First we will need to create a directory where the LFS will be located.

> `-p` will create all parents directories
> `-v` verbose mode for more outputs

```bash
sudo mkdir -pv $LFS
```

Next we will mount the `/root` partition of `35go` into the new LFS directory.
```bash
sudo mount -v -t ext4 /dev/sdb3 $LFS
```

You can verify the mountpoint with this command : 
```bash
mountpoint $LFS
```

This will change the owner of LFS for the user `root`
```bash
sudo chown root:root $LFS
sudo chmod 755 $LFS #rwxr-xr-x
```

The command sudo `/sbin/swapon` enables swap space (virtual memory) on a Linux system using root privileges.
```bash
sudo /sbin/swapon -v /dev/sdb2
```

