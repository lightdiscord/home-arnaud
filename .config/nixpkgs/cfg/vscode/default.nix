{ nixpkgs, pkgs, lib, ... }:

let
    theme = "Material Theme Ocean High Contrast";

    config = {
        "window.menuBarVisibility" = "toggle";
        "git.confirmSync" = false;
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.colorTheme" = theme;
        "material-icon-theme.folders.theme" = "specific";
        "rust-client.rustupPath" = "${pkgs.rustup}/bin/rustup";
    };

    extensions = with (pkgs.callPackage ./extensions.nix { }); [
        bbenoist.nix
        belfz.search-crates-io
        rust-lang.rust
        tinkertrain.theme-panda
        vscodevim.vim
        PKief.material-icon-theme
        EditorConfig.editorconfig
        bungcip.better-toml
        yzhang.markdown-all-in-one
        Equinusocio.vsc-material-theme
    ];
in {
    home.file = {
        ".config/Code/User/settings.json".text = (builtins.toJSON config);
    };

    home.packages = [
        (pkgs.vscode-with-extensions.override {
            vscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace extensions;
        })
    ];
}