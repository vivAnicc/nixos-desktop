# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, unfree-pkgs, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    inputs.home-manager.nixosModules.home-manager
    modules/nixos/ssh.nix
    modules/nixos/zerotierone.nix
    modules/nixos/nordvpn.nix
    modules/nixos/ydotool.nix
    modules/nixos/steam.nix
    modules/nixos/git.nix
  ];

  system.stateVersion = "25.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 20;
  };

  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    nvidiaPersistenced = true;
  };
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = 1;
  };

  environment.systemPackages = [
    pkgs.egl-wayland
    pkgs.nvidia-vaapi-driver
    pkgs.wl-clipboard
    pkgs.wget
  ];

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  time.timeZone = "Europe/Rome";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nick = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;

  fonts.packages = [ pkgs.nerd-fonts.adwaita-mono ];

  console.keyMap = "it";

  services.printing.enable = true;

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs unfree-pkgs; };
    users."nick" = import ./home.nix;
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  # fileSystems = {
  #   "/run/media/home".device = "/dev/nvme0n1p3";
  #   "/run/media/root".device = "/dev/nvme0n1p2";
  #   "/run/media/root/boot".device = "/dev/nvme0n1p1";
  # };

  programs.hyprland.enable = true;

  # system.autoUpgrade = {
  #   enable = true;
  #   channel = "https://nixos.org/channels/nixos-unstable";
  #   dates = "daily";
  # };
}
