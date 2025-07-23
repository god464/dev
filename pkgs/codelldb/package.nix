{ stdenv, pkgs, ... }:
let
  codelldb_package = pkgs.vscode-extensions.vadimcn.vscode-lldb;
  codelldb_path = "${codelldb_package}/share/vscode/extensions/vadimcn.vscode-lldb";
in
stdenv.mkDerivation {
  pname = "codelldb";
  inherit (codelldb_package) version meta;
  src = ./.;

  nativeBuildInputs = with pkgs; [
    makeWrapper
    autoFixElfFiles
  ];

  dontUnpack = true;
  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/lib
    cp -r ${codelldb_path}/adapter/* $out/bin/
    cp -r ${codelldb_path}/lldb/bin/* $out/bin/
    cp -r ${codelldb_path}/lldb/lib/* $out/lib/

    chmod +x $out/bin/*
    wrapProgram $out/bin/codelldb --set LD_LIBRARY_PATH $out/lib

    runHook postInstall
  '';
}
