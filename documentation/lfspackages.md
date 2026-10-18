# Installing sources packages

```
sudo mkdir -v $LFS/sources 
```

```
sudo chmod -v a+wt $LFS/sources
```

```
sudo wget https://www.linuxfromscratch.org/lfs/view/stable/wget-list-sysv -P $LFS/sources/
```

```
sudo wget --input-file=$LFS/sources/wget-list-sysv --continue --directory-prefix=$LFS/sources
```