function nixsh --description "nix-shell wrapper using fish"
    nix-shell --command fish -p $argv
end