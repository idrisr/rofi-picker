{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/24.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { nixpkgs, flake-utils, ... }:
    let
      system = flake-utils.lib.system.x86_64-linux;
      pkgs = nixpkgs.legacyPackages.${system};
      rofiLauncher = pkgs.haskell.packages.ghc96.callPackage ./rofipicker { };
      packageSet = packages:
        let
          f = import ./wrapper.nix;
          g = import ./desktop-item.nix;
          h = { inherit rofiLauncher; };
        in with packages; {
          books = callPackage (f "books" "/home/hippoid/books") h;
          papers = callPackage (f "papers" "/home/hippoid/documents/papers") h;
          techtalk =
            callPackage (f "techtalk" "/home/hippoid/documents/tech-talks") h;
          booksDesktopItem = callPackage (g "books") { };
          papersDesktopItem = callPackage (g "papers") { };
          techtalkDesktopItem = callPackage (g "techtalk") { };
          vidoesDesktopItem = callPackage (g "videos") { };
        };
    in {
      overlays.all = _: prev: packageSet prev;
      packages.${system} = packageSet pkgs;
    };
}
