{
  hostname,
  path,
  nix-homebrew,
  homebrew-core,
  homebrew-cask,
  ...
}:
let
  importModule =
    moduleName:
    let
      dir = path + "/modules/${hostname}";
    in
    import (dir + "/${moduleName}");
  hostModules = moduleDirs: builtins.concatMap importModule moduleDirs;
in
{
  imports = [
    ./system.nix
    ./brew.nix
    ### ----------------ESSENTIAL------------------- ###
    (path + "/modules/shared/settings/nix.nix")
    ### ----------------ESSENTIAL------------------- ###
    ### ----------------DESKTOP------------------- ###
    (path + "/modules/shared/desktop/fonts.nix")
    ### ----------------DESKTOP------------------- ###
  ]
  ++ hostModules [
    "environment"
    "networking"
  ];
  system.primaryUser = "umplida";

  programs = {
    gnupg.agent = {
      enable = true;
    };
  };

  system.stateVersion = 5;
}
