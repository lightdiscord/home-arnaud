{
  nixpkgs.overlays = [
    (import ./unstable.nix)
    (import ./custom.nix)
  ];
}
