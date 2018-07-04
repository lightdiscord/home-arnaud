{ config, pkgs, lib, ... }:

with lib;

let
  inherit (config.xsession.windowManager.i3) package;
  inherit (pkgs) bash scrot imagemagick i3lock xorg writeScript;
in {
  lock = writeScript "lock" ''
    #!${bash}/bin/bash

    IMAGE=/tmp/i3lock.png

    ${scrot}/bin/scrot $IMAGE
    ${imagemagick}/bin/convert $IMAGE -filter Gaussian -blur 0x8 $IMAGE
    ${i3lock}/bin/i3lock -i $IMAGE

    rm $IMAGE
  '';

  screenshot = { mode ? "select", ... }:
    let 
      package = "${imagemagick}/bin/import";
      scripts = {
        select = ''
          ${package} $(date +"$BASE/%F_%T.jpg")
        '';

        window = ''
          ID=`${xorg.xwininfo}/bin/xwininfo | grep 'id: 0x' | grep -Eo '0x[a-z0-9]+'`
          ${package} -window $ID $(date +"$BASE/%F_%T_window.jpg")
        '';
      };
    in writeScript "screenshot.sh" ''
      #!${bash}/bin/bash

      BASE=~/Pictures/Screenshots
      mkdir -p $BASE
      ${scripts.${mode}}
    '';

  random = { move ? false, min ? 11, max ? 99, ... }:
    writeScript "random.sh" ''
      #!${bash}/bin/bash

      random=`shuf -i ${toString min}-${toString max} -n 1`
      ${optionalString move "i3-msg move container to workspace number $random"}
      i3-msg workspace number $random
    '';
}
