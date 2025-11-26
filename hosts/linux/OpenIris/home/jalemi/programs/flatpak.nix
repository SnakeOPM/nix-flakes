{ inputs, ... }:
{
  imports = [
    inputs.flatpaks.homeModules.default
  ];
  services.flatpak = {
    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    };
    overrides = {
      "sh.ppy.osu" = {
        filesystems = {
          "/mnt/bluegum/osu!" = "rw";
        };
      };
    };
    packages = [
      "flathub:app/sh.ppy.osu/x86_64/stable"
      "flathub:app/org.kde.kritax/x86_64/stable"
    ];
  };
}
