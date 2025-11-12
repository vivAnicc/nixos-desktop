 { pkgs, inputs, ... }:

{
  programs.nix-ld.enable = true;

  environment.systemPackages = [
    inputs.nix-alien.packages.${pkgs.stdenv.hostPlatform.system}.nix-alien
  ];
}
