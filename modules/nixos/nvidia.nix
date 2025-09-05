{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = [
        pkgs.nvidia-vaapi-driver
        pkgs.vaapiVdpau
        pkgs.libvdpau-va-gl
        pkgs.libva
      ];
    };

    nvidia = {
      modesetting.enable = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = true;
      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };

  environment.systemPackages = [
    pkgs.vulkan-tools
    pkgs.glxinfo
    pkgs.libva-utils
  ];
}
