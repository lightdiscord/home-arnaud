{ lib, callPackage, neovim, vimUtils, fetchFromGitHub, ... }:

with lib;

let
    builder = vimUtils.buildVimPluginFrom2Nix;
    build = { owner, repo, rev ? "HEAD", name ? repo, sha256 }: builder {
        inherit name;
        src = fetchFromGitHub {
            fetchSubmodules = true;
            inherit name owner repo rev sha256;
        };
    };
in neovim.override rec {
    configure = {
        customRC = "source ${builtins.getEnv "HOME"}/.config/nvim/init.vim";

        packages.myVimPackage.start = imap0 (_: build) (callPackage ./plugins {});
    };
}
