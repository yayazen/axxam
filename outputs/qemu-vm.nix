{ pkgs }:
let
  hostPkgs = pkgs;

  nixos = import "${pkgs.path}/nixos" {
    system = "aarch64-linux";
    configuration =
      { modulesPath, ... }:
      {
        imports = [
          "${modulesPath}/virtualisation/qemu-vm.nix"
          <board>
        ] ++ (import ../modules/module-list.nix);

        virtualisation.graphics = false;

        virtualisation.host.pkgs = hostPkgs;

        meta.buildDocsInSandbox = false;
      };
  };
in
nixos.config.system.build.vm
// {
  inherit (nixos) pkgs system config;
}
