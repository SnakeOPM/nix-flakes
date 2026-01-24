_: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    caskArgs = {
      appdir = "/Applications";
      no_quarantine = true;
      require_sha = true;
    };
    casks = [
      "tunnelblick"
      "lidanglesensor"
      "openlens"
    ];
  };
}
