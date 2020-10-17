{ pkgs, ... }:

{
  home.file.".config/htop/htoprc".source = ./htoprc;
  home.packages = [ pkgs.htop ];
}
