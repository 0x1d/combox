#packer {
#  required_plugins {
#    myawesomecloud = {
#      version = "master"
#      source  = "github.com/mkaczanowski/packer-builder-arm"
#    }
#  }
#}

source "arm" "combox" {
  file_checksum_type    = "sha256"
  file_checksum_url     = "https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2022-01-28/2022-01-28-raspios-bullseye-armhf-lite.zip.sha256"
  file_target_extension = "zip"
  file_urls             = ["https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2022-01-28/2022-01-28-raspios-bullseye-armhf-lite.zip"]
  image_build_method    = "reuse"
  image_chroot_env      = ["PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"]
  image_path            = "combox-armhf.img"
  image_size            = "2G"
  image_type            = "dos"
  image_partitions {
    filesystem   = "vfat"
    mountpoint   = "/boot"
    name         = "boot"
    size         = "256M"
    start_sector = "8192"
    type         = "c"
  }
  image_partitions {
    filesystem   = "ext4"
    mountpoint   = "/"
    name         = "root"
    size         = "0"
    start_sector = "532480"
    type         = "83"
  }
  qemu_binary_destination_path = "/usr/bin/qemu-arm-static"
  qemu_binary_source_path      = "/usr/bin/qemu-arm-static"
}

build {
  sources = ["source.arm.combox"]

  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts         = ["bootstrap.sh"]
  }

  provisioner "shell" {
    inline = ["curl -sL https://install.raspap.com > raspap.sh"]
  }

}
