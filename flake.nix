# 💫 https://github.com/JaKooLit 💫 #

{
  description = "Michael Hess's NixOS-Hyprland"; 
  	
  inputs = {
  	nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:/nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
	  hyprland.url = "github:hyprwm/Hyprland"; # hyprland development
	  nixos-hardware.url = "github:nixos/nixos-hardware/master";
	  ags.url = "github:aylur/ags/v1"; # aylurs-gtk-shell-v1
    stylix.url = "github:danth/stylix";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvix.url = "github:niksingh710/nvix";
  };

  outputs = 
	inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      host = "default";
      username = "michael";

    pkgs = import nixpkgs {
       	inherit system;
       	config = {
       	  allowUnfree = true;
	        cudaSupport = true;
       	};
    };
    in
    {
      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem rec {
          specialArgs = { 
            inherit system;
            inherit inputs;
            inherit username;
            inherit host;
            };
          modules = [ 
            ./hosts/${host}/config.nix
            # inputs.distro-grub-themes.nixosModules.${system}.default
            inputs.nixos-hardware.nixosModules.asus-rog-strix-g533zw
          ]; 
        };
      };
    };
}
