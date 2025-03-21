{ config, pkgs, ... }:
{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      autoResize = true;
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/ESP";
      fsType = "vfat";
    };
  };

  hardware.firmware = with pkgs; [
    raspberrypiWirelessFirmware
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [
    "console=ttyS0,115200"
    "console=tty0"
  ];

  #boot.kernelPackages = pkgs.linuxPackages_rpi4;
}
