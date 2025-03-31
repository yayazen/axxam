{ pkgs, lib }:
{
  helpers = {
    inherit (import ./helpers.nix { inherit pkgs lib; })
      importWith
      callPackage'
      ;

    inherit (lib.helpers.callPackage' ./make-cert.nix { })
      mkCert
      ;

    evalNixOS = lib.helpers.callPackage' ./eval-nixos.nix { inherit lib; };
  };
}
