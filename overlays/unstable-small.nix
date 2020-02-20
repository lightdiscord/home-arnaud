self: super:

let
  nixos-unstable-small = import <nixos-unstable-small> { };
in {
  mypaint = nixos-unstable-small.mypaint;
}
