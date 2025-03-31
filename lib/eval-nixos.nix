{ pkgs, lib }:

configuration:

import "${pkgs.path}/nixos/lib/eval-config.nix" {
  system = null; # set modularly in ../boards

  modules = [
    {
      imports = [
        <board>
      ] ++ import ../modules/module-list.nix;
    }
  ] ++ (if builtins.isList configuration then configuration else [ configuration ]);

  inherit lib;
}
