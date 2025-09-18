{ pkgs, ... }:

{
  home.packages = [
    # pkgs.dconf
  ];

  # dconf = {
  #   enable = true;
  #   settings = {
  #     "org/
  #   };
  # };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.gnome-themes-extra;
    name = "Adwaita";
    size = 24;
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = "Adwaita";
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
