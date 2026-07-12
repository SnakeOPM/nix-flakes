{
  hostname,
  lib,
  pkgs,
  ...
}:
{
  networking = {
    networkmanager.enable = true;
    hostName = hostname;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        #xdebug
        9003
        # HTTP
        80
        # HTTPS
        443
        10800
        57255
      ];
    };
  };
  services.openssh = {
    enable = true;
    allowSFTP = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = true; # Set to false later if you want to use strictly SSH Keys
      PermitRootLogin = "no"; # Recommended for security
    };
    listenAddresses = [
      {
        addr = "0.0.0.0";
        port = 57255;
      }
      {
        addr = "[::]";
        port = 57255;
      }
    ];

  };

  services.cloudflare-warp = {
    enable = true;
    package = pkgs.unstable.cloudflare-warp;
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;
}
