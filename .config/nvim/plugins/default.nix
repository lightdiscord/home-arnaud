{ lib, ... }:

with lib;

(flatten [
    (import ./ale)
    (import ./ctrlp.vim)
    (import ./editorconfig-vim)
    (import ./nerdtree)
    (import ./rust.vim)
    (import ./vim-airline)
    (import ./vim-fish)
    (import ./vim-fugitive)
    (import ./vim-nix)
    (import ./vim-theme-papaya)
    (import ./vim-toml)
])