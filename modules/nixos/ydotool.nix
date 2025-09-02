{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.ydotool
  ];

  programs.ydotool.enable = true;

  users.users.nick.extraGroups = [ "ydotool" ];
}
