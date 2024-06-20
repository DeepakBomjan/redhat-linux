### Building and installing Custom kernel module

1. Downloading and unpacking the Linux Kernel¶

```bash
curl -L -o linux-6.5.7.tar.xz \
https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.5.7.tar.xz
```
#### Building the Kernel
Two main steps are required in building a kernel:

* configuring
* compiling

##### Kernel Configuration
```bash
make menuconfig
```
1. To begin, we will copy over and rename the preexisting config file from the /boot directory into our kernel build environment:
```bash
cp /boot/config-`uname -r` ~/build/kernel/.config
```
2. Launch the graphical kernel configuration utility:
```bash
make O=~/build/kernel menuconfig
```
3. Next, we will add support for NTFS into our custom kernel for demonstration purposes.

```bash
grep NTFS ~/build/kernel/.config
```
##### Compiling the Kernel
1. Set custom version
```bash
sed  -i 's/^EXTRAVERSION.*/EXTRAVERSION = -custom/'  Makefile
```
2. Pass the kernelversion target to the make command to view the full version of the kernel that you just customized:
```bash
make O=~/build/kernel kernelversion
```
3. Compile
```bash
make  O=~/build/kernel
```
4. The end product of this command (that is, the kernel) is sitting pretty and waiting in the path:
```bash
~/build/kernel/arch/x86/boot/bzImage
```
5. We need to install the modules because we compiled portions of the kernel as modules (for example, the NTFS module). Type the following:
```bash
sudo make O=~/build/kernel modules_install
```
##### Installing the Kernel
1. While in the root of your kernel build directory, copy and rename the bzImage file into the /boot directory:
```bash
sudo cp ~/build/kernel/arch/x86/boot/bzImage \
/boot/vmlinuz-<kernel-version>
```
2. Now that the kernel image is in place, copy over and rename the corresponding System.map file into the /boot directory using the same naming convention:
```bash
sudo cp -v  ~/build/kernel/System.map \
/boot/System.map-6.5.7-custom
```
3. With the kernel in place, the System.map file in place, and the modules in place, we are now ready for the final step. The syntax for the command needed is:
```bash
sudo kernel-install \
add  6.5.7-custom /boot/vmlinuz-6.5.7-custom
```
##### Booting the custom Kernel
```bash
reboot
uname -r
modinfo ntfs
```

### [An example of a kernel module](https://linux-kernel-labs.github.io/refs/heads/master/labs/kernel_modules.html)

### References
https://docs.rockylinux.org/guides/custom-linux-kernel/
