{ ... }:

{
    programs.newsboat = {
        enable = true;
        autoReload = true;
        urls = [
            { tags = [ "commitstrip" ]; url = https://www.commitstrip.com/fr/feed/; }
        ];
    };
}
