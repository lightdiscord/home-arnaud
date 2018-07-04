{ config, lib, pkgs, ... }:

with lib;

{
  options.xsession.windowManager.i3.modifier = mkOption {
    type = types.str;
    default = "Mod4";
  };
}
