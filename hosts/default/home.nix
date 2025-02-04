{ lib, pkgs, ... }:
{

  home = {

    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ ];
    };

    packages = with pkgs; [
      fzf
      oh-my-zsh
      zsh
      kitty
      btop
      pixi
      spotify
      julia_110
      zoom-us
      slack
      librewolf
      nodejs_22
      code-cursor
      eza
      xdg-desktop-portal
      kdePackages.xdg-desktop-portal-kde
      pokemon-colorscripts-mac
      catppuccin-kde
      python312
      gof5
      realvnc-vnc-viewer
    ];

    username = "michael";
    homeDirectory = "/home/michael";

    stateVersion = "24.11";
  };
}
