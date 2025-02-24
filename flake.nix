{
  description = "Thorium using Nix Flake";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs =
    {
      self,
      nixpkgs,
      ...
    }:
    {
      packages.x86_64-linux = {
        thorium-avx2 =
          let
            pkgs = import nixpkgs { system = "x86_64-linux"; };
            pname = "thorium-avx2";
            version = "130.0.6723.174";
            src = pkgs.fetchurl {
              url = "https://github.com/Alex313031/thorium/releases/download/M130.0.6723.174/Thorium_Browser_130.0.6723.174_AVX2.AppImage";
              hash = "sha256-Ej7OIdAjYRmaDlv56ANU5pscuwcBEBee6VPZA3FdxsQ=";
            };
            appimageContents = pkgs.appimageTools.extractType2 {
              inherit pname version src;
            };
          in
          pkgs.appimageTools.wrapType2 {
            inherit pname version src;
            extraInstallCommands = ''
              install -m 444 -D ${appimageContents}/thorium-browser.desktop $out/share/applications/thorium-browser.desktop
              install -m 444 -D ${appimageContents}/thorium.png $out/share/icons/hicolor/512x512/apps/thorium.png
              substituteInPlace $out/share/applications/thorium-browser.desktop \
              --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${pname} %U'
            '';
          };
        default = self.packages.x86_64-linux.thorium-avx2;
      };
      apps.x86_64-linux = {
        thorium-avx2 = {
          type = "app";
          program = "${self.packages.x86_64-linux.thorium-avx2}/bin/thorium-avx2";
        };
        default = self.apps.x86_64-linux.thorium-avx2;
      };
    };
}
