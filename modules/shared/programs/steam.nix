{
  inputs,
  pkgs,
  config,
  ...
}:
{
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs) scummvm inotify-tools;
    inherit (pkgs) winetricks protonplus;
    inherit (pkgs.wineWowPackages) stagingFull;
    # inherit (inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}) wine-discord-ipc-bridge;

  };
  programs = {
    steam = {
      enable = true;
      package = pkgs.unstable.steam;
      protontricks.enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extraCompatPackages = builtins.attrValues {
        inherit (inputs.unstable.legacyPackages.${config.nixpkgs.hostPlatform.system})
          proton-ge-bin
          steamtinkerlaunch
          ;
      };
    };
    gamemode = {
      enable = true;
      enableRenice = true;
      settings.custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
  environment.sessionVariables = rec {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = [
      "\${HOME}/.steam/root/compatibilitytools.d:${pkgs.proton-ge-bin}"
    ];
  };
}
