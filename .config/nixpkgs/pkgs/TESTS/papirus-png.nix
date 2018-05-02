{ stdenv, fetchgitPrivate, gtk3, ... }:

let
    rev = "7a3ead9a3a044b3495621e709b10fc2bf689c340";
    sha256 = "1cbzv3igc6j05h0mq2850fwfd8sxxwixzgdhh85mc1k326rvncil";
in stdenv.mkDerivation rec {
    name = "papirus-icon-theme-png";

    src = fetchgitPrivate {
        url = "git@github.com:LightDiscord/Papirus-icon-theme-png.git";
        inherit rev sha256;
    };

    nativeBuildInputs = [ gtk3 ];

    installPhase = ''
        echo "DEBUG: [OUT] = $out"
        mkdir -p $out/share/icons
        cp -R {,e}Papirus* $out/share/icons
    '';

    postFixup = ''
        for theme in $out/share/icons/*; do
            gtk-update-icon-cache $theme
        done
    '';
}