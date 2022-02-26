variable "arch" {
  default = "armhf"
}
variable "image" {
  default = {
    arm64 = "https://downloads.raspberrypi.org/raspios_arm64/images/raspios_arm64-2022-01-28/2022-01-28-raspios-bullseye-arm64.zip"
    armhf = "https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2022-01-28/2022-01-28-raspios-bullseye-armhf-lite.zip"
  }
}

locals {
  image = lookup(var.image, var.arch, "armhf")
}

source "arm" "combox" {
  file_checksum_type    = "sha256"
  file_checksum_url     = "${local.image}.sha256"
  file_target_extension = "zip"
  file_urls             = [local.image]
  image_build_method    = "reuse"
  image_chroot_env      = ["PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"]
  image_path            = "combox-${var.arch}.img"
  image_size            = "4G"
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

  #provisioner "file" {
  #  source      = "wpa_supplicant.conf"
  #  destination = "/boot/wpa_supplicant.conf"
  #}

  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts         = ["bootstrap.sh"]
  }

  provisioner "shell" {
    inline = ["curl -sL https://install.raspap.com | bash"]
  }

}
