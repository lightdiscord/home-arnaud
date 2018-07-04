function fetch-github --description "nix-prefetch-github"
    nix-shell -p nix-prefetch-git --run "nix-prefetch-git git@github.com:$argv.git" | nix-shell -p jq --run "jq -r '.sha256'"
end
