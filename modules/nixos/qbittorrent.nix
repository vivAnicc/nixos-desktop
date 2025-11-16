{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.qbittorrent
  ];

  services.qbittorrent.enable = true;
}
