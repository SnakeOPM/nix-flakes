{ path, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    shellAliases = {
      sayhi = "echo hii";
    };
    plugins = [
      {
        name = "bump";
        src = path + "/home/umplida/utils/zshrc";
        file = "bump.plugin.zsh";
      }
      {
        name = "mkrelprep";
        src = path + "/home/umplida/utils/zshrc";
        file = "mkrelprep.plugin.zsh";
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "docker"
      ];
      theme = "agnoster";
    };
  };
}
