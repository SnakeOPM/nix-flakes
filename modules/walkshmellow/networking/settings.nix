{
  hostname,
  ...
}:
{
  services.tailscale = {
    enable = true;
    # overrideLocalDns = true;
  };
}
