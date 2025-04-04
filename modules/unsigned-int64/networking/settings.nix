{
  lib,
  config,
  pkgs,
  ...
}: {
  networking = {
    hostName = "unsigned-int64";
    interfaces = {
      "eno1" = {
        name = "eno1";
        useDHCP = lib.mkDefault true;
        ipv4.addresses = [
          {
            address = "176.9.10.47";
            prefixLength = 27;
          }
        ];
        ipv6.addresses = [
          {
            address = "2a01:4f8:141:5330::";
            prefixLength = 64;
          }
          {
            address = "2a01:4f8:141:5330::1";
            prefixLength = 128;
          }
          {
            address = "2a01:4f8:141:5330::2";
            prefixLength = 128;
          }
        ];
      };
    };
    defaultGateway = {
      address = "176.9.10.31";
      interface = "eno1";
    };
    defaultGateway6 = {
      address = "fe80::1";
      interface = "eno1";
    };
    nameservers = [
      "127.0.0.1"
      "::1"
    ];
    nat = {
      enable = true;
      enableIPv6 = true;
      externalInterface = "eno1";
      internalInterfaces = [
        "ve-+"
        "virbr0"
        "wireguard0"
        "wireguard1"
      ];
    };
    hosts = {
      "172.16.31.1" = [
        "www.tenjin.com"
        "prom.tenjin.com"
        "lib.tenjin.com"
        "uptime.tenjin.com"
        "public.tenjin.com"
        "private.tenjin.com"
      ];
      "fd17:216b:31bc:1::1" = [
        "www.tenjin.com"
        "prom.tenjin.com"
        "lib.tenjin.com"
        "uptime.tenjin.com"
        "public.tenjin.com"
        "private.tenjin.com"
      ];
    };
    firewall = {
      enable = true;
      allowedUDPPorts = [
        # Proxy
        1080
        3128
        # Minecraft
        25565
        # Wireguard
        51280
        51820
      ];
      allowedTCPPorts = [
        # HTTP
        80
        # HTTPS
        443
        # Proxy
        1080
        3128
        # minecraft
        25565
        # ssh
        57255
      ];
      interfaces."wireguard1" = {
        allowedUDPPorts = [
          # forward all possible dns ports
          53
          67
          5353
          8053
        ];
        allowedTCPPorts = [
          53
          67
          5353
          8053

          3001
          # prometheus
          9000

          #radarr
          7878
          # sonarr
          8989
          # lidarr
          8686
          # readarr
          8787
          # prowlarr
          9696
          # bazarr
          8763
          # jackett
          9117
          # transmission
          9091
          18765
        ];
      };
    };
  };
  services = {
    openssh = {
      enable = true;
      allowSFTP = true;
      openFirewall = true;
      settings = {
        UseDns = true;
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = true;
        PermitRootLogin = "prohibit-password";
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
        # wireguard1
        {
          addr = "172.16.31.1";
          port = 22;
        }
        {
          addr = "[fd17:216b:31bc:1::1]";
          port = 22;
        }
      ];
    };
    unbound = {
      enable = true;
      enableRootTrustAnchor = true;
      resolveLocalQueries = true;
      settings = {
        server = {
          verbosity = 2;
          interface = [
            "127.0.0.1"
            "::1"
            "172.16.31.1"
            "fd17:216b:31bc:1::1"
          ];
          do-ip4 = "yes";
          do-ip6 = "yes";
          do-udp = "yes";
          do-tcp = "yes";
          harden-glue = "yes";
          harden-dnssec-stripped = "yes";
          edns-buffer-size = 1232;
          prefetch = "yes";
          prefetch-key = "yes";
          num-threads = "2";
          hide-identity = "yes";
          identity = "\"static.unsigned-int64.your-server.de\"";
          access-control = [
            "127.0.0.0/8 allow"
            "172.16.0.0/12 allow"
            "fd00::/8 allow"
            "fd17::/16 allow"
            "fe80::/10 allow"
          ];
          private-domain = [
            "remote.tenjin-dk.com."
            "remote.fumoposting.com."
          ];
          private-address = [
            "10.0.0.0/8"
            "172.16.0.0/12"
            "fd00::/8"
            "fd17::/16"
            "fe80::/10"
          ];
          local-zone = [
            "\"internal.com.\" static"
            "\"172.in-addr.arpa.\" static"
            "\"tenjin.com.\" static"
          ];
          local-data = [
            "\"internal.com. 10800 IN NS ns1.internal.com.\""
            "\"internal.com. 10800 IN SOA ns1.internal.com. admin@cloud.tenjin-dk.com. 1 3600 1200 604800 10800\""
            "\"internal.com. 10800 IN A 172.16.31.1\""
            "\"internal.com. 10800 IN AAAA fd17:216b:31bc:1::1\""
            "\"ns1.internal.com. 10800 IN A 172.16.31.1\""
            "\"ns1.internal.com. 10800 IN AAAA fd17:216b:31bc:1::1\""

            "\"172.in-addr.arpa. 10800 IN NS internal.com.\""
            "\"172.in-addr.arpa. 10800 IN SOA internal.com. admin@cloud.tenjin-dk.com. 2 3600 1200 604800 10800\""
            "\"1.31.16.172.in-addr.arpa. 10800 IN PTR internal.com.\""

            "\"tenjin.com. 10800 IN NS ns1.internal.com.\""
            "\"tenjin.com. 10800 IN SOA ns1.internal.com. admin@cloud.tenjin-dk.com. 1 3600 1200 604800 10800\""
            "\"tenjin.com. 10800 IN A 172.16.31.1\""
            "\"tenjin.com. 10800 IN AAAA fd17:216b:31bc:1::1\""
            "\"www.tenjin.com. 10800 IN CNAME tenjin.com.\""
            "\"prom.tenjin.com. 10800 IN CNAME www.tenjin.com.\""
            "\"lib.tenjin.com. 10800 IN CNAME www.tenjin.com.\""
            "\"uptime.tenjin.com. 10800 IN CNAME www.tenjin.com.\""
            "\"public.tenjin.com. 10800 IN CNAME www.tenjin.com.\""
            "\"private.tenjin.com. 10800 IN CNAME www.tenjin.com.\""
          ];
        };
        forward-zone = [
          {
            name = ".";
            forward-addr = [
              "1.1.1.1@853#cloudflare-dns.com"
              "1.0.0.1@853#cloudflare-dns.com"
              "2606:4700:4700::1111@853#cloudflare-dns.com"
              "2606:4700:4700::1001@853#cloudflare-dns.com"
            ];
            forward-tls-upstream = "yes";
          }
        ];
        remote-control = {
          control-enable = true;
          control-interface = [
            "127.0.0.1"
            "::1"
            "172.16.31.1"
            "fd17:216b:31bc:1::1"
          ];
          control-port = 8953;
        };
      };
    };
    # local-data-ptr = [
    #   "1.31.16.172.in-addr.arpa unsigned-int64.remote"
    # ];
    # local-data = [
    #   # A/AAAA records
    #   "unsigned-int64.remote IN A 172.16.31.1 3600"
    #   "unsigned-int64.remote IN AAAA fd17:216b:31bc:1::1 3600"

    #   # CNAME
    #   "prom.tenjin-dk.com IN CNAME unsigned-int64.remote 3600"
    #   "lib.tenjin-dk.com IN CNAME unsigned-int64.remote 3600"
    #   "private.tenjin-dk.com IN CNAME unsigned-int64.remote 3600"
    #   "public.tenjin-dk.com IN CNAME unsigned-int64.remote 3600"

    #   # PTR records
    #   "1.31.16.172.in-addr.arpa. IN PTR static.1.31.16.172.internal.unsigned-int64.com. 3600"
    # ];
  };
}
