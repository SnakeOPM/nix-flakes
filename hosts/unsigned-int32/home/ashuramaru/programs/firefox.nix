{
  lib,
  config,
  pkgs,
  nur,
  ...
}:
{
  imports = [ nur.hmModules.nur ];
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
    profiles.default = {
      id = 0;
      name = "main";
      isDefault = true;
      settings = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
      extensions = with config.nur.repos.rycee.firefox-addons; [
        # necessity
        ublock-origin
        privacy-badger
        canvasblocker
        mullvad
        darkreader
        tampermonkey
        facebook-container

        # bypass-paywalls-clean
        clearurls
        user-agent-string-switcher
        web-archives

        # devtools
        #!!! not available
        # angular-devtools
        react-devtools
        reduxdevtools
        vue-js-devtools

        # utils
        multi-account-containers
        sponsorblock
        return-youtube-dislikes
        video-downloadhelper
        plasma-integration
        stylus
        steam-database
        search-by-image
        foxyproxy-standard
        bitwarden
        firefox-translations
        floccus
        tabliss
        old-reddit-redirect
        reddit-enhancement-suite

        # Dictionaries
        ukrainian-dictionary
      ];
      search = {
        force = true;
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "Nix Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nq" ];
          };
          "NixOS Wiki" = {
            urls = [ { template = "https://nixos.wiki/index.php?search={searchTerms}"; } ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nw" ];
          };
          "SearXNG" = {
            urls = [ { template = "https://searx.org/search?q={searchTerms}"; } ];
            iconUpdateURL = "https://searx.org/static/themes/simple/img/favicon.svg?ee99f2c4793c32451062177672c8ab309dbef940";
            updateInterval = 7 * 24 * 60 * 60 * 1000;
            definedAliases = [ "@sex" ];
          };
          "Ecosia" = {
            urls = [ { template = "https://www.ecosia.org/search?q={searchTerms}"; } ];
            iconUpdateURL = "https://cdn-static.ecosia.org/static/icons/favicon.ico";
            updateInterval = 7 * 24 * 60 * 60 * 1000;
            definedAliases = [ "@eco" ];
          };
          "Start Page" = {
            urls = [ { template = "https://www.startpage.com/sp/search?query={searchTerms}"; } ];
            iconUpdateURL = "https://www.startpage.com/sp/cdn/favicons/favicon--dark.ico";
            updateInterval = 7 * 24 * 60 * 60 * 1000;
            definedAliases = [ "@start" ];
          };
          "SteamDB" = {
            urls = [ { template = "https://steamdb.info/search/?a=app&q={searchTerms}"; } ];
            iconUpdateURL = "https://steamdb.info/static/logos/512px.png";
            updateInterval = 7 * 24 * 60 * 60 * 1000;
            definedAliases = [ "@steamdb" ];
          };
          "ProtonDB" = {
            urls = [ { template = "https://www.protondb.com/search?q={searchTerms}"; } ];
            iconUpdateURL = "https://www.protondb.com/sites/protondb/images/favicon.ico";
            updateInterval = 7 * 24 * 60 * 60 * 1000;
            definedAliases = [ "@protondb" ];
          };
          "Youtube" = {
            urls = [ { template = "https://youtube.com/search?q={searchTerms}"; } ];
            iconUpdateURL = "https://www.youtube.com/s/desktop/5d5de6d9/img/favicon.ico";
            updateInterval = 7 * 24 * 60 * 60 * 1000;
            definedAliases = [
              "@yt"
              "@youtube"
            ];
          };
          "YoutubeMusic" = {
            urls = [ { template = "https://music.youtube.com/search?q={searchTerms}"; } ];
            iconUpdateURL = "https://www.youtube.com/s/desktop/5d5de6d9/img/favicon.ico";
            updateInterval = 7 * 24 * 60 * 60 * 1000;
            definedAliases = [
              "@ytm"
              "@ym"
            ];
          };
        };
        default = "Ecosia";
      };
    };
  };
}
