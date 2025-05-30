# based on 💫 https://github.com/JaKooLit 💫 #
{ config, pkgs, username, lib, inputs, host, system, ... }:

let
  inherit (import ./variables.nix) gitUsername;
in
# let
#   home-manager = builtins.fetchTarball {
#     url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
#     sha256 = "sha256:13nz5pp9crl03r4zcj43jd9lyxabyl5lp7wzrkfnv82916prfj5m";
#   };
# in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  users = {
    users."${username}" = {
      isNormalUser = true;
      homeMode = "755";
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video"
        "input"
        "audio"
      ];
    };

    defaultUserShell = pkgs.zsh;
  };
  
  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [ fzf ];

  home-manager = {
    backupFileExtension = ".bkp";
    useUserPackages = true;
    useGlobalPkgs = false;
    extraSpecialArgs = {inherit inputs username host system;};

    users."${username}" = { pkgs, ... }: {
      imports = [ ../../modules/packages ];
      home = {
        packages = [ ];
        username = "${username}";
        homeDirectory = "/home/${username}";
        stateVersion = "24.11";
      };
      programs = {
        # Zsh configuration
        zsh = {
          enable = true;
          enableCompletion = true;
          oh-my-zsh = {
            enable = true;
            plugins = [ "git" ];
            # custom = with pkgs; [ pkgs.zsh-fzf-tab ];
            theme = "xiong-chiamiov-plus";
          };

          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;

          initContent = ''
            fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc
            # source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
          
            source <(fzf --zsh);
            HISTFILE=~/.zsh_history;
            HISTSIZE=10000;
            SAVEHIST=10000;
            setopt appendhistory;

            source ~/.computer_ips
            alias config='/run/current-system/sw/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
            alias icat='kitten icat'
            export OPENAI_API_KEY=$(cat ~/.openai_key)
          '';
        };
      };
    };
    # The state version is required and should stay at the version you
    # originally installed.
  };
  nix.settings.allowed-users = ["${username}"];
}
