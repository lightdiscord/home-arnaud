{ sysconfig ? (import <nixpkgs/nixos> {}).config, ... }:

sysconfig // {
	xserver = sysconfig.services.xserver.enable;
}
