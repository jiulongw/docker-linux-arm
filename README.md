# Linux ARM64 Kernel Builder
Tired of setting up build environment to hack your shiny ARM based IoT devices?

With this docker image, you can build custom Linux kernel (arm64 arch) anywhere
without messing up with your environment.  gcc version?  g++-multilib conflict?
You know what I'm talking about.

No performance penalty when running under Linux.  You get almost 100% of your CPU power when building source code.

Tested with Firefly RK3399 BSP kernel.

## Usage
You can symbolic link `shell` to your `$PATH`.  E.g.
```
ln -s ~/github/docker-linux-arm/shell /usr/local/bin/linux-arm-shell
```

Now simply run it from directory where kernel source is located.

```
(~/github/ff-kernel)$ linux-arm-shell
linux@6c348d9a2dc8:/$ cd ~/ff-kernel
linux@6c348d9a2dc8:~/ff-kernel$ make firefly_linux_defconfig
...
linux@6c348d9a2dc8:~/ff-kernel$ make rk3399-firefly-linux.img -j4
...
Pack to resource.img successed!
  Image:  resource.img (with rk3399-firefly-linux.dtb logo.bmp ) is ready
```

## Note:
1. The shell script will attach to existing container if it exists.
If you want to change source code directory, delete existing container first.
```
docker rm linux-arm
```

2. The container shell runs as local user `linux` instead of `root` to prevent generated file being owned by root.
To run any command inside the container that requires `root`, you can `sudo`, which does not require a password.
