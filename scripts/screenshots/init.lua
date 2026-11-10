-- Neovim config for the README screenshots (see run.sh): LazyVim, loaded
-- offline from an existing plugin directory, with kissaten from this checkout.
-- Nothing is installed or updated, and nothing is written outside the
-- temporary XDG dirs run.sh sets up.
local plugins = vim.env.KISSATEN_PLUGIN_DIR or vim.fn.expand("~/.local/share/nvim/lazy")
local repo = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h:h")

vim.opt.rtp:prepend(plugins .. "/lazy.nvim")

require("lazy").setup({
  -- every plugin is a "dev" plugin read from `plugins`; the root stays empty,
  -- so lazy.nvim's UI lists only what this config uses (symlinks in the root
  -- don't work: lazy only counts real directories there)
  root = vim.fn.stdpath("state") .. "/lazy-root",
  dev = { path = plugins, patterns = { "" }, fallback = false },
  lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json",
  spec = {
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = { colorscheme = "kissaten-evening", news = { lazyvim = false, neovim = false } },
    },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.python" },
    { dir = repo, name = "kissaten.nvim", lazy = false, priority = 1000 },
    -- language servers come from PATH (run.sh adds mason's bin); mason itself
    -- stays off so it can't try to refresh its registry
    { "mason-org/mason.nvim", enabled = false },
    { "mason-org/mason-lspconfig.nvim", enabled = false },
    {
      "neovim/nvim-lspconfig",
      opts = function(_, opts)
        -- lua-language-server logs into its own install dir unless told otherwise
        local dir = vim.fn.stdpath("cache") .. "/lua_ls"
        opts.servers.lua_ls = vim.tbl_deep_extend("force", opts.servers.lua_ls or {}, {
          cmd = { "lua-language-server", "--logpath=" .. dir .. "/log", "--metapath=" .. dir .. "/meta" },
        })
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        opts.ensure_installed = {} -- use the parsers already there, never download
      end,
    },
    {
      "folke/snacks.nvim",
      opts = {
        dashboard = {
          preset = {
            header = table.concat({
              "██╗  ██╗██╗███████╗███████╗ █████╗ ████████╗███████╗███╗   ██╗",
              "██║ ██╔╝██║██╔════╝██╔════╝██╔══██╗╚══██╔══╝██╔════╝████╗  ██║",
              "█████╔╝ ██║███████╗███████╗███████║   ██║   █████╗  ██╔██╗ ██║",
              "██╔═██╗ ██║╚════██║╚════██║██╔══██║   ██║   ██╔══╝  ██║╚██╗██║",
              "██║  ██╗██║███████║███████║██║  ██║   ██║   ███████╗██║ ╚████║",
              "╚═╝  ╚═╝╚═╝╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═══╝",
            }, "\n"),
          },
        },
      },
    },
  },
  install = { missing = false },
  checker = { enabled = false },
  change_detection = { enabled = false },
  rocks = { enabled = false },
  readme = { enabled = false },
})
