{ ... }:
{
  nixpkgs.system = builtins.currentSystem;
  system.stateVersion = "25.05";
}
