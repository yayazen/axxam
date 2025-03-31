let
  npins = import ./npins;
in
{
  pkgs ? import npins.nixpkgs { },
}:
let
  pkgs' = pkgs.extend (
    self: super: {
      lib = super.lib.extend (_: __: 
        import ./lib { inherit (self) pkgs lib; }
      );
    }
  );
in
pkgs'.callPackage <output> { }
