{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable-nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien.url = "github:thiagokokada/nix-alien";

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
			url = "github:zigtools/zls/38b0e83ff81785bc01d85a2f0734e4b53556bdfc";
			# inputs = {
			# 	nixpkgs.follows = "nixpkgs";
			# };
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

    needlelight = {
      url = "github:vivAnicc/needlelight-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    copy-paste = {
      url = "github:vivAnicc/copy-paste";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, stable-nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem (
      let
        system = "x86_64-linux";
        stable-pkgs = import stable-nixpkgs {inherit system;};
        unfree-pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        inherit system;

        specialArgs = {inherit inputs unfree-pkgs stable-pkgs;};

        modules = [
          ./configuration.nix
          inputs.chaotic.nixosModules.default
        ];
      }
    );
  };
}
