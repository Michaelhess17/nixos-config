# based on 💫 https://github.com/JaKooLit 💫 #
# Main default config

{ config, pkgs, host, username, options, lib, inputs, system, ...}: let
  
  inherit (import ./variables.nix) keyboardLayout;
    
  in {
  imports = [
    ./hardware.nix
    ./users.nix
    ./packages-fonts.nix
    ../../modules/drivers/nvidia-drivers.nix
    ../../modules/drivers/nvidia-prime-drivers.nix
    ../../modules/drivers/intel-drivers.nix
    ../../modules/drivers/vm-guest-services.nix
    ../../modules/drivers/local-hardware-clock.nix
    ../../modules/system/boot.nix
    inputs.nixvim.nixosModules.nixvim
  ];
 
  # Nvidia driver enable
  drivers.nvidia.enable = true;

  vm.guest-services.enable = false;
  local.hardware-clock.enable = false;

  # networking
  networking.networkmanager.enable = true;
  networking.extraHosts = 
    ''
    '';
  
  networking.hostName = "${host}";
  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

	# Set your time zone.
	time.timeZone = "America/New_York";
	
	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";
	
	i18n.extraLocaleSettings = {
	LC_ADDRESS = "en_US.UTF-8";
	LC_IDENTIFICATION = "en_US.UTF-8";
	LC_MEASUREMENT = "en_US.UTF-8";
	LC_MONETARY = "en_US.UTF-8";
	LC_NAME = "en_US.UTF-8";
	LC_NUMERIC = "en_US.UTF-8";
	LC_PAPER = "en_US.UTF-8";
	LC_TELEPHONE = "en_US.UTF-8";
	LC_TIME = "en_US.UTF-8";
	};

  nixpkgs.config.allowUnfree = true; 

  programs = {
    nixvim.enable = true;
    zsh.enable = true;
	  hyprland = {
      enable = true;
		  #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; #hyprland-git
		  portalPackage = pkgs.xdg-desktop-portal-hyprland;
  	  xwayland.enable = true;
      };

	  waybar.enable = true;
	  hyprlock = {
	  	enable = true;
	  };
	  git = {
	      enable = true;
	      lfs.enable = true;
	  };

    nm-applet.indicator = true; 	
    virt-manager.enable = false;
    
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    
    xwayland.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    
    
    # Allow persistence of dev shells
    direnv.enable = true;
    nix-ld.enable = true;
};
  users = {
    mutableUsers = true;
  };

  # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ]; 
    config.hyprland = {
      "org.freedesktop.impl.portal.ScreenCast" = "hyprland";
    };
  };
  # Supergfxd for Asus laptops
  systemd.services.supergfxcd = {
    path = [ pkgs.pciutils ];
  };
  # Services to start
  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm; # qt6 version
      extraPackages = [pkgs.sddm-astronaut];
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      settings = {
        GreeterEnvironment = {
          QT_SCREEN_SCALE_FACTORS="2.666";
          QT_FONT_DPI="192";
        };
      };
    };
    xserver = {
      enable = true;
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
      }; 
    };

    logind = {
	extraConfig = "HandlePowerKey=suspend";
	lidSwitch = "suspend";
    };    
    
    # Asusd for Asus laptops
    asusd = {
      enable = true;
      enableUserService = true;
    };
    supergfxd = {
      enable = true;
    };
    
    # Run LLMs locally
    ollama = {
	enable = true;
	acceleration = "cuda";
    };
	
    # Expose LLM to local port (11434)
    open-webui.enable = true;

    # System options mainly provided by JaKooLit
    # greetd = {
    #   enable = true;
    #   vt = 3;
    #   settings = {
    #     default_session = {
    #       user = username;
    #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --theme 'border=gray;text=gray;prompt=green;time=gray;action=blue;button=gray;container=black;input=green' --user-menu --asterisks --cmd Hyprland"; # start Hyprland with a TUI login manager
    #     };
    #   };
    # };

    smartd = {
      enable = false;
      autodetect = true;
    };
    
	  gvfs.enable = true;
	  tumbler.enable = true;

	  pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
	    wireplumber.enable = true;
  	  };
	
    #pulseaudio.enable = false; #unstable
	  udev.enable = true;
	  envfs.enable = true;
	  dbus.enable = true;

	  fstrim = {
      enable = true;
      interval = "weekly";
      };
  
    libinput.enable = true;

    rpcbind.enable = false;
    nfs.server.enable = false;
  
    openssh.enable = true;
    flatpak.enable = true;
	
  	blueman.enable = true;
  	
  	#hardware.openrgb.enable = true;
  	#hardware.openrgb.motherboard = "amd";

	  fwupd.enable = true;

	  upower.enable = true;
    
    gnome.gnome-keyring.enable = true;
    
    #printing = {
    #  enable = false;
    #  drivers = [
        # pkgs.hplipWithPlugin
    #  ];
    #};
    
    #avahi = {
    #  enable = true;
    #  nssmdns4 = true;
    #  openFirewall = true;
    #};
    
    #ipp-usb.enable = true;
    
    #syncthing = {
    #  enable = false;
    #  user = "${username}";
    #  dataDir = "/home/${username}";
    #  configDir = "/home/${username}/.config/syncthing";
    #};

  };
  
  systemd.services = {
    flatpak-repo = {
        path = [ pkgs.flatpak ];
        script = ''
          flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        '';
      };
        systemd-logind.environment = {
	  SYSTEMD_BYPASS_HIBERNATION_MEMORY_CHECK = "1";
        };
    };

  # zram
  zramSwap = {
	  enable = true;
	  priority = 100;
	  memoryPercent = 30;
	  swapDevices = 1;
    algorithm = "zstd";
    };

  powerManagement = {
  	enable = true;
	  cpuFreqGovernor = "schedutil";
  };

  #hardware.sane = {
  #  enable = true;
  #  extraBackends = [ pkgs.sane-airscan ];
  #  disabledDefaultBackends = [ "escl" ];
  #};

  # Extra Logitech Support
  hardware.logitech.wireless.enable = false;
  hardware.logitech.wireless.enableGraphical = false;

  # Bluetooth
  hardware = {
  	bluetooth = {
	    enable = true;
	    powerOnBoot = true;
	    settings = {
		    General = {
		      Enable = "Source,Sink,Media,Socket";
		      # https://www.reddit.com/r/NixOS/comments/1ch5d2p/comment/lkbabax/
        	# for pairing bluetooth controller
        	Privacy = "device";
        	JustWorksRepairing = "always";
        	Class = "0x000100";
        	FastConnectable = true;Experimental = true;
		    };
      };
    };
  };
	hardware.xpadneo.enable = true; # Enable the xpadneo driver for Xbox One wireless controllers

   boot = {
     extraModulePackages = with config.boot.kernelPackages; [ xpadneo v4l2loopback ];
     extraModprobeConfig = ''
       options bluetooth disable_ertm=Y
      '';
      # connect xbox controller
    };

  # Enable sound with pipewire.
  # hardware.pulseaudio.enable = false; # replaced with services.pulseaudio 04-Jan-2025


  # Security / Polkit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # Cachix, Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Virtualization / Containers
  virtualisation.libvirtd.enable = false;
  virtualisation.podman = {
    enable = false;
    dockerCompat = false;
    defaultNetwork.settings.dns_enabled = false;
  };
  # virtualisation.vmware.host.enable = true;

  # OpenGL
  hardware.graphics = {
    enable = true;
  };

  console.keyMap = "${keyboardLayout}";

  # For Electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
	
#  fileSystems."/home/michael/Synology" = {
#    device = "//170.140.242.162/volume1/Mouse_Face_Project";
#    fsType = "cifs";
#    options = let
#        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
#    in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=1000"];
#    };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 4382 ];
  # networking.firewall.allowedUDPPorts = [ 4382 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
