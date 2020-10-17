{ pkgs, ... }:

{
  home.file.".tmux.conf".source = ./tmux.conf;
  home.packages = [ pkgs.tmux ];
}
