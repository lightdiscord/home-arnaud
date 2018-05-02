{ pkgs, package, lib, ... }:

{
    lock = pkgs.writeScript "lock.sh" ''
        #!${pkgs.bash}/bin/bash

        cd $(mktemp -d)
        ${pkgs.imagemagick}/bin/import -window root 'bg.png'
        ${pkgs.imagemagick}/bin/convert 'bg.png' -filter Gaussian -blur 0x8 'bg.png'
        ${pkgs.i3lock}/bin/i3lock -i 'bg.png'
        rm 'bg.png'
    '';

    screenshot = { mode ? "select", ... }:
        let 
            package = "${pkgs.imagemagick}/bin/import";
            scripts = {
                select = ''
                    ${package} $(date +"$BASE/%F_%T.jpg")
                '';

                window = ''
                    ID=`${pkgs.xorg.xwininfo}/bin/xwininfo | grep 'id: 0x' | grep -Eo '0x[a-z0-9]+'`
                    ${package} -window $ID $(date +"$BASE/%F_%T_window.jpg")
                '';
            };
        in pkgs.writeScript "screenshot.sh" ''
            #!${pkgs.bash}/bin/bash

            BASE="${builtins.getEnv "HOME"}/Pictures/Screenshots"
            mkdir -p $BASE
            ${scripts.${mode}}
        '';

    random = { move ? false, min ? 11, max ? 99, ... }:
        pkgs.writeScript "random.sh" ''
            #!${pkgs.bash}/bin/bash

            random=`shuf -i ${toString min}-${toString max} -n 1`
            ${lib.optionalString move "i3-msg move container to workspace number $random"}
            i3-msg workspace number $random
        '';
}