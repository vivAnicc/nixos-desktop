{ pkgs, stable-pkgs, ... }:

{
  home.packages = [
    pkgs.typst
    stable-pkgs.tinymist
  ];

	programs.nixvim.lsp.servers.tinymist.enable = true;
}
