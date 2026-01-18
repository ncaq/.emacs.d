# For LLM Instructions

## 出力設定

日本語で応答してください。
しかしコードのコメントなどは元の言語を尊重します。
全角記号より半角記号を優先して使ってください。

## リポジトリの概要

このリポジトリは個人的なEmacs設定ファイルです。

### 設定の特徴

- パッケージ管理に[leaf](https://github.com/conao3/leaf.el)を使用。
  - leafは`ensure`キーワードを使うと`package.el`を使ってパッケージをインストールする。これを優先的に使用。
    - `package.el`のリポジトリには以下を指定している。
      - [melpa](https://melpa.org/packages/)
      - [nongnu](https://elpa.nongnu.org/nongnu/)
      - [gnu](https://elpa.gnu.org/packages/)
  - melpaが対応していないパッケージのインストールには他の手段をleafのキーワードで使用。
    - `:straight`で[straight](https://github.com/radian-software/straight.el)を使用。
    - `:vc`でEmacs組み込み機能の`package-vc`を使用。
- 自動カスタマイズ変数読み込みは無効化。
  - 自動で書き込みが行われるので`custom.el`に書き込みだけしている。

## 使用言語と規約

- 主な言語: Emacs Lisp
- コメント: 日本語または英語
- コーディングスタイル: Emacs Lispの標準的なスタイルに準拠

## ファイル構造

このリポジトリには、以下のような主要なファイルやディレクトリが含まれています：

### 主要設定ファイル

- `init.el`: メインの設定ファイル
- `early-init.el`: パッケージシステムより先に読み込まれる設定

### 主要ディレクトリ

- `elpa/`: package.elによりインストールされたパッケージ
- `snippets/`: YASnippetのスニペット集
- `straight/`: straight.elによりインストールされたパッケージ

## 重要なパッケージと機能

このEmacs設定では、多数のパッケージを使用して機能強化しています。特に重要なものを以下にまとめます：

### 編集機能強化

- **expand-region**: 意味のある範囲を徐々に選択範囲に追加
- **multiple-cursors**: 複数箇所を同時に編集
- **smartparens**: 括弧の対応を自動管理
- **symbolword-mode**: シンボル単位での操作を強化
- **volatile-highlights**: 操作した範囲を一時的にハイライト

### 開発支援

- **company**: 補完フレームワーク
- **editorconfig**: エディタ設定の統一
- **flycheck**: 構文チェック
- **lsp-mode**: Language Server Protocolクライアント
- **magit**: Git操作インターフェース

### UI/テーマ

- **helm**: 強力な選択インターフェース

### 言語サポート

- 多数のメジャーモード
- **lsp-haskell**などLSP連携

### カスタム機能

- **ncaq-emacs-utils**: 個人用ユーティリティ関数集
- Dvorakキーバインド最適化
