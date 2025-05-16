{config, pkgs, lib, ...}:
{
boot = {
    kernelPackages = pkgs.linuxPackages_zen; # Kernel

    kernelParams = [
      "systemd.mask=systemd-vconsole-setup.service"
      "systemd.mask=dev-tpmrm0.device" #this is to mask that stupid 1.5 mins systemd bug
      "nowatchdog" 
      "modprobe.blacklist=sp5100_tco" #watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" #watchdog for Intel
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      "nvidia.NVreg_TemporaryFilePath=/var/tmp/" # needed for suspend possibly
 	  ];

    # This is for OBS Virtual Cam Support
    kernelModules = [ "v4l2loopback" ];
    
    initrd = { 
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
      systemd.enable = true;
      kernelModules = [ ];
    };

    resumeDevice = "";
    blacklistedKernelModules = lib.mkForce [
	    "nvidia"
	    "nvidia_modeset"
	    "nvidia_uvm"
	    "nvidia_drm"
    ];

    # Needed For Some Steam Games
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };

    ## BOOT LOADERS: NOT USE ONLY 1. either systemd or grub  
    # Bootloader SystemD
    loader.systemd-boot.enable = true;
  
    loader.efi = {
	    #efiSysMountPoint = "/efi"; #this is if you have separate /efi partition
	    canTouchEfiVariables = true;
  	  };

    loader.timeout = 3;
      
    # Make /tmp a tmpfs
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
      };
    
    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
      };
    
    plymouth.enable = true;
  };
}
