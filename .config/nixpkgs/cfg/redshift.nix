{ ... }:

let 
    latitude = "43.643116";
    longitude = "6.875682";
in {
    services.redshift = {
        enable = true;

        inherit latitude longitude;
    };
}