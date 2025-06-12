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
      "50000:50100"
      "443"
    ];
    params = [
      "--filter-udp=50000-50100"
      "--dpi-desync=fake"
      "--dpi-desync-any-protocol"
      "--dpi-desync-repeats=6"
      "--dpi-desync-cutoff=d3"
      "--new"
      "--filter-tcp=443,80"
      "--dpi-desync=fake"
      "--dpi-desync-fooling=badseq"
      "--dpi-desync-repeats=6"
    ];
  };

}
