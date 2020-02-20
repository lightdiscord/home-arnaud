{
  nixpkgs.overlays = [
    (import ./unstable-small.nix)
    (import ./unstable.nix)
    (import ./custom.nix)
  ];
}
