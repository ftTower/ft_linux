# Preparing LFS Environnement

## Creating a Limited Directory Layout

First we need to create the basic directory for our lfs.

```bash
sudo mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin} # make etc+var in root directory and add bin+lib+sbin in the usr directory

for i in bin lib sbin; do
  sudo ln -sv usr/$i $LFS/$i # for each one make a symbolic link into the root 
done

case $(uname -m) in
  x86_64) sudo mkdir -pv $LFS/lib64 ;; # in case the system is under x64/84 architecture make a lib64 into root
esac
```

make a `tools` directory for the compiled sources 
```bash
mkdir -pv $LFS/tools
```

## Creating The First User

We are gonna make the first user for our lfs in the group lfs 
```bash
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
```

> `-s` specify the default bash for the created user
> `-g lfs` add this user to the group lfs
> `-m` this create a home directory for the user
> `-k /dev/null` this parameter prevents possible copying of files from a skeleton directory 
> `lfs` the user created

put a password on the `lfs` user with :
```bash
sudo passwd lfs
```

## Creating His Environnement

```bash
chown -v lfs $LFS/{usr{,/*},var,etc,tools}
case $(uname -m) in
  x86_64) chown -v lfs $LFS/lib64 ;;
esac
```

```bash
cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF
```

```bash
cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
EOF
```

```bash
[ ! -e /etc/bash.bashrc ] || sudo mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE
```

```bash
nproc
```

```bash
export MAKEFLAGS=-j3
```

```bash
cat >> ~/.bashrc << "EOF"
export MAKEFLAGS=-j$(nproc)
EOF
```

```bash
source ~/.bash_profile
```