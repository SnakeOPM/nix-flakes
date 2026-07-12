{ inputs, pkgs, ... }:
let
  inherit (inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}) open-vsx;
in
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      # c/c++

      cmakeCurses
      clang-tools
      gnumake
      # Ruby

      ruby
      # Rust

      rustc
      # Golang

      go
      # Java

      temurin-bin-17
      # Nix

      nil
      nixfmt
      arduino-language-server
      ;
    inherit (pkgs.llvmPackages) libcxxClang;
  };
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = true;
      extensions = builtins.attrValues {
        ## -- Nix Utils -- ##
        nix-lsp = open-vsx.bbenoist.nix;
        nix-ide = open-vsx.jnoortheen.nix-ide;
        direnv = open-vsx.mkhl.direnv;
        ## -- Nix Utils -- ##
      };
    };
  };
  home.sessionVariables = {
    GO_PATH = "$XDG_DATA_HOME/go";
  };
}
