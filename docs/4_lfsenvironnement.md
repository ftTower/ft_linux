# Preparing the LFS Environment

## Creating a Limited Directory Layout

First, create the basic directory structure for LFS.

```bash
sudo mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin} # Create etc and var in the root directory, and bin, lib, and sbin in usr.

for i in bin lib sbin; do
  sudo ln -sv usr/$i $LFS/$i # Create a symbolic link in the root directory for each directory.
done

case $(uname -m) in
  x86_64) sudo mkdir -pv $LFS/lib64 ;; # Create lib64 for the x86_64 architecture.
esac
```

Create a `tools` directory for the compiled sources.
```bash
mkdir -pv $LFS/tools
```

## Creating the First User

Create the first LFS user and add it to the `lfs` group.
```bash
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
```

> `-s` specifies the default shell for the new user.
> `-g lfs` adds the user to the `lfs` group.
> `-m` creates a home directory for the user.
> `-k /dev/null` prevents files from being copied from a skeleton directory.
> `lfs` is the name of the new user.

Set a password for the `lfs` user:
```bash
sudo passwd lfs
```

## Creating the User Environment

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