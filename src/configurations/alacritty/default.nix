{ pkgs, ... }:

{
  home.file.".config/alacritty/alacritty.yml".source = ./alacritty.yml;
  home.packages = [ pkgs.alacritty ];
}
