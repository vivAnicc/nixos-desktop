{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = [
        pkgs.nvidia-vaapi-driver
        pkgs.libva-vdpau-driver
        pkgs.libvdpau-va-gl
        pkgs.libva
      ];
    };

    nvidia = {
      modesetting.enable = true;

      powerManagement.enable = true;

      open = true;
      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };

  environment.systemPackages = [
    pkgs.vulkan-tools
    pkgs.mesa-demos
    pkgs.libva-utils
  ];
}
