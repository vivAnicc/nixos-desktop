{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    extest.enable = true;
    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];
    protontricks.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    # config.common.default = ["gtk"];
  };
}
