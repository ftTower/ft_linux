# Tutorial from A to Z


1. [system host creation](./hostcreation.md)
2. [partition](#partition)
3. [Creating a file system](#creating-a-file-system) 


<br>
<br>
<br>

# System host creation

> [!CAUTION]
> You have to follow the [system host creation](./hostcreation.md) described in another **.md** before continuing 

## Partition

[Chapter02 : Creating Partition](https://www.linuxfromscratch.org/lfs/view/stable/chapter02/creatingpartition.html)

Creating the partitions is often done with two main tools : [cfdisk](https://fr.wikipedia.org/wiki/Cfdisk) and [fdisk](https://fr.wikipedia.org/wiki/Fdisk), the main difference beetween them is graphical.

> [!NOTE]
> In my case i will use `Fdisk`.

Here you can find the [Fdisk man](https://man.archlinux.org/man/fdisk.8.en).

The first parameter i used is `-l`, this will **list all partitions** already on your **host system**.
```shell
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

List all partitions with `sudo fdisk -l` (our new virtual disk must be /dev/sdb)

<div align="center">
  <img src="./images/part_showsdb.png"/>
</div>



## Creating a file system 

[Creating a file system](https://www.linuxfromscratch.org/lfs/view/stable/chapter02/creatingfilesystem.html)

[Comparison_of_file_systems](https://en.wikipedia.org/wiki/Comparison_of_file_systems)

## Setting LFS variable and umask

[LFS/UMASK](https://www.linuxfromscratch.org/lfs/view/stable/chapter02/aboutlfs.html)

```shell
free -h # take a look at the swap partition
```