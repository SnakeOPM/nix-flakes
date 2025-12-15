{ hostname, lib, ... }:
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
      ];
    };
  };
  services.openssh = {
    enable = true;
    allowSFTP = true;
    openFirewall = true;
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
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;
}
