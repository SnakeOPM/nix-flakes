{
  lib,
  inputs,
  self,
  path,
  nixpkgs,
  darwin,
  nur,
  home-manager,
  agenix,
  sops-nix,
  vscode-server,
  catppuccin,
  flatpaks,
  spicetify-nix,
  nixcord,
  nixvim,
  aagl,
  nix-homebrew,
  homebrew-core,
  homebrew-cask,
  ...
}:
let
  systems = import (path + /hosts/mkSystemConfig.nix) {
    ### ----------------FLAKE------------------- ###
    inherit lib;
    inherit inputs self path;
    ### ----------------FLAKE------------------- ###

    ### ----------------SYSTEM------------------- ###
    inherit
      nixpkgs
      darwin
      nur
      nix-homebrew
      homebrew-core
      homebrew-cask
      ;
    inherit home-manager agenix sops-nix;
    inherit vscode-server;
    ### ----------------SYSTEM------------------- ###

    ### ----------------MODULES & OVERLAYS------------------- ###
    inherit catppuccin flatpaks;
    inherit
      spicetify-nix
      nixcord
      nixvim
      aagl
      ;
    ### ----------------MODULES & OVERLAYS------------------- ###
  };
  inherit (systems) mkSystemConfig;
in
{
  unsigned-int8 = mkSystemConfig.darwin {
    hostName = "unsigned-int8";
    system = "aarch64-darwin";
    useHomeManager = true;
    users = [ "ashuramaru" ];
    modules = [ ];
  };
  walkshmellow = mkSystemConfig.darwin {
    hostName = "walkshmellow";
    system = "aarch64-darwin";
    useHomeManager = true;
    users = [ "umplida" ];
    modules = [
      nix-homebrew.darwinModules.nix-homebrew
      {
        nix-homebrew = {
          enable = true;
          enableRosetta = true;
          user = "umplida";
          taps = {
            "homebrew/homebrew-core" = homebrew-core;
            "homebrew/homebrew-cask" = homebrew-cask;
          };
          mutableTaps = false;
        };
      }
      (
        { config, ... }:
        {
          homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
        }
      )
    ];
  };
}
