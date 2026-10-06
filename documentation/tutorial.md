# Tutorial from A to Z


1. [setup-the-host-system](#setup-the-host-system)
2. [partioning](#partioning)


## Setup the host system.

To develop this `Linux from scratch` i need a Host system, i choose [ubuntu](https://ubuntu.com/download/desktop) desktop but you can do it with **any** linux distribution.

---

### Create the virtual machine following those steps :

> Im using `virtualbox-7.2_7.2.20` for `debian 13.6`.

<div align="center">
  <img src="./images/vm_creation.png"/>
</div>

---

> Choose a easy password you will remember.

<div align="center">
  <img src="./images/vm_auth.png"/>
</div>

---

> Choose (RAM / CPU / DISK) in function of your computer.

<div align="center">
  <img src="./images/vm_vhardware.png"/>
</div>

---

> Let it load Ubuntu.

<div align="center">
  <img src="./images/vm_start.png"/>
</div>

---

> Those settings are up to you.

<div align="center">
  <img src="./images/vm_welcome.png"/>
</div>

---

> Finally the host system is up and functional.

<div align="center">
  <img src="./images/vm_welcome2.png"/>
</div>

---

---

> Let save this part with a snapshot `otherwhise on the machine : Host + T`

<div align="center">
  <img src="./images/vm_snapshot.png"/>
</div>

---

## Partioning

[creatingpartition - www.linuxfromscratch.org](https://www.linuxfromscratch.org/lfs/view/stable/chapter02/creatingpartition.html)

[Fdisk man](https://man.archlinux.org/man/fdisk.8.en)

```shell
free -h
```

```shell
sudo fdisk -l
```

<div align="center">
  <img src="./images/part_infoprimary.png"/>
</div>