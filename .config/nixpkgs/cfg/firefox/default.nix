{ ... }:

let
    pkgs = import ../../pkgs;
    
    firefox = pkgs.latest.firefox-nightly-bin;
in {
    home.file = {
        ".mozilla/firefox/lr4gztxt.default/chrome/userChrome.css".source = ./userChrome.css;
    };

    home.packages = [ firefox ];
}