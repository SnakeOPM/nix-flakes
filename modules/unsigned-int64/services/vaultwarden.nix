{
  config,
  pkgs,
  path,
  ...
}:
{
  age.secrets.vaultwarden-env = {
    file = path + /secrets/vaultwarden-env.age;
    path = "/var/lib/secrets/.env";
    mode = "770";
    owner = "vaultwarden";
    group = "vaultwarden";
  };

  age.secrets."vault.htpasswd" = {
    file = path + /secrets/vault.age;
    path = "/var/lib/secrets/vault.htpasswd";
    mode = "0640";
    owner = "nginx";
    group = "nginx";
  };

  services.vaultwarden = {
    enable = true;
    package = pkgs.vaultwarden-postgresql;
    environmentFile = config.age.secrets.vaultwarden-env.path;
    dbBackend = "postgresql";
    config = {
      domain = "https://bitwarden.tenjin-dk.com";
      rocketAddress = "127.0.0.1";
      rocketPort = "8080";
      rocketLog = "critical";

      websocketEnabled = true;
      websocketAddress = "127.0.0.1";
      websocketPort = "3012";
      enableDbWal = true;

      signupsAllowed = false;
      signupsVerify = true;
      signupsDomainsWhitelist = "fumoposting.com, tenjin-dk.com, riseup.net, meanrin.cat, waifu.club";

      smtpHost = "antila.uberspace.de";
      smtpSecurity = "starttls";
      smtpPort = 587;
      smtpAuthMechanism = "Login";
      smtpUsername = "no-reply@cloud.tenjin-dk.com";
      smtpFrom = "no-reply@cloud.tenjin-dk.com";
      smtpFromName = "Admin of bitwarden.tenjin-dk.com";
    };
  };
  services.nginx.upstreams."vaultwarden-default" = {
    extraConfig = ''
      keepalive 2;
    '';
    servers = {
      "127.0.0.1:8080" = {
        backup = false;
      };
    };
  };
  services.nginx.virtualHosts."bitwarden.tenjin-dk.com" = {
    serverName = "bitwarden.tenjin-dk.com";
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://vaultwarden-default";
      proxyWebsockets = true;
      extraConfig = ''
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
      '';
    };
    locations."/admin" = {
      basicAuthFile = config.age.secrets."vault.htpasswd".path;
      proxyPass = "http://vaultwarden-default";
      proxyWebsockets = true;
    };
  };
}
