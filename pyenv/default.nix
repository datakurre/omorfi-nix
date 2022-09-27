with import ../nix {};

let self = {
  pyomorfi = import ../pyomorfi { pkgs = pkgs; };
};

in

python3.buildEnv.override {
  extraLibs = with self; [ pyomorfi ];
  ignoreCollisions = true;
}
