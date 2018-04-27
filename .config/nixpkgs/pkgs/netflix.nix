{ stdenv, lib, makeWrapper, makeDesktopItem, google-chrome, bash, writeScript, ... }:

let
    src = writeScript "netflix" ''
        #!${bash}/bin/bash

        ${google-chrome}/bin/google-chrome-stable --app="https://netflix.com"
    '';

    desktop = makeDesktopItem {
        name = "Netflix";
        exec = src;
        comment = "Watch movies and TV shows on your PCe";
        desktopName = "Netflix";
        genericName = "Netflix";
        categories = "Video;Player;AudioVidea;";
    };
in stdenv.mkDerivation rec {
    name = "netflix";

    inherit src;

    buildInputs = [ makeWrapper ];

    unpackPhase = "true";

    installPhase = ''
        mkdir -p "$out/bin"
        ln -s $src $out/bin/netflix

        mkdir -p "$out/share/applications"
        ln -s ${desktop}/share/applications/* $out/share/applications/
    '';
}