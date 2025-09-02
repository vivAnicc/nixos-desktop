{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nur = {
    #   url = "github:nix-community/NUR";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # helix = {
    #   url = "github:helix-editor/helix/master";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		zls = {
			url = "github:zigtools/zls";
			inputs = {
				nixpkgs.follows = "nixpkgs";
			};
		};

		zig = {
			url = "github:mitchellh/zig-overlay";
			inputs.nixpkgs.follows = "nixpkgs";
		};

    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		# This can be added again once I add x86_64 to the flake
    # ccalc = {
    #   url = "github:vivAnicc/ccalc-flake";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ascii-utils.url = "github:oluceps/nix-ascii2char/main";
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem (
      let
        system = "x86_64-linux";
        unfree-pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        inherit system;

        specialArgs = {inherit inputs unfree-pkgs;};

        modules = [
          ./configuration.nix
          inputs.chaotic.nixosModules.default
        ];
      }
    );
  };
}
