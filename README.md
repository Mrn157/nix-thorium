Might improve in the future
So far avx2 is only variant that is supported

# Nix Flake for installing and running Thorium Browser

Refer to the [Thorium Browser](https://thorium.rocks/) website for more information.


## Running without Installation

```bash
nix run github:almahdi/nix-thorium
```

## Installation

```bash
nix profile install github:almahdi/nix-thorium
```

## How to install in your configuration

In your `flake.nix`, Add nix-thorium as a input

```bash
{
  description = "Example";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nix-thorium = {
      url = "github:Mrn157/nix-thorium?rev=d206bc6bd506687303fda970f8c5e390cc01f353";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
```

Then add `@inputs` before `:` on outputs like this:
```bash
outputs = { nixpkgs, ... }@inputs:
```

Then in your configuration file (like `configuration.nix`), add to `environment.systemPackages`
```bash
environment.systemPackages = [
   inputs.nix-thorium.packages.${pkgs.system}.thorium-avx2
];
```

Replace thorium-avx2 with your package of choice
