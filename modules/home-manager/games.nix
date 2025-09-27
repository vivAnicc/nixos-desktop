{ pkgs, inputs, ... }:

{
  home.packages = [
    pkgs.lumafly
    inputs.needlelight.packages.${pkgs.system}.needlelight
  ];
}
