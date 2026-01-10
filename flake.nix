{
  description = "Thorium using Nix Flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
    ...
  }: {
    ##### x86_64-linux #####
    packages.x86_64-linux = let
      pkgs = import nixpkgs {system = "x86_64-linux";};
    in {
      thorium-avx = let
        pkgs = import nixpkgs {system = "x86_64-linux";};
        pname = "thorium-avx";
        version = "122.0.6261.132 - 56";
        src = pkgs.fetchurl {
          url = "https://github.com/Alex313031/thorium/releases/download/M122.0.6261.132/thorium_browser_122.0.6261.132_AVX.AppImage";
          sha256 = "sha256-2PJxnKzppjHrYQnGYYe1BG0075FwDdnjY0JI2X5AIvQ=";
        };
        appimageContents = pkgs.appimageTools.extractType2 {inherit pname src version;};
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

      thorium-avx2 = let
        pkgs = import nixpkgs {system = "x86_64-linux";};
        pname = "thorium-avx2";
        version = "138.0.7204.300";
        src = pkgs.fetchzip {
          url = "https://github.com/Alex313031/thorium/releases/download/M138.0.7204.300/thorium-browser_138.0.7204.300_AVX2.zip";
          sha256 = "sha256-K8/eXXYn5hIOa/i4J1O5ARlbc9zQCblLEfm8BcK3zvo=";
          stripRoot = false;
        };
      in
        pkgs.stdenv.mkDerivation {
          inherit pname version src;
          nativeBuildInputs = [ pkgs.autoPatchelfHook ];
          buildInputs = [ pkgs.glibc pkgs.glibc.out ];
          installPhase = ''
              mkdir -p $out/share/applications
              mkdir -p $out/share/icons/hicolor/scalable/apps
              cp -r * $out/share/applications
              rm -rf $out/thorium
              cp -r ./thorium-portable.desktop $out/share/applications
              mkdir -p $out/bin
              cp thorium $out/bin/thorium-browser
              cp -r * $out/bin/
              rm -rf $out/bin/xdg-mime
              rm -rf $out/bin/xdg-settings
              rm -rf $out/bin/THORIUM-PORTABLE
              sed -i 's|./thorium-browser|thorium-browser|' $out/share/applications/thorium-portable.desktop
              sed -i 's|./thorium_shell|thorium_shell|' $out/share/applications/thorium-shell.desktop
              mv $out/share/applications/thorium.svg $out/share/icons/hicolor/scalable/apps
              mv $out/share/applications/thorium_shell.png $out/share/icons/hicolor/scalable/apps
              sed -i 's|product_logo_256.png|thorium|' $out/share/applications/thorium-portable.desktop
              sed -i 's|thorium_shell.png|thorium_shell|' $out/share/applications/thorium-shell.desktop
          '';
        };

      thorium-sse3 = let
        pkgs = import nixpkgs {system = "x86_64-linux";};
        pname = "thorium-sse3";
        version = "122.0.6261.132 - 56";
        src = pkgs.fetchurl {
          url = "https://github.com/Alex313031/thorium/releases/download/M122.0.6261.132/thorium_browser_122.0.6261.132_SSE3.AppImage";
          sha256 = "sha256-G+Z85w7d7YT/03tqcH1VMJGoenoegcttbxz38u0JWcI=";
        };
        appimageContents = pkgs.appimageTools.extractType2 {inherit pname src version;};
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

      # AVX is compatible with most CPUs
      default = self.packages.x86_64-linux.thorium-avx;
    };

    apps.x86_64-linux = {
      thorium-avx = {
        type = "app";
        program = "${self.packages.x86_64-linux.thorium-avx}/bin/thorium-avx";
      };

      thorium-avx2 = {
        type = "app";
        program = "${self.packages.x86_64-linux.thorium-avx2}/bin/thorium-avx2";
      };

      thorium-sse3 = {
        type = "app";
        program = "${self.packages.x86_64-linux.thorium-sse3}/bin/thorium-sse3";
      };

      default = self.apps.x86_64-linux.thorium-avx;
    };

    ##### aarch64-linux #####
    packages.aarch64-linux = {
      thorium = let
        pkgs = import nixpkgs {system = "aarch64-linux";};
        pname = "thorium";
        version = "122.0.6261.132 - 6";
        src = pkgs.fetchurl {
          url = "https://github.com/Alex313031/Thorium-Raspi/releases/download/M122.0.6261.132/Thorium_Browser_122.0.6261.132_arm64.AppImage";
          sha256 = "sha256-gS3/f7wq5adOLZuS2T8SWfme/Z1bFqHSpMLUsENKlcw=";
        };
        appimageContents = pkgs.appimageTools.extractType2 {inherit pname src version;};
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

      default = self.packages.aarch64-linux.thorium;
    };

    apps.aarch64-linux = {
      thorium = {
        type = "app";
        program = "${self.packages.aarch64-linux.thorium}/bin/thorium";
      };

      default = self.apps.aarch64-linux.thorium;
    };
  };
}
