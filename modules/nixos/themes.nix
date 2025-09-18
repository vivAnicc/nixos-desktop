{ pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      # pkgs.xdg-desktop-portal-hyprland
    ];
    config.common.default = "*";
  };

  services.dbus.packages = [ pkgs.dconf ];
  programs.dconf.enable = true;

  environment = {
    variables.GTK_THEME = "Adwaita";
    systemPackages = [ pkgs.gnome-themes-extra ];
  };
}
