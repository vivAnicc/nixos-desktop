{ ... }:

{
  programs.qutebrowser = {
    enable = true;

    keyBindings.normal = {
      "<Ctrl+Shift+Tab>" = "tab-prev";
      "<Ctrl+Tab>" = "tab-next";
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
      editor.command = [ "hx" "'{file}'" ];
      input.insert_mode.auto_load = true;
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
