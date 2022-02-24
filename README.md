# ComBox

## Features

- Wireless Access Point
- ...

## Bill of Materials

- RaspberryPI Zero W
- SD Card 32 GB
- ...

## Flash to SD Card
Use [etcher](https://www.balena.io/etcher/)
*OR*  
proceeed as follows:
```
# determin SD card (e.g. /dev/sdc)
lsblk 

# flash
read -p "SD Card: " SDCARD_PATH
sudo dd if=combox-armhf.img of=$SDCARD_PATH status=progress
```

## Build

You need a Linux x86 system with `make` and `Docker` installed to build the device image.
```
make build
```


## Links

- https://docs.raspap.com/faq/#headless
- https://docs.raspap.com/ap-sta/
