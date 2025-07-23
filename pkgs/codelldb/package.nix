{ stdenv, pkgs, ... }:
stdenv.mkDerivation {
  pname = "codelldb";
  inherit (pkgs.vscode-extensions.vadimcn.vscode-lldb) version meta;

  src = ./.;

  dontUnpack = true;
  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    mkdir -p $out/bin
    cp -r ${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/* $out/bin
    chmod +x $out/bin/codelldb
  '';
}
