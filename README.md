# nvim config

Neovim 0.12+ config using lazy.nvim. Treesitter support is handled natively.

## Setup on a new machine

### 1. Prerequisites

| Tool              | Purpose                | Install                                           |
| ----------------- | ---------------------- | ------------------------------------------------- |
| `git`             | cloning parser sources | system package manager                            |
| `node` / `npm`    | tree-sitter CLI        | [nodejs.org](https://nodejs.org)                  |
| `tree-sitter` CLI | compiling parsers      | `npm install -g tree-sitter-cli`                  |
| C/C++ compiler    | building `.so` files   | `apt install build-essential` (Debian/Ubuntu/WSL) |

### 2. Install the config

```bash
git clone <this-repo> ~/.config/nvim
```

### 3. Install treesitter parsers

Run the install script once:

```bash
bash ~/.config/nvim/scripts/install-parsers.sh
```

This compiles and places all required parser `.so` files in
`~/.local/share/nvim/parser/`. It is safe to re-run for updates.

### 4. Start Neovim

Open Neovim, lazy.nvim will bootstrap itself and install plugins on first
launch. Then verify treesitter is healthy:

```
:checkhealth vim.treesitter
```

---

## How treesitter parsers work (no plugin)

Neovim 0.12 ships with a small set of parsers built into the binary. Any
additional parser is a compiled shared library (`.so` on Linux, `.dylib` on
macOS) placed in Neovim's parser directory.

**Bundled in Neovim 0.12** — nothing to install:

```
lua  vim  vimdoc  bash  python  c  markdown  markdown_inline  query
```

**Installed by the script** — compiled from source:

| Parser             | Source                             | Notes                            |
| ------------------ | ---------------------------------- | -------------------------------- |
| `html`             | tree-sitter/tree-sitter-html       |                                  |
| `css`              | tree-sitter/tree-sitter-css        |                                  |
| `regex`            | tree-sitter/tree-sitter-regex      |                                  |
| `toml`             | ikatyang/tree-sitter-toml          |                                  |
| `javascript`       | tree-sitter/tree-sitter-javascript |                                  |
| `typescript`       | tree-sitter/tree-sitter-typescript | also installs `tsx`              |
| `c_sharp`          | tree-sitter/tree-sitter-c-sharp    | filetype `cs` → parser `c_sharp` |
| `java`             | tree-sitter/tree-sitter-java       |                                  |
| `php` / `php_only` | tree-sitter/tree-sitter-php        | two grammars from one repo       |
| `rust`             | tree-sitter/tree-sitter-rust       |                                  |
| `go`               | tree-sitter/tree-sitter-go         |                                  |
| `yaml`             | ikatyang/tree-sitter-yaml          |                                  |
| `json` / `jsonc`   | tree-sitter/tree-sitter-json       | `jsonc` reuses the json binary   |
| `templ`            | vrischmann/tree-sitter-templ       | Go HTML templates                |
| `gotmpl`           | ngalaiko/tree-sitter-go-template   | Go text/html templates           |
| `blade`            | EmranMR/tree-sitter-blade          | Laravel Blade                    |

Custom queries for `blade`, `gotmpl`, `html`, `php`, and `systems` live in
`queries/` and `after/queries/` and are picked up automatically from the
runtimepath — no extra steps needed.

### Parser directory

```
~/.local/share/nvim/parser/
├── javascript.so
├── typescript.so
├── tsx.so
├── rust.so
├── go.so
├── yaml.so
├── json.so
├── jsonc.so    ← symlink/copy of json.so
├── templ.so
├── gotmpl.so
└── blade.so
```

### Adding a new parser manually

```bash
git clone --depth 1 https://github.com/some-org/tree-sitter-lang /tmp/ts-lang
tree-sitter build --output ~/.local/share/nvim/parser/lang.so /tmp/ts-lang
rm -rf /tmp/ts-lang
```

Then register it in Lua if the filetype name differs from the language name:

```lua
vim.treesitter.language.register("lang", "filetype")
```
