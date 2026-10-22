local M = {}

---@param c kissaten.Colors
function M.generate(c)
  return require("kissaten.extras").template(
    [[
# ${_display} for fzf
# upstream: ${_upstream}
# Source from your shell rc (bash/zsh):  source <this file>

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --color=bg+:${surface0} \
  --color=bg:${bg} \
  --color=border:${surface2} \
  --color=fg:${fg} \
  --color=fg+:${fg} \
  --color=gutter:${bg} \
  --color=header:${orange} \
  --color=hl:${blue} \
  --color=hl+:${blue} \
  --color=info:${comment} \
  --color=marker:${pink} \
  --color=pointer:${pink} \
  --color=prompt:${orange} \
  --color=query:${fg}:regular \
  --color=scrollbar:${surface2} \
  --color=separator:${surface1} \
  --color=spinner:${orange} \
  --color=label:${lavender} \
"
]],
    c
  )
end

return M
