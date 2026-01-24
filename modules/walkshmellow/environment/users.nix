{ pkgs, ... }:
{
  programs.zsh.enable = true;
  users.users.umplida = {
    home = "/Users/umplida";
    shell = pkgs.zsh;
  };
}
