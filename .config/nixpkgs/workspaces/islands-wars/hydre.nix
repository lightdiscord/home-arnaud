{ config, pkgs, ... }:

{
    networking.firewall.allowedTCPPorts = [ 15672 5672 ];
    services.rabbitmq = {
        enable = true;
        listenAddress = "127.0.0.3";
    };
}