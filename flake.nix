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
                  clang-tools
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
            # flake.lockの管理バージョンをre-exportすることで安定した利用を促進。
            inherit (pkgs)
              nix-fast-build
              ;
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
              statix.enable = true;
              typos.enable = true;
              zizmor.enable = true;
            };
            settings.formatter = {
              editorconfig-checker = {
                command = pkgs.editorconfig-checker;
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
      "https://niks3-public.ncaq.net/"
      "https://ncaq.cachix.org/"
      "https://nix-community.cachix.org/"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "niks3-public.ncaq.net-1:e/B9GomqDchMBmx3IW/TMQDF8sjUCQzEofKhpehXl04="
      "ncaq.cachix.org-1:XF346GXI2n77SB5Yzqwhdfo7r0nFcZBaHsiiMOEljiE="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
