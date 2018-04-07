{ channel ? "nightly" }:

let
    overlays = {
        mozilla = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
    };
    nixpkgs = import <nixpkgs> { overlays = [ overlays.mozilla ]; };
in with nixpkgs;
    
stdenv.mkDerivation {
    name = "rust_shell";
    buildInputs = [
        latest.rustChannels.${channel}.rust
    ];
}