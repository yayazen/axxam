{ pkgs, lib }:
let
  hostPkgs = pkgs;

  nixos = lib.helpers.evalNixOS (
    { modulesPath, ... }:
    {
      imports = [
        "${modulesPath}/virtualisation/qemu-vm.nix"
      ];

      virtualisation.graphics = false;

      virtualisation.host.pkgs = hostPkgs;

      meta.buildDocsInSandbox = false;
    }
  );
in
nixos.config.system.build.vm
// {
  inherit (nixos) pkgs system config;
}
