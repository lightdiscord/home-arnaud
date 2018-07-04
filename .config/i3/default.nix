{ config, lib, pkgs, ... }:

with lib;
with builtins;

let
  inherit (pkgs) fetchurl i3-gaps callPackage feh;

  package = i3-gaps;
  modifier = "Mod4";

  wallpapers = imap0 (_: fetchurl) [
    {
      url = "https://i.pinimg.com/originals/e1/ae/22/e1ae225c90cdfafefc2fbff144ff3e01.jpg";
      sha256 = "013wfcw1jzfc38xdlvllf1z8ssb3al37hz0zhjdwir753wph7ib2";
    }
    {
      url = "https://i.imgur.com/bjlCGMv.jpg";
      sha256 = "1nnpb5s1i06c2vdzlzgxvd5xjy6q4ys9ynsmlvwiwad5rjfsrzzj";
    }
  ];

  scripts = callPackage ./scripts.nix {};
in {
  imports = [
    ./config.nix
    ./keybindings.nix

    ~/.config/dunst
    ~/.config/i3status
  ];

  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      inherit package modifier;

      config = {
        fonts = [ "Roboto 10" ];

        floating = {
          criteria = [
            { class = "Pinentry"; }
            { class = "Pavucontrol"; }
          ];

          inherit modifier;
        };

        assigns = {
          "3" = [{ class = "discord"; }];
        };

        window = {
          border = 0;
          titlebar = false;
        };

        bars = [
          { id = "default"; }
        ];

        startup = [
          { command = "${feh}/bin/feh --bg-fill --randomize ${concatStringsSep " " wallpapers}"; always = true; }
        ];
      };
    };
  };

  services.screen-locker = {
    enable = true;
    inactiveInterval = 10;
    lockCmd = "sh ${scripts.lock}";
  };

  services.compton.enable = true;
}
