{ pkgs, ... }:
{
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      home-manager
      pay-respects
      kitty
      swww
      ;
  };
  programs = {
    droidcam.enable = true;
  };

}
