self: super:

let
  nixos-unstable = import <nixos-unstable> {
    config = { allowUnfree = true; };
  };
in {
  alacritty = nixos-unstable.alacritty;
  protonmail-bridge = nixos-unstable.protonmail-bridge;
  mypaint = nixos-unstable.mypaint;
  steam = nixos-unstable.steam;
}
