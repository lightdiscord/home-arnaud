{ stdenv, lib, fetchurl, makeWrapper, atomEnv, ... }:

let
    name = "mailspring";
    version = "1.2.2";
in stdenv.mkDerivation {
    name = "${name}-${version}";

    src = fetchurl {
        url = "https://github.com/Foundry376/Mailspring/releases/download/${version}/${name}-${version}-amd64.deb";
        sha256 = "0ba9irq7myrbfci9jvgb0jpg7m32jl6vw084ixxh3yysrx6080n4";
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

        # cp -R usr/share/mailspring/{locales,mailspring,resources,libnode.so,libffmpeg.so} $out/lib
        cp -R usr/share/mailspring/* $out/lib
        ln -s $out/lib/mailspring $out/bin/mailspring
    '';

    preFixup = let
        libPath = builtins.concatStringsSep ":" [
            atomEnv.libPath
            (lib.makeLibraryPath [
                stdenv.cc.cc.lib
                "$out"
            ])
            "$out/lib/resources/app.asar.unpacked"
        ];
    in ''
        patchelf \
            --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
            --set-rpath "${libPath}" \
            $out/lib/mailspring

        patchelf \
            --set-rpath "${libPath}" \
            $out/lib/libnode.so

        patchelf \
            --set-rpath "${libPath}" \
            $out/lib/libffmpeg.so

        patchelf \
            --set-rpath "${libPath}" \
            $out/lib/resources/app.asar.unpacked/node_modules/keytar/build/Release/keytar.node

        patchelf \
            --set-rpath "${libPath}" \
            $out/lib/resources/app.asar.unpacked/mailsync.bin

        echo "${libPath}"
    '';
}
