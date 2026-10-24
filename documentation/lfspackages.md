# Installing sources packages

```bash
sudo mkdir -v $LFS/sources 
```

```bash
sudo chmod -v a+wt $LFS/sources
```

```bash
sudo wget https://www.linuxfromscratch.org/lfs/view/stable/wget-list-sysv -P $LFS/sources/
```

```bash
sudo wget --input-file=$LFS/sources/wget-list-sysv --continue --directory-prefix=$LFS/sources
```

```bash
pushd $LFS/sources
  md5sum -c md5sums
popd
```

```bash
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
```

```bash
sudo passwd lfs
```

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