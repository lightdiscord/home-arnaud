{
  nixpkgs.overlays = [
    (import ./unstable-small.nix)
    (import ./unstable.nix)
    (import ./nixpkgs-mozilla)
    (import ./custom.nix)
  ];
}
