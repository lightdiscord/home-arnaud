self: super:

let
  nixos-unstable = import <nixos-unstable> { };
in {
  alacritty = nixos-unstable.alacritty;
}
