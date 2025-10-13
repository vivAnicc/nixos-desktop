{ pkgs, ... }:

{
  programs.thunar = {
    enable = true;
    plugins = [
      pkgs.xfce.thunar-volman
      pkgs.xfce.thunar-archive-plugin
    ];
  };

  xdg.mime.defaultApplications."inode/directory" = [ "thunar.desktop" ];
}
