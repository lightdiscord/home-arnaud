{ ... }:

{
    services.gpg-agent = {
        enable = true;

        defaultCacheTtl = 60;

        enableSshSupport = true;
    };
}
