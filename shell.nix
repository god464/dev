{ inputs, ... }:
{
  imports = with inputs; [
    treefmt-nix.flakeModule
    git-hooks-nix.flakeModule
  ];
  perSystem =
    { config, pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          config.treefmt.build.wrapper
          nil
          nixd
          nixfmt-rfc-style
          statix
          deadnix
        ];
      };
      treefmt = {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
      };
      pre-commit.settings.hooks = {
        deadnix.enable = true;
        statix.enable = true;
        commitizen.enable = true;
        treefmt.enable = true;
      };
    };
}
