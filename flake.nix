{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable-nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien.url = "github:thiagokokada/nix-alien";

    # nur = {
    #   url = "github:nix-community/NUR";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

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
