{ lib, config, pkgs, ... }:

{
  imports = [
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
    # ./modules/home-manager/bitwarden.nix
  ];

  # nixpkgs.config.allowUnfree = true;

  home = {
    username = "nick";
    homeDirectory = "/home/nick";
    stateVersion = "25.05";

    packages = [
      pkgs.file

      # inputs.ccalc.packages.x86_64-linux.default
    ];
  };

  gtk = {
    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita";
    };
    cursorTheme.name = "Adwaita";
    iconTheme.name = "Adwaita";
    enable = true;
  };
  home.pointerCursor = {
    gtk.enable = true;
    name = "Adwaita";
    package = pkgs.gnome-themes-extra;
  };
  home.file."${config.home.homeDirectory}/.gtkrc-2.0".force = lib.mkForce true;

  programs.home-manager.enable = true;
}
