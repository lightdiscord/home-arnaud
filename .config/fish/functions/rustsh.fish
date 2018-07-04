function rustsh --description "nixsh with rust"
    nix-shell ~/.config/nixpkgs/shells/rustsh.nix --command fish
end