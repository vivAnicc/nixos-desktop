{ pkgs, ... }:

let
  itools = pkgs.interception-tools;
  itools-caps = pkgs.interception-tools-plugins.caps2esc;
in {
  services.interception-tools = {
    enable = true;
    plugins = [ itools-caps ];
    udevmonConfig = #yaml
    ''
      - JOB: "${itools}/bin/intercept -g $DEVNODE | ${itools-caps}/bin/caps2esc -m 1 | ${itools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
    '';
  };
}
