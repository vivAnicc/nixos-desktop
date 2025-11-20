{ ... }:

{
  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
  };

  hardware.nvidia-container-toolkit.enable = true;

  users.users.nick.extraGroups = [ "docker" ];
}
