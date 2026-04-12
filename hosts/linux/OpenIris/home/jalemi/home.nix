{
  lib,
  pkgs,
  path,
  ...
}:
{
  imports = [
    ### ----------------PROGRAMS------------------- ###
    ./programs/firefox.nix
    ./programs/flatpak.nix
    (path + /home/shared/programs/discord.nix)
    (path + /home/shared/programs/spotify.nix)
    ### ----------------PROGRAMS------------------- ###
  ]
  ++ lib.flatten [
    (lib.concatLists [
      (import (path + /home/jalemi/dev/default.nix))
      (import (path + /home/jalemi/utils/default.nix))
    ])
  ];
  home = {
    packages = builtins.attrValues {
      inherit (pkgs)
        # Media
        vlc

        # Gaming
        bottles
        r2modman

        # Productivity
        libreoffice-fresh
        anki

        # Graphic
        qbittorrent

        autorandr
        monero-gui
        signal-desktop
        ;

      inherit (pkgs.nixpkgs-25_05) hiddify-app nekoray;

      # dev
      inherit (pkgs) php83 phpunit;
      inherit (pkgs.php83Extensions) xdebug;
      inherit (pkgs.php83Packages) composer;
      inherit (pkgs.python312Packages) conda;

      # Networking/VPN/Proxy
      inherit (pkgs.unstable) throne telegram-desktop;
    };
    stateVersion = "24.05";
  };
  programs.nixcord.config.themeLinks = lib.mkForce [
    "https://raw.githubusercontent.com/moistp1ckle/GitHub_Dark/main/source.css"
  ];
}
