{ pkgs, lib, config, inputs, ... }:

{
	home.packages = [
		inputs.zig.packages."${pkgs.system}".master
		inputs.zls.packages."${pkgs.system}".zls
	];

	programs.nixvim.lsp.servers.zls = {
    enable = true;
    settings.settings.zig_lib_path = lib.mkIf config.programs.nixvim.enable "${inputs.zig.packages."${pkgs.system}".master}/lib";
  };
}
