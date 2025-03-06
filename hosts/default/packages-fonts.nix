# 💫 https://github.com/JaKooLit 💫 #
# Packages and Fonts config

{ pkgs, inputs, ...}: let

    python-packages = pkgs.python3.withPackages (
    ps:
    with ps; [
        requests
        pyquery # needed for hyprland-dots Weather script
        ]
    );

    in {
        environment.systemPackages = (with pkgs; [
        # System Packages
        baobab
        btrfs-progs
        clang
        curl
        cpufrequtils
        duf
        eza
        ffmpeg   
        glib #for gsettings to work
        gsettings-qt
        git
        killall  
        libappindicator
        libnotify
        openssl #required by Rainbow borders
        pciutils
        neovim
        vim
        wget
        xdg-user-dirs
        xdg-utils
        
        (mpv.override {scripts = [mpvScripts.mpris];}) # with tray
        # Hyprland Stuff
        ags # note: defined at flake.nix to download and install ags v1    
        brightnessctl # for brightness control
        btop
        cava
        cliphist
        eog
        fastfetch
        gnome-system-monitor
        grim
        gtk-engine-murrine #for gtk themes
        hyprcursor # requires unstable channel
        hypridle # requires unstable channel
        imagemagick 
        inxi
        jq
        kdePackages.qt6ct
        kdePackages.qtstyleplugin-kvantum #kvantum
        kdePackages.qtwayland
        kitty
        libsForQt5.qt5ct
        libsForQt5.qtstyleplugin-kvantum #kvantum
        networkmanagerapplet
        nvtopPackages.panthor
        nwg-look # requires unstable channel
        pamixer
        pavucontrol
        playerctl
        polkit_gnome
        pyprland
        rofi-wayland
        slurp
        swappy
        swaynotificationcenter
        swww
        unzip
        wallust
        wl-clipboard-rs
        wlogout
        xarchiver
        yad
        yt-dlp
    
    	# My packages
    	brave
    	cava
    	cifs-utils
    	code-cursor
    	cura-appimage
    	feh
		hugo
    	julia_110
    	libreoffice
    	librewolf
    	mosh
    	nodejs_22
    	openconnect_openssl
    	pixi
    	python312
    	ranger
    	realvnc-vnc-viewer
    	rsync
    	slack
    	steam-run
    	thunderbird
    	tmux 
    	xfce.thunar 
    	zoom-us
        
        # Penetration testing
        aircrack-ng
        bettercap
    	burpsuite
        ffuf
        gobuster
        hashcat
        hydra
        metasploit
    	nmap
        proxychains
        responder
        sqlmap
    	wireshark

    ]) ++ [
    	  python-packages
      ];
    
      # FONTS
      fonts.packages = with pkgs; [
        # (nerdfonts.override {fonts = ["JetBrainsMono"];}) # stable banch
        fira-code
        font-awesome
        jetbrains-mono
        nerd-fonts.fira-code # unstable
        nerd-fonts.jetbrains-mono # unstable
        noto-fonts
        noto-fonts-cjk-sans
        terminus_font
     	];
      }

