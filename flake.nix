# 💫 https://github.com/JaKooLit 💫 #

{
  description = "Michael Hess's NixOS-Hyprland"; 
  	
  inputs = {
  	nixpkgs.url = "nixpkgs/nixos-unstable";
	  # hyprland.url = "github:hyprwm/Hyprland"; # hyprland development
	  distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
	  nixos-hardware.url = "github:nixos/nixos-hardware/master";
	  ags.url = "github:aylur/ags/v1"; # aylurs-gtk-shell-v1
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
            inputs.distro-grub-themes.nixosModules.${system}.default
            inputs.nixos-hardware.nixosModules.asus-rog-strix-g533zw
          ]; 
        };
      };
    };
}
