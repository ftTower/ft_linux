# Preparing the Host System

[Chapter02 : Creating Partition](https://www.linuxfromscratch.org/lfs/view/stable/chapter02/creatingpartition.html)

Creating the partitions is often done with two main tools : [cfdisk](https://fr.wikipedia.org/wiki/Cfdisk) and [fdisk](https://fr.wikipedia.org/wiki/Fdisk), the main difference beetween them is graphical.

> [!NOTE]
> In my case i will use `Fdisk`.

Here you can find the [Fdisk man](https://man.archlinux.org/man/fdisk.8.en).

The first parameter i used is `-l`, this will **list all partitions** already on your **host system**.
```bash
sudo fdisk -l # you can try this without risk on your personal laptop for education purpose.
```

> You will see many `/dev/loopX`, those are packages mounted like virtual disk by linux to use them without decompressing them.
<div align="center">
  <img src="./images/part_fdiskloop.png"/>
</div>

> This is the interesting part, you will see two partitions made on the virtual disk.
- `/dev/sda1` of 1MB is the partition needed to host the boot.
- `/dev/sda2` of 25GB is the partition for the root directory (where all will be stocked).
<div align="center">
  <img src="./images/part_fdisksda.png"/>
</div>

The next step will be to create our personal partitions for our distribution. 

> [!CAUTION]
> School subject :  
> You must use at least 3 different partitions: root, /boot and a swap partition. You
> can, of course, make more partitions if you want to.


### Partitions Explanation

> [!WARNING]
> You have the choice for the size of each partition, but you have to refer to the tutorial to see the minimum required

- **root** - *35go* : This will contain all the linux file system, this is the only mandatory partition for linux to work. (common format : ext4, btrfs, xfs)
- **/boot** - *1go* : Contain all the files necessary for starting the system. Nowadays the main reasons to separate it from root is to load the program who ask the disk password if the root partition is encrypted, and if you use complex storage like RAID for servers  
- **swap** - *4go* : This partition is not a naviguable memory but will act like an extension of your RAM on the disk. The RAM in case of overflow will move temporary inactive data into this partition to avoid the system to freeze. In case of system hibernation it can also move all the RAM content into it, so the system at the awakening will load it in the RAM from this partition.

---

To facilitate the export of my LFS and the developpement practicity, i will create a new virtual disk attached to my host system.

<div align="center">
  <img src="./images/part_createhdisk.png"/>
</div>

<div align="center">
  <img src="./images/part_paramhdisk.png"/>
</div>

Finally we can create partitions, i used [this](https://doc.ubuntu-fr.org/fdisk) tutorial explaning how to use fdisk utilities.

List all partitions with `sudo fdisk -l` 

> [!CAUTION]
> our new virtual disk must be /dev/sdb but it is possible to have another name if you have already more vdisk, in my tutorial i will assume you have `sdb` but adapt it to your case.

<div align="center">
  <img src="./images/part_showsdb.png"/>
</div>

Next step is to enter edit mode with `fdisk` using ```sudo fdisk /dev/sdb```

To be secure with my new virtual disk the first thing i do is just `o` it will 
create a new fresh [MBR DOS table.](https://en.wikipedia.org/wiki/Master_boot_record)
<div align="center">
  <img src="./images/part_showsdb.png"/>
</div>

### Creating /boot partition

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
  <img src="./images/part_createboot.png"/>
</div>

### Creating swap partition

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
  <img src="./images/part_createswap.png"/>
</div>

### Creating root partition

```bash
# in fdisk console
n -> new partition
p -> primary partition
3 -> third partition
ENTER -> default first sector
ENTER -> fill the rest of vdisk
```
<div align="center">
  <img src="./images/part_createroot.png"/>
</div>

### Exit fdisk console

to clean escape from fdisk console enter `w`

### Creating a file system 

> [!TIP]
> If you dont understand why those partitions need to be formated please read the chapter02 link below.

[Chapter02 : Creating a file system](https://www.linuxfromscratch.org/lfs/view/stable/chapter02/creatingfilesystem.html) 


Normaly the "name" of each partition will follow the order we make them. 

We can take a look again with `sudo fdisk -l` to make sure.
<div align="center">
  <img src="./images/part_checksdb.png"/>
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

# Next part : [Installing Sources](./lfspackages.md)
