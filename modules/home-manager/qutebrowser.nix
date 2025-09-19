{ pkgs, unfree-pkgs, ... }:

{
  home.packages = [
    pkgs.keyutils
  ];

  programs.rofi = {
    enable = true;
    theme = "Arc-Dark";
  };

  programs.qutebrowser = let
    qutebrowser = unfree-pkgs.qutebrowser.override {
      enableWideVine = true;
    };
    # // {
    #   buildInputs = unfree-pkgs.qutebrowser.buildInputs ++ [ pkgs.keyutils ];
    # };
  in {
    enable = true;
    package = qutebrowser;

    keyBindings.normal = {
      "<Ctrl+Shift+Tab>" = "tab-prev";
      "<Ctrl+Tab>" = "tab-next";
      "<Ctrl+e>" = "edit-text";
      "<Alt+e>" = "edit.url";
    };

    settings = {
      colors.webpage = {
        darkmode = {
          algorithm = "lightness-hsl";
          enabled = true;
        };
        preferred_color_scheme = "dark";
      };
      content = {
        autoplay = false;
        blocking = {
          adblock.lists = [
            "https://easylist.to/easylist/easylist.txt"
            "https://easylist.to/easylist/easyprivacy.txt"
          ];
          enabled = true;
          method = "both";
          whitelist = null;
        };
      };
      editor.command = [ "${pkgs.fish}/bin/fish" "-c" "term nvim '{file}'" ];
      input.insert_mode.auto_load = false;
      scrolling.smooth = true;
      tabs.last_close = "close";
      tabs.position = "top";
    };

    perDomainSettings = {
      "git.suyu.dev".content.javascript.clipboard = "access-paste";
      "github.com".content.javascript.clipboard = "access-paste";

      "www.youtube.com".content.notifications.enabled = false;
    };
  };
}
