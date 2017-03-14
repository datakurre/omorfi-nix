{ pkgs ? import (builtins.fetchTarball  # revision for reproducible builds
  "https://github.com/nixos/nixpkgs-channels/archive/nixos-16.09.tar.gz") {}
, pythonPackages ? pkgs.python3Packages
, hfst ? import ../pyhfst { pkgs = pkgs; }
, omorfi ? import ../omorfi { pkgs = pkgs; pyhfst = hfst; }
}:

with pkgs;

pythonPackages.buildPythonPackage rec {
  version = "20161115";
  name = "omorfi-${version}";

  src = fetchurl {
    url = "https://github.com/flammie/omorfi/archive/20161115.tar.gz";
    sha256 = "1500d65ab50dac1b1ce29fdf683dfd344d584ed15a40d5ae2d5d720fadba4827";
  };

  prePatch = ''
    cd src/python
    cat > setup.py << EOL
# -*- coding: utf-8 -*-
from setuptools import setup
setup(
    name='omorfi',
    version='${version}',
    license='GPL version 3',
    zip_safe=False,
    packages=['omorfi'],
    install_requires=[
        'setuptools',
    ]
)
EOL
    sed -i -e "s|/usr/share/omorfi/|${omorfi}/share/omorfi/|g" omorfi/omorfi.py
  '';

  doCheck = false;

  propagatedBuildInputs = [
    hfst
    omorfi
  ];
}
