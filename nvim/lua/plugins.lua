-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- All of my plugins. Note that all requiring and configuration of plugins happen in
-- /after/plugins
local autosave      = { "Pocco81/auto-save.nvim" }
local catppuccin    = { "catppuccin/nvim", name = "catppuccin", priority = 1000 }
local cmp           = { "hrsh7th/nvim-cmp", branch = "main" }
local cmp_buffer    = { "hrsh7th/cmp-buffer", branch = "main" }
local cmp_cmdline   = { "hrsh7th/cmp-cmdline", branch = "main" }
local cmp_lsp       = { "hrsh7th/cmp-nvim-lsp", branch = "main" }
local cmp_path      = { "hrsh7th/cmp-path", branch = "main" }
local gototest      = { "git@github.com:InformedK12/gototest.nvim.git", branch = 'main' }
local ibl           = { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }
local diffconflicts = { "rafikdraoui/jj-diffconflicts", branch = "main" }
local leap          = { url = "https://codeberg.org/andyg/leap.nvim", }
local lspconfig     = { "neovim/nvim-lspconfig" }
local luasnip       = { "L3MON4D3/LuaSnip",
                        version = "v2.*",
                        build = "make install_jsregexp" }
local obsidian      = { "epwalsh/obsidian.nvim",
                        lazy = true,
                        ft = "markdown",
                        event = { "BufReadPre " .. vim.fn.expand "~" .. "/Documents/Dnd_Vault/**.md",
                                  "BufNewFile " .. vim.fn.expand "~" .. "/Documents/Dnd_Vault/**.md" },
                        opts = {
                          workspaces = { { name = "dnd", path = "~/Documents/Dnd_Vault" } },
                          completion = { nvim_cmp = true, min_chars = 2 },
                          disable_frontmatter = true,
                          ui = { enable = false },
                        },
                        dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" } }
local telescope     = { "nvim-telescope/telescope.nvim",
                        version = "*",
                        dependencies = {
                          "nvim-lua/plenary.nvim",
                          { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
                        }
                      }

local telescope_fzf = { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
local treesitter    = { 'nvim-treesitter/nvim-treesitter', lazy = false, build = ':TSUpdate' }
local vimtest       = { 'vim-test/vim-test' }

require("lazy").setup({
  autosave,
  catppuccin,
  cmp,
  cmp_buffer,
  cmp_cmdline,
  cmp_lsp,
  cmp_path,
  diffconflicts,
  gototest,
  ibl,
  leap,
  lspconfig,
  luasnip,
  obsidian,
  telescope,
  telescope_fzf,
  treesitter,
  vimtest,
})

