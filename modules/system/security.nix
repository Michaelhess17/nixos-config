{config, pkgs, lib, ...}:
security.sudo.extraRules = [{
    users = [ "michael" ];
    commands = [
    {
      command = "/run/current-system/sw/bin/nixos-rebuild switch";
      options = [ "NOPASSWD" ];
    }
    {
      command = "/run/wrappers/bin/ip netns exec vpnns *";
      options = [ "NOPASSWD" ];
    }
   ];
  }];
}
