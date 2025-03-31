{ pkgs, lib }:
rec {
  importWith =
    autoArgs: fn: args:
    let
      f = if lib.isFunction fn then fn else import fn;
      auto = builtins.intersectAttrs (lib.functionArgs f) autoArgs;
      origArgs = auto // args;
    in
    f origArgs;

  callPackage' = importWith pkgs;
}
