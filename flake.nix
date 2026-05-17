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
    let
      # 明示的に許可するunfreeパッケージのリスト。
      allowedUnfreePackages = [
        "copilot-language-server" # 一番いい補完のため仕方がない。
      ];

      # 外部のoverlayを受け入れたpkgsを生成する。
      mkPkgs =
        {
          system,
          extraOverlays ? [ ],
        }:
        import nixpkgs {
          inherit system;
          config = {
            allowUnfreePredicate =
              pkg:
              let
                name = nixpkgs.lib.getName pkg;
              in
              builtins.elem name allowedUnfreePackages;
          };
          overlays = [
            emacs-overlay.overlays.default
          ]
          ++ extraOverlays;
        };

      # `init.el`から自動推論されないネイティブパッケージ。
      extraEmacsPackagesFor =
        pkgs: epkgs:
        (with epkgs; [
          treesit-grammars.with-all-grammars
        ])
        ++ (with pkgs; [
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
          elmPackages.elm-format
          elmPackages.elm-language-server
          erlang-language-platform
          fortls
          fourmolu
          gauche
          gh
          gopls
          graphql-language-service-cli
          graphviz
          haskell-language-server
          haskellPackages.cabal-fmt
          haskellPackages.cabal-gild
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
          nodePackages.purescript-language-server
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
        ]);

      # Emacs derivationのビルドオプション。
      # `default`と`pgtk`の両方に適用されます。
      emacsBuildOptions = {
        withCompressInstall = false;
      };

      /**
        指定`system`に対して`init.el`と外部toolingを束ねたEmacsパッケージを生成する関数。

        - `package`: nixpkgsなどに定義されているemacsのpackage名を指定します。
        - `extraOverlays`: dotfiles側のCPUモデル最適化overlayなど、
          呼び出し側が追加したいnixpkgs overlayを受け取る。
          ここで受け取ったoverlayは内部pkgsの構築時に`emacs-overlay`の後ろに連結されるため、
          `emacs`/`emacs-pgtk`などのderivationを呼び出し側が差し替えられる。

        flake outputsの`packages.<system>.default`/`pgtk`は、
        外部overlayなしのデフォルト構成としてこの関数を呼び出した結果である。
      */
      mkEmacs =
        {
          system,
          basePackage,
          extraOverlays ? [ ],
        }:
        let
          pkgs = mkPkgs { inherit system extraOverlays; };
          withPgtk = nixpkgs.lib.elem "--with-pgtk" basePackage.configureFlags;
          # `withImageMagick`は`withX`または`withNS`を要求するため、
          # pgtkと一緒に有効化できません。
          extraEmacsBuildOptions =
            emacsBuildOptions // (if withPgtk then { } else { withImageMagick = true; });
          package = basePackage.override extraEmacsBuildOptions;
        in
        pkgs.emacsWithPackagesFromUsePackage {
          inherit package;
          config = ./init.el;
          extraEmacsPackages = extraEmacsPackagesFor pkgs;
        };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        treefmt-nix.flakeModule
      ];

      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];

      flake.lib = {
        inherit mkEmacs;
      };

      perSystem =
        {
          pkgs,
          system,
          ...
        }:
        let
          dot-emacs-default = mkEmacs {
            inherit system;
            basePackage = pkgs.emacs;
          };
          dot-emacs-pgtk = mkEmacs {
            inherit system;
            basePackage = pkgs.emacs-pgtk;
          };
        in
        {
          _module.args.pkgs = mkPkgs { inherit system; };
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
          checks = {
            inherit
              dot-emacs-default
              dot-emacs-pgtk
              ;
          };
          packages = {
            # flake.lockの管理バージョンをre-exportすることで安定した利用を促進。
            inherit (pkgs)
              nix-fast-build
              ;
            default = dot-emacs-default;
            pgtk = dot-emacs-pgtk;
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
