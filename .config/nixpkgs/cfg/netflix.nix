{ config, lib, pkgs, ... }:

{
    home.file."bin/netflix" = {
        text = ''
            #!${pkgs.bash}/bin/bash

            ${pkgs.google-chrome}/bin/google-chrome-stable --app="https://netflix.com"
        '';
        executable = true;
    };
}