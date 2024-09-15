# Set Default Kernal
I use tkg kernal and want my system to choose the latest tkg-linux kernal I have installed over the brand new kernal that gets installed by Debian...

## Step 1:
### Read currently installed kernals
```sh
sudo grep "menuentry" /boot/grub/grub.cfg
```

### stretch terminal window so it's easier to read...

## Step 2:
### Read currently installed kernals
### example entire line:
```sh
menuentry 'Debian GNU/Linux GNU/Linux, with Linux 6.10.8-tkg-bore' --class debian --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-6.10.8-tkg-bore-advanced-4c74f6f0-915a-4909-a1a6-d6939ac7b825' {
```

## Step 3:
### edit grub config
```sh
sudo micro /etc/default/grub
```
example:
```sh
GRUB_DEFAULT="Debian GNU/Linux GNU/Linux, with Linux 6.10.8-tkg-bore"
```

## Step 4:
### update grub:
```sh
sudo update-grub
```

# Next reboot grub should pick the kernal you chose.
