## 1. Nix flake for Thorium Browser

`nix-thorium` helps you run and install
[Thorium Browser](https://thorium.rocks/). As things are right now, I only
maintain the `AVX2` version for `x86_64-linux`.

## 2. Run without installation

```fish
nix run github:debarchito/nix-thorium
```

## 3. Or use it as a flake

```nix
{
  inputs.nix-thorium.url = "github:debarchito/nix-thorium";
  outputs = { nix-thorium }: let
    system = "x86_64-linux";
    thorium = nix-thorium.packages.${system};
  in {
    # use thorium.thorium-avx2
  }
}
```
