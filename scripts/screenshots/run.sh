#!/usr/bin/env bash
# Rebuild the README screenshots and the images made from them (styles grid,
# subtle-comments, social preview, palette cards) into assets/.
#
#   scripts/screenshots/run.sh
#
# Needs nvim, git, node, uv, and an existing LazyVim install to borrow plugins,
# treesitter parsers and language servers from (nothing is installed or
# updated). Overrides: KISSATEN_PLUGIN_DIR (lazy.nvim plugin root),
# KISSATEN_MASON_BIN, KISSATEN_FONT_DIR (JetBrainsMonoNerdFontMono-*.ttf).
set -euo pipefail

here=$(cd "$(dirname "$0")" && pwd)
repo=$(cd "$here/../.." && pwd)
mason_bin=${KISSATEN_MASON_BIN:-$HOME/.local/share/nvim/mason/bin}
fonts=${KISSATEN_FONT_DIR:-$HOME/Library/Fonts}

work=$(mktemp -d "${TMPDIR:-/tmp}/kissaten-shots.XXXXXX")
export XDG_CONFIG_HOME=$work/config XDG_STATE_HOME=$work/state XDG_CACHE_HOME=$work/cache
export UV_CACHE_DIR=${UV_CACHE_DIR:-$work/uv}
export PATH="$mason_bin:$PATH"
export KISSATEN_SHOT_LOG=$work/scenario.log
export KISSATEN_PLUGIN_DIR=${KISSATEN_PLUGIN_DIR:-$HOME/.local/share/nvim/lazy}
mkdir -p "$XDG_CONFIG_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME" "$work/shots"
echo "working in $work"

# The sample project, committed with a few lines changed afterwards, so
# gitsigns and the statusline have something to show.
cp -R "$here/samples" "$work/project"
cd "$work/project"
sed -i.bak 's/TAX_RATE: float = 0.09/TAX_RATE: float = 0.08/' app/server.py
sed -i.bak 's/local RATIO = 15/local RATIO = 16/' lua/plugin.lua
sed -i.bak -e 's/\["coffee"\] as const/["coffee", "tea"] as const/' -e 's/\.filter(Boolean)//' src/cart.ts
find . -name '*.bak' -delete
git init -q -b master
git add -A
GIT_CONFIG_GLOBAL=/dev/null git -c user.name=kissaten -c user.email=kissaten@localhost commit -q -m samples
cp -R "$here/samples/." .

shoot() { # scenario extra-args...
  uv run --no-project --with pynvim --with pillow python "$repo/scripts/screenshot.py" \
    --scenario "$here/scenario.lua" --out "$work/shots" --font-dir "$fonts" "$@"
}
shoot --frame -- -i NONE -u "$here/init.lua"
KISSATEN_SCENARIO=popup shoot --frame -- -i NONE -u "$here/init.lua"
KISSATEN_SCENARIO=subtle shoot --cols 92 --rows 26 -- -i NONE -u "$here/init.lua"

if [ -s "$KISSATEN_SHOT_LOG" ]; then
  echo "scenario problems:" >&2
  cat "$KISSATEN_SHOT_LOG" >&2
  exit 1
fi

cd "$repo"
uv run --no-project --with pillow --with numpy python scripts/make_assets.py --shots "$work/shots" --font-dir "$fonts"
