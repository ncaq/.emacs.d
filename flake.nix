{
  description = "My Emacs config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs";
      };
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      flake-parts,
      treefmt-nix,
      emacs-overlay,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        treefmt-nix.flakeModule
      ];

      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];

      perSystem =
        {
          pkgs,
          system,
          ...
        }:
        let
          # 明示的に許可するunfreeパッケージのリスト。
          allowedUnfreePackages = [
            "copilot-language-server" # 一番いい補完のため仕方がない。
          ];
        in
        {
          _module.args.pkgs = import nixpkgs {
            inherit system;
            config = {
              allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) allowedUnfreePackages;
            };
            overlays = [
              emacs-overlay.overlays.default
            ];
          };
          packages = {
            default = pkgs.emacsWithPackagesFromUsePackage {
              # init.elが依存しているEmacs Lispパッケージがバンドルされます。
              config = ./init.el;
              # init.elから自動推論されないパッケージを追加します。
              extraEmacsPackages =
                _epkgs:
                with pkgs;
                [
                  bash-language-server
                  black
                  ccls
                  clojure-lsp
                  cmake-language-server
                  copilot-language-server
                  csharp-ls
                  deno
                  dhall-lsp-server
                  dockerfile-language-server
                  elixir-ls
                  erlang-language-platform
                  fortls
                  fourmolu
                  gauche
                  gh
                  gopls
                  graphql-language-service-cli
                  graphviz
                  haskell-language-server
                  isort
                  jdt-language-server
                  kotlin-language-server
                  ltex-ls-plus
                  lua-language-server
                  marksman
                  metals
                  nginx-language-server
                  nil
                  nixfmt
                  ocamlPackages.ocaml-lsp
                  ocamlformat
                  omnisharp-roslyn
                  plantuml
                  prettier
                  pyright
                  ripgrep
                  ruff
                  rust-analyzer
                  sbcl
                  serve-d
                  shellcheck
                  sops
                  sqls
                  svelte-language-server
                  tailwindcss-language-server
                  taplo
                  terraform-ls
                  texlab
                  typescript-language-server
                  vscode-langservers-extracted
                  vue-language-server
                  yaml-language-server
                  zls
                ]
                ++ (with elmPackages; [
                  elm-format
                  elm-language-server
                ])
                ++ (with haskellPackages; [
                  cabal-fmt
                  cabal-gild
                ])
                ++ (with nodePackages; [
                  purescript-language-server
                ]);
            };
          };
          treefmt.config = {
            projectRootFile = "flake.nix";
            programs = {
              actionlint.enable = true;
              deadnix.enable = true;
              nixfmt.enable = true;
              prettier.enable = true;
              shellcheck.enable = true;
              shfmt.enable = true;
              zizmor.enable = true;

              statix = {
                enable = true;
                disabled-lints = [ "eta_reduction" ];
              };
            };
            settings.formatter = {
              editorconfig-checker = {
                command = pkgs.lib.getExe (
                  pkgs.writeShellApplication {
                    name = "editorconfig-checker-wrapper";
                    runtimeInputs = [ pkgs.editorconfig-checker ];
                    text = ''
                      editorconfig-checker "$@"
                    '';
                  }
                );
                includes = [ "*" ];
              };
            };
          };
          devShells.default = pkgs.mkShell { };
        };
    };

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org/"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
