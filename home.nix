{ config, pkgs, ... }:

{
  imports = [
    modules/home-manager/themes.nix

    modules/home-manager/fish.nix
    modules/home-manager/c.nix
    modules/home-manager/nvim.nix
    modules/home-manager/zig.nix
    modules/home-manager/ssh.nix
    modules/home-manager/waybar.nix
    modules/home-manager/qutebrowser.nix
    modules/home-manager/wofi.nix
    modules/home-manager/hyprland.nix
    modules/home-manager/hypridle.nix
    modules/home-manager/zellij.nix
    modules/home-manager/ghostty.nix
    modules/home-manager/ludusavi.nix
    modules/home-manager/mpv.nix
    modules/home-manager/vesktop.nix
    modules/home-manager/xdg.nix
    modules/home-manager/games.nix
    # ./modules/home-manager/bitwarden.nix
  ];

  home = {
    username = "nick";
    homeDirectory = "/home/nick";
    stateVersion = "25.05";

    packages = [
      pkgs.file
      pkgs.tree
      pkgs.gnome-themes-extra
      pkgs.bitwarden
      pkgs.thunderbird
      # inputs.ccalc.packages.x86_64-linux.default
    ];

    file."games".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/share/Steam/steamapps/common";
  };

  programs.home-manager.enable = true;
}
