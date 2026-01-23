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
        name = "thorium-avx2";
        version = "138.0.7204.300";
        src = pkgs.fetchurl {
          url = "https://github.com/Alex313031/thorium/releases/download/M138.0.7204.300/Thorium_Browser_138.0.7204.300_AVX2.AppImage";
          sha256 = "sha256-vpAAoZv8Ayg1AN0Uo9Ou8fX22hdhJnxHM1W6XrpwMww=";
        };
        appimageContents = pkgs.appimageTools.extractType2 {inherit pname version src;};
      in
        pkgs.appimageTools.wrapType2 {
          inherit pname version src;
          extraInstallCommands = ''
            install -m 444 -D ${appimageContents}/thorium-browser.desktop $out/share/applications/thorium-browser.desktop
            install -m 444 -D ${appimageContents}/thorium.png $out/share/icons/hicolor/512x512/apps/thorium.png
            substituteInPlace $out/share/applications/thorium-browser.desktop \
            --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name} %U'
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

      
      thorium-sse4 = let
        pkgs = import nixpkgs {system = "x86_64-linux";};
        pname = "thorium-sse4";
        name = "thorium-sse4";
        version = "138.0.7204.300";
        src = pkgs.fetchurl {
          url = "https://github.com/Alex313031/thorium/releases/download/M138.0.7204.300/Thorium_Browser_138.0.7204.300_SSE4.AppImage";
          sha256 = "sha256-vpAAoZv8Ayg1AN0Uo9Ou8fX22hdhJnxHM1W6XrpwMww";
        };
        appimageContents = pkgs.appimageTools.extractType2 {inherit pname version src;};
      in
        pkgs.appimageTools.wrapType2 {
          inherit pname version src;
          extraInstallCommands = ''
            install -m 444 -D ${appimageContents}/thorium-browser.desktop $out/share/applications/thorium-browser.desktop
            install -m 444 -D ${appimageContents}/thorium.png $out/share/icons/hicolor/512x512/apps/thorium.png
            substituteInPlace $out/share/applications/thorium-browser.desktop \
            --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name} %U'
          '';
        };

      # AVX is compatible with most CPUs
      default = self.packages.x86_64-linux.thorium-avx;
    };

    apps.x86_64-linux = {
      thorium-avx = {
        type = "app";
        program = "${self.packages.x86_64-linux.thorium-avx}/bin/thorium-avx";
        meta = {
            description = "Thorium Browser AVX Variant";
        };
      };

      thorium-avx2 = {
        type = "app";
        program = "${self.packages.x86_64-linux.thorium-avx2}/bin/thorium-avx2";
        meta = {
            description = "Thorium Browser AVX2 Variant";
        };
      };

      thorium-sse3 = {
        type = "app";
        program = "${self.packages.x86_64-linux.thorium-sse3}/bin/thorium-sse3";
        meta = {
          description = "Thorium Browser SSE3 Variant";
        };
      };

      thorium-sse4 = {
        type = "app";
        program = "${self.packages.x86_64-linux.thorium-sse4}/bin/thorium-sse4";
        meta = {
            description = "Thorium Browser SSE4 Variant";
        };
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
