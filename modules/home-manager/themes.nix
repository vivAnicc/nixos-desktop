{ pkgs, ... }:

{
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.gnome-themes-extra;
    name = "Adwaita";
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    cursorTheme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita";
      size = 24;
    };
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}
