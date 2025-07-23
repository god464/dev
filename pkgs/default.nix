{ inputs, lib, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.easyOverlay ];
  perSystem =
    { pkgs, config, ... }:
    {
      packages = lib.packagesFromDirectoryRecursive {
        inherit (pkgs) callPackage;
        directory = ./.;
      };
      overlayAttrs = config.packages;
    };
}
