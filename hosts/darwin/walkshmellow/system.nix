_: {
  system = {
    defaults = {
      LaunchServices.LSQuarantine = false; # Disable Quarantine for Downloaded Applications
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
      NSGlobalDomain = {
        NSDocumentSaveNewDocumentsToCloud = false; # Disable auto save text files to iCloud
        NSAutomaticPeriodSubstitutionEnabled = false; # Disable adding . after pressing space twice
        NSAutomaticDashSubstitutionEnabled = false; # Disable "smart" dash substitution
        NSAutomaticQuoteSubstitutionEnabled = false; # No "smart" quote substitution
      };
      finder = {
        AppleShowAllFiles = false; # Show all files
        AppleShowAllExtensions = true; # Show all file extensions
        FXEnableExtensionChangeWarning = false; # Disable Warning for changing extension
        FXPreferredViewStyle = "icnv"; # Change the default finder view. “icnv” = Icon view
        QuitMenuItem = true; # Allow qutting Finder
        ShowPathbar = true; # Show full path at bottom
      };
      dock = {
        autohide = false;
        magnification = false;
        orientation = "bottom";
        show-recents = false; # Show Recently Open
        showhidden = true;
      };
    };
  };
}
