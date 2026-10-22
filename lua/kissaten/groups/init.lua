---@mod kissaten.groups Highlight group assembly, plugin detection and caching
local Util = require("kissaten.util")

local M = {}

---@alias kissaten.Highlight vim.api.keyset.highlight|{style?: table}|string
---@alias kissaten.Highlights table<string, kissaten.Highlight>
---@alias kissaten.HighlightsFn fun(c: kissaten.Colors, opts: kissaten.Config): kissaten.Highlights

--- Always-on groups (order doesn't matter, names don't overlap).
M.core = { "editor", "syntax", "treesitter", "semantic_tokens", "lsp" }

--- plugin (repo name as plugin managers see it) -> integration module
-- stylua: ignore
M.plugins = {
  ["aerial.nvim"]                 = "aerial",
  ["alpha-nvim"]                  = "alpha",
  ["barbar.nvim"]                 = "barbar",
  ["blink.cmp"]                   = "blink",
  ["bufferline.nvim"]             = "bufferline",
  ["copilot.lua"]                 = "copilot",
  ["copilot.vim"]                 = "copilot",
  ["dashboard-nvim"]              = "dashboard",
  ["diffview.nvim"]               = "diffview",
  ["fidget.nvim"]                 = "fidget",
  ["flash.nvim"]                  = "flash",
  ["fzf-lua"]                     = "fzf",
  ["gitsigns.nvim"]               = "gitsigns",
  ["grug-far.nvim"]               = "grug-far",
  ["harpoon"]                     = "harpoon",
  ["hop.nvim"]                    = "hop",
  ["indent-blankline.nvim"]       = "indent-blankline",
  ["lazy.nvim"]                   = "lazy",
  ["leap.nvim"]                   = "leap",
  ["mason.nvim"]                  = "mason",
  ["mini.nvim"]                   = "mini",
  ["neo-tree.nvim"]               = "neo-tree",
  ["neogit"]                      = "neogit",
  ["neotest"]                     = "neotest",
  ["noice.nvim"]                  = "noice",
  ["nvim-cmp"]                    = "cmp",
  ["nvim-dap"]                    = "dap",
  ["nvim-dap-ui"]                 = "dap",
  ["nvim-navic"]                  = "navic",
  ["nvim-notify"]                 = "notify",
  ["nvim-scrollbar"]              = "scrollbar",
  ["nvim-tree.lua"]               = "nvim-tree",
  ["nvim-treesitter-context"]     = "treesitter-context",
  ["nvim-ufo"]                    = "ufo",
  ["octo.nvim"]                   = "octo",
  ["outline.nvim"]                = "outline",
  ["overseer.nvim"]               = "overseer",
  ["rainbow-delimiters.nvim"]     = "rainbow",
  ["render-markdown.nvim"]        = "render-markdown",
  ["sidekick.nvim"]               = "sidekick",
  ["snacks.nvim"]                 = "snacks",
  ["telescope.nvim"]              = "telescope",
  ["todo-comments.nvim"]          = "todo-comments",
  ["trouble.nvim"]                = "trouble",
  ["vim-illuminate"]              = "illuminate",
  ["vim-gitgutter"]               = "gitgutter",
  ["which-key.nvim"]              = "which-key",
  ["yanky.nvim"]                  = "yanky",
}

---@param name string
---@return {get: kissaten.HighlightsFn, url?: string}
function M.module(name)
  local mod = vim.tbl_contains(M.core, name) and ("kissaten.groups." .. name)
    or ("kissaten.groups.integrations." .. name)
  return require(mod)
end

--- Plugin names known to lazy.nvim and/or vim.pack (Neovim 0.12+).
---@return table<string, boolean>? names, nil when no supported manager is loaded
function M.installed()
  local found, any = {}, false
  if package.loaded["lazy"] or package.loaded["lazy.core.config"] then
    local ok, cfg = pcall(require, "lazy.core.config")
    if ok and cfg.plugins then
      any = true
      for name in pairs(cfg.plugins) do
        found[name] = true
      end
    end
  end
  -- Only ask vim.pack when the user's config actually loaded it: the query
  -- costs ~1 ms, which lazy.nvim users shouldn't pay on every startup.
  if package.loaded["vim.pack"] and vim.pack.get then
    local ok, list = pcall(vim.pack.get, nil, { info = false })
    if ok and type(list) == "table" then
      any = any or #list > 0
      for _, p in ipairs(list) do
        local name = p.spec and p.spec.name
        if name then
          found[name] = true
        end
      end
    end
  end
  -- mini.* standalone repos (mini.icons, mini.files, ...) all map to "mini"
  for name in pairs(found) do
    if name:find("^mini%.") then
      found["mini.nvim"] = true
    end
  end
  return any and found or nil
end

--- Decide which integration modules to load.
---@param opts kissaten.Config
---@return string[] sorted list of enabled integration modules
function M.enabled(opts)
  local on = {}
  local installed = opts.plugins.auto ~= false and M.installed() or nil
  local all = opts.plugins.all
  if all == nil then
    all = installed == nil -- no plugin manager we understand -> load everything
  end

  if all then
    for _, mod in pairs(M.plugins) do
      on[mod] = true
    end
  elseif installed then
    for plugin, mod in pairs(M.plugins) do
      if installed[plugin] then
        on[mod] = true
      end
    end
  end

  -- explicit user choices win, by module name ("telescope") or repo ("telescope.nvim")
  for plugin, mod in pairs(M.plugins) do
    local use = opts.plugins[mod]
    if use == nil then
      use = opts.plugins[plugin]
    end
    if type(use) == "table" then
      use = use.enabled
    end
    if use ~= nil then
      on[mod] = use and true or nil
    end
  end

  local list = vim.tbl_keys(on)
  table.sort(list)
  return list
end

--- Merge `style` tables into the highlight and apply global kill-switches.
---@param groups kissaten.Highlights
---@param opts kissaten.Config
local function finalize(groups, opts)
  for name, hl in pairs(groups) do
    if type(hl) == "string" then
      groups[name] = { link = hl }
    elseif type(hl) == "table" then
      if hl.style then
        local style = hl.style
        hl.style = nil
        for k, v in pairs(style) do
          if hl[k] == nil then
            hl[k] = v
          end
        end
      end
      if opts.no_italic then
        hl.italic = nil
      end
      if opts.no_bold then
        hl.bold = nil
      end
      if opts.no_underline then
        hl.underline, hl.undercurl, hl.underdouble, hl.underdotted, hl.underdashed = nil, nil, nil, nil, nil
      end
    end
  end
  return groups
end

--- Build every highlight group for the given colors/options.
--- Building all ~1,600 groups takes about 1 ms, so there is deliberately no
--- cache: nothing can go stale after an update or a config change.
---@param c kissaten.Colors
---@param opts kissaten.Config
---@param integrations? string[] defaults to `M.enabled(opts)`
---@return kissaten.Highlights groups, string[] integrations
function M.setup(c, opts, integrations)
  integrations = integrations or M.enabled(opts)
  local groups = {}
  for _, name in ipairs(M.core) do
    for k, v in pairs(M.module(name).get(c, opts)) do
      groups[k] = v
    end
  end
  for _, name in ipairs(integrations) do
    local ok, mod = pcall(M.module, name)
    if ok then
      for k, v in pairs(mod.get(c, opts)) do
        groups[k] = v
      end
    else
      Util.notify(("failed to load integration '%s': %s"):format(name, mod))
    end
  end
  Util.resolve(groups)
  opts.on_highlights(groups, c)
  finalize(groups, opts)
  return groups, integrations
end

return M
