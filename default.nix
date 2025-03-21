let
  npins = import ./npins;
in
{
  pkgs ? import npins.nixpkgs { },
}:
pkgs.callPackage <output> { }
