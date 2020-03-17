{ pkgs, lib, ... }:

{
  require = [ ./configs ./overlays ];

  fonts.fontconfig.enable = true;

  home.keyboard.layout = "fr";

  xsession.enable = true;
  # xsession.windowManager.command = "${pkgs.i3}/bin/i3";
  xsession.windowManager.awesome.enable = true;
  xsession.windowManager.awesome.luaModules = [ pkgs.luaPackages.luafilesystem ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    gnome3.adwaita-icon-theme hicolor-icon-theme
    my-neovim
    mypaint
    protonmail-bridge
    latest.firefox-nightly-bin
  ];

  services.gnome-keyring = {
    enable = true;
    components = ["secrets"];
  };

  gtk.enable = true;
  gtk.iconTheme = {
    package = pkgs.paper-icon-theme;
    name = "Paper";
  };

}
