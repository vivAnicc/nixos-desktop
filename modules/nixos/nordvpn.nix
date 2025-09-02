{ pkgs, ... }:

{
  networking.firewall.checkReversePath = false;
  networking.firewall.allowedUDPPorts = [ 1194 ];
  networking.firewall.allowedTCPPorts = [ 443 ];

  users.users.nick.extraGroups = [ "nordvpn" ];

  environment.systemPackages = [
    pkgs.nordvpn
  ];

  chaotic.nordvpn.enable = true;
}
