{ config, lib, pkgs, ... }:

{
    home.packages = [
        (pkgs.callPackage ../pkgs/netflix.nix {})
    ];
}