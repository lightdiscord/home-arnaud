{ callPackage, neovim, nvimPlugins, ... }:

with nvimPlugins;

let
    plugins.start = with languages; [
        nix
        rust
        toml
        fish
    ] ++ (with tools; [
        ale
        ctrlp
        editorconfig
        fugitive
        nerdtree
        header
        airline
    ]) ++ (with theme; [
        airline
        papaya
    ]);

    plugins.opt = with nvimPlugins; [];

    withRuby = true;

    withPython = true;
    extraPythonPackages = [];

    withPython3 = true;
    extraPython3Packages = [];
in neovim.override {
    inherit withRuby withPython extraPythonPackages withPython3 extraPython3Packages;

    configure = {
        customRC = "source ${builtins.getEnv "HOME"}/.config/nvim/init.vim";

        packages.myVimPackage = {
            inherit (plugins) start opt;
        };
    };
}
