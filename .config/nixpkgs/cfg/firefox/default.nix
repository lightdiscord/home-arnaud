{ pkgs, ... }:

let
    profile = "wh5g275f";
    firefox = pkgs.latest.firefox-nightly-bin;
in {
    home.file = {
        ".mozilla/firefox/${profile}.default/chrome/userChrome.css".source = ./userChrome.css;
    };

    home.packages = [ firefox ];
}
