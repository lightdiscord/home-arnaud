{ config, pkgs, lib, ... }:

let
    plugins.all = pkgs.callPackage ./all-plugins.nix {};

    plugins.start = with plugins.all; [
        languages.nix
        languages.rust
        tools.ale
        tools.ctrlp
        tools.editorconfig
        tools.fugitive
        theme.perun
    ];

    plugins.opt = with plugins.all; [];
in {
    programs.neovim = {
        enable = true;

        configure = {
            customRC = "source /home/arnaud/.config/nvim/init.vim";

            packages.myVimPackage = {
                inherit (plugins) start opt;
            };
        };
    };
}
