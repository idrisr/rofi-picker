name: folder:
{ stdenvNoCC, makeWrapper, rofiLauncher }:
stdenvNoCC.mkDerivation {
  name = name;
  dontUnpack = true;
  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p "$out/bin"
    cp ${rofiLauncher}/bin/rofilauncher $out/bin/${name}
    wrapProgram $out/bin/${name} --add-flags "${folder}"
  '';
}
