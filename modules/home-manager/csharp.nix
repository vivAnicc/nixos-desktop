{ pkgs, ... }:

{
  home.packages = [
    # pkgs.csharp-ls
    pkgs.omnisharp-roslyn
  ];

  # programs.nixvim.lsp.servers.csharp_ls.enable = true;
  programs.nixvim.lsp.servers.omnisharp.enable = true;
}
