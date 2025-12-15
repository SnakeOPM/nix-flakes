{ pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.libinput = {
    enable = true;
    mouse.accelProfile = "flat";
    mouse.accelSpeed = "0";
  };
  services.desktopManager.plasma6.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
  };
  qt = {
    enable = true;
    style = "breeze";
    platformTheme = "kde";
  };
  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };
  programs.kdeconnect.enable = true;
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs.kdePackages)
      merkuro
      discover
      kcalc
      kcharselect
      kclock
      kcolorchooser
      kolourpaint
      ksystemlog
      sddm-kcm
      isoimagewriter
      partitionmanager
      ;
    inherit (pkgs)
      kdiff3
      catppuccin-kde
      # Non-KDE graphical packages
      hardinfo2
      vlc
      wayland-utils # Wayland utilities
      ;
  };
}
