{ mkDerivation, base, filepath, foldl, lib, optparse-applicative, text, turtle
}:
mkDerivation {
  pname = "rofipicker";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends =
    [ base filepath foldl optparse-applicative text turtle ];
  license = lib.licenses.mit;
  mainProgram = "rofipicker";
}
