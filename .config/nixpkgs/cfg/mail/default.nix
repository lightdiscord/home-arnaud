{ pkgs, ... }:

{
    home.packages = with pkgs; [
        libsecret
        protonmail-bridge
        thunderbird
    ];

    services.gnome-keyring = {
        enable = true;
        components = ["secrets"];
    };

    # systemd.user.services.protonmail-bridgeee = {
    #     Unit = {
    #         Description = "Protonmail Bridge";
    #     };

    #     Service = {
    #         Type = "simple";
    #         # TODO: Find a better way
    #         ExecStart = "${pkgs.screen}/bin/screen -Dm ${pkgs.bash} -c \"sleep 5; ${pkgs.protonmail-bridge}/bin/protonmail-bridge -c\"";
    #         Restart = "always";
    #     };

    #     Install = {
    #         WantedBy = ["default.target"];
    #     };
    # };
}
