{
  inputs,
  pkgs,
  ...
}:
{
  disabledModules = [ "services/networking/zapret.nix" ];
  imports = [
    "${inputs.unstable}/nixos/modules/services/networking/zapret.nix"
  ];
  services.zapret = {
    enable = true;
    package = pkgs.unstable.zapret;
    udpSupport = true;
    udpPorts = [
      "50000:65535"
      "443"
    ];
    params = [
      "--dpi-desync=fake,disorder"
      "--dpi-desync-ttl=2"
      "--dpi-desync-any-protocol"
    ];
  };

}
