{ ... }:

{
  services.zerotierone = {
    enable = true;
    joinNetworks = [
      "9e1948db63112f58"
    ];
  };

  networking.hosts = {
    "172.26.194.4" = [ "desktop-nixos" ];
    "172.26.42.30" = [ "pixel9-nixos" ];
  };
}
