{
  config,
  pkgs,
  lib,
  system,
  ...
}:
let
  isLinux = builtins.elem system [
    "x86_64-linux"
    "aarch64-linux"
  ];
in
{
  # Define options for fontdir program
  options.programs.fontdir = {
    enable = lib.mkEnableOption "Enable fontdir";
  };

  # Configuration settings
  config = {
    # Conditionally enable fonts.fontDir based on the option
    fonts.fontDir.enable = lib.mkIf config.programs.fontdir.enable true;

    # Define fonts packages
    fonts.packages =
      builtins.attrValues {
        mplus = pkgs.mplus-outline-fonts.githubRelease;
        inherit (pkgs)
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-cjk-serif
          noto-fonts-emoji
          agave
          anonymousPro
          liberation_ttf
          terminus_font
          ubuntu_font_family
          roboto
          roboto-mono
          powerline-symbols
          source-han-sans
          wqy_zenhei
          ipafont
          monocraft
          migmix
          iosevka
          inconsolata-lgc
          cascadia-code
          source-code-pro
          font-awesome
          recursive
          ;
      }
      ++ [
        pkgs.nerd-fonts.fira-code
        pkgs.nerd-fonts.agave
        pkgs.nerd-fonts.dejavu-sans-mono
        pkgs.nerd-fonts.fira-mono
        pkgs.nerd-fonts.hack
        pkgs.nerd-fonts.inconsolata
        pkgs.nerd-fonts.iosevka
        pkgs.nerd-fonts.jetbrains-mono
        pkgs.nerd-fonts.inconsolata-lgc
        pkgs.nerd-fonts.meslo-lg
        pkgs.nerd-fonts.mononoki
        pkgs.nerd-fonts.noto
      ];
    programs.fontdir.enable = isLinux;
  };
}
