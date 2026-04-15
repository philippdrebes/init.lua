#!/usr/bin/env bash
# Install Neovim treesitter parsers for this config.
# Run once on each machine: bash scripts/install-parsers.sh
# Re-run any time to update parsers.
set -euo pipefail

PARSER_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/parser"
WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT

# ── prerequisites ──────────────────────────────────────────────────────────────
command -v git >/dev/null 2>&1        || { echo "✗ git not found"; exit 1; }
command -v tree-sitter >/dev/null 2>&1 || {
    echo "✗ tree-sitter CLI not found"
    echo "  Install via: npm install -g tree-sitter-cli"
    exit 1
}

mkdir -p "$PARSER_DIR"
echo "Parser directory: $PARSER_DIR"
echo ""

# ── helpers ────────────────────────────────────────────────────────────────────
build() {
    local name=$1 url=$2 subdir=${3:-}
    printf "  %-12s " "$name"
    local dir="$WORK/$name"
    git clone --quiet --depth 1 "$url" "$dir" 2>/dev/null
    local grammar="${dir}${subdir:+/$subdir}"
    tree-sitter build --output "$PARSER_DIR/$name.so" "$grammar" 2>/dev/null
    echo "✓"
}

# ── standard parsers (not bundled in Neovim 0.12) ─────────────────────────────
echo "Standard parsers:"
build html       https://github.com/tree-sitter/tree-sitter-html
build css        https://github.com/tree-sitter/tree-sitter-css
build regex      https://github.com/tree-sitter/tree-sitter-regex
build toml       https://github.com/ikatyang/tree-sitter-toml
build javascript https://github.com/tree-sitter/tree-sitter-javascript
build c_sharp    https://github.com/tree-sitter/tree-sitter-c-sharp
build java       https://github.com/tree-sitter/tree-sitter-java

# PHP: two grammars in one repo
printf "  %-12s " "php"
git clone --quiet --depth 1 https://github.com/tree-sitter/tree-sitter-php "$WORK/php-repo" 2>/dev/null
tree-sitter build --output "$PARSER_DIR/php.so" "$WORK/php-repo/php" 2>/dev/null
echo "✓"
printf "  %-12s " "php_only"
tree-sitter build --output "$PARSER_DIR/php_only.so" "$WORK/php-repo/php_only" 2>/dev/null
echo "✓"
build rust       https://github.com/tree-sitter/tree-sitter-rust
build go         https://github.com/tree-sitter/tree-sitter-go
build yaml       https://github.com/ikatyang/tree-sitter-yaml
build json       https://github.com/tree-sitter/tree-sitter-json

# jsonc shares the same parser binary as json
cp "$PARSER_DIR/json.so" "$PARSER_DIR/jsonc.so"
printf "  %-12s ✓ (copied from json)\n" "jsonc"

# TypeScript: two grammars in one repo
printf "  %-12s " "typescript"
git clone --quiet --depth 1 https://github.com/tree-sitter/tree-sitter-typescript "$WORK/ts-repo" 2>/dev/null
tree-sitter build --output "$PARSER_DIR/typescript.so" "$WORK/ts-repo/typescript" 2>/dev/null
echo "✓"
printf "  %-12s " "tsx"
tree-sitter build --output "$PARSER_DIR/tsx.so" "$WORK/ts-repo/tsx" 2>/dev/null
echo "✓"

# ── custom parsers ─────────────────────────────────────────────────────────────
echo ""
echo "Custom parsers:"
build templ  https://github.com/vrischmann/tree-sitter-templ
build gotmpl https://github.com/ngalaiko/tree-sitter-go-template
build blade  https://github.com/EmranMR/tree-sitter-blade

echo ""
echo "Done. Restart Neovim and run :checkhealth vim.treesitter"
