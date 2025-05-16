{ ... }: { }
# {pkgs, lib, home, host, inputs, ...}:
# let 
#  inherit (import ../../hosts/${host}/variables.nix) system;
#in
# {
  # imports = [
  #   inputs.nixvim.homeManagerModules.nixvim
  # ];
  # home.packages = [
  #  inputs.nvix.packages.${pkgs.system}.core
  # ];
  # programs.nixvim = {
  #   enable = true;
  # };
#}

