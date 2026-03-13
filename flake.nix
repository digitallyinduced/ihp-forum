{
    inputs = {
        ihp.url = "github:digitallyinduced/ihp";
        nixpkgs.follows = "ihp/nixpkgs";
        flake-parts.follows = "ihp/flake-parts";
        devenv.follows = "ihp/devenv";
        systems.follows = "ihp/systems";
        devenv-root = {
            url = "file+file:///dev/null";
            flake = false;
        };
    };

    outputs = inputs@{ self, nixpkgs, ihp, flake-parts, systems, ... }:
        flake-parts.lib.mkFlake { inherit inputs; } {

            systems = import systems;
            imports = [ ihp.flakeModules.default ];

            perSystem = { pkgs, ... }: {
                ihp = {
                    appName = "forum";
                    enable = true;
                    projectPath = ./.;
                    static.makeBundling = false;
                    packages = with pkgs; [
                    ];
                    haskellPackages = p: with p; [
                        p.ihp
                        p.ihp-mail
                        cabal-install
                        base
                        wai
                        text
                        mmark
                        mmark-ext
                        wreq
                        neat-interpolation
                    ];
                };

                devenv.shells.default = {
                    processes = {
                    };
                };
            };
        };

    nixConfig = {
        extra-substituters = [
            "https://devenv.cachix.org"
            "https://cachix.cachix.org"
            "https://digitallyinduced.cachix.org"
        ];
        extra-trusted-public-keys = [
            "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
            "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
            "digitallyinduced.cachix.org-1:y+wQvrnxQ+PdEsCt91rmvv39qRCYzEgGQaldK26hCKE="
        ];
    };
}
