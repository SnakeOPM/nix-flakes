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
    (path + /home/shared/programs/spotify.nix)
    ### ----------------PROGRAMS------------------- ###
  ]
  ++ lib.flatten [
    (lib.concatLists [
      (import (path + /home/umplida/dev/default.nix))
      (import (path + /home/umplida/utils/default.nix))
    ])
  ];
  home = {
    packages = builtins.attrValues {
      inherit (pkgs)
        # Media
        spicetify-cli

        # Socials
        thunderbird
        zoom-us
        # libreoffice libreoffice-fresh is better

        # Graphic
        #krita
        qbittorrent
        postman
        autorandr # you should move to a different location
        #spellcheking
        aspell
        sops
        dbeaver-bin
        iterm2
        maccy
        ;

      # Networking/VPN/Proxy
      inherit (pkgs.unstable) telegram-desktop;
    };
    stateVersion = "24.05";
  };
}
