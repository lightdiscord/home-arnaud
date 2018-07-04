{ stdenv, fetchurl, lib, qt5, libsecret, libpulseaudio, glib, makeWrapper, ... }:

let
    name = "protonmail-bridge";
    version = "1.0.4-1";
in stdenv.mkDerivation {
    name = "${name}-${version}";

    src = fetchurl {
        url = "https://protonmail.com/download/protonmail-bridge_${version}_amd64.deb";
        sha256 = "03m130x5vysja1dgxv3gs1jwf1fn50aanj7x06ynjflw0s3c8bq3";
    };

    sourceRoot = ".";
    unpackCmd = ''
        ar p "$src" data.tar.xz | tar xJ
    '';

    buildPhase = ":";

    buildInputs = [ makeWrapper ];

    dontPatchELF = true;
    dontStrip = true;

    installPhase = ''
        mkdir -p $out/bin $out/lib

        cp -R usr/lib/protonmail/bridge/{Desktop-Bridge,plugins} $out/lib
        ln -s $out/lib/Desktop-Bridge $out/bin/protonmail-bridge
    '';

    preFixup = let
        packages = [
            qt5.qtbase
            qt5.qtsvg
            qt5.qtmultimedia
            qt5.qtdeclarative
            qt5.qttools
            qt5.qtquickcontrols
            libsecret
            libpulseaudio
            glib
            stdenv.cc.cc.lib
        ];

        libPath = lib.makeLibraryPath packages;
        qmlPath = "${qt5.full}/lib/qt-5.10/qml";
    in ''
        patchelf \
            --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
            --set-rpath "${libPath}" \
            $out/lib/Desktop-Bridge

        wrapProgram $out/lib/Desktop-Bridge \
            --set QT_PLUGIN_PATH "$out/lib/plugins" \
            --set QML_IMPORT_PATH "${qmlPath}" \
            --set QML2_IMPORT_PATH "${qmlPath}"
    '';
}
