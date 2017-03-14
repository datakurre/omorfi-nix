{ pkgs ? import (builtins.fetchTarball  # revision for reproducible builds
  "https://github.com/nixos/nixpkgs-channels/archive/nixos-16.09.tar.gz") {}
, pythonPackages ? pkgs.python3Packages
, hfst ? import ../hfst { pkgs = pkgs; }
}:

with pkgs;

pythonPackages.buildPythonPackage rec {
  version = "3.12.1";
  name = "hfst-${version}";

  src = fetchurl {
    url = "http://github.com/hfst/hfst/archive/v3.12.1.tar.gz";
    sha256 = "49c11cb7b0faa3b2b8e97f374530be0263f4f1591fcdd9397ab34bb5fe947d26";
  };

  prePatch = ''
    cd python
  '';

  postConfigure = ''
    # create "libhfst.py" already before setup.py call
    swig -python -c++ -I../libhfst/src -Wall -o libhfst_wrap.cpp libhfst.i
  '';

  propagatedBuildInputs = [
    hfst
    swig
  ];
}
