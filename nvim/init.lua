-- init.lua

-- ================= Plugin List ===================
local plugins = {
  -- LSP & Completion
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },

  -- Telescope for fuzzy finding
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- File tree
  { "nvim-tree/nvim-tree.lua" },

  -- Status line
  { "nvim-lualine/lualine.nvim" },

  -- Colorscheme
  { "ellisonleao/gruvbox.nvim" },

  -- Nerdcommenter alternative
  { "numToStr/Comment.nvim" },

  -- AnyJump alternative
  { "pechorin/any-jump.vim" },

  -- ctags
  { "wsdjeg/ctags.nvim" },
}

-- ============== Setup lazy.nvim ==================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugins)

-- =================== Plugin Configs ====================

-- Gruvbox Theme
vim.cmd("colorscheme gruvbox")
vim.opt.background = "dark"

-- Telescope Setup
require("telescope").setup({
  defaults = {
    vimgrep_arguments = {
      'ag', '--nocolor', '--nogroup', '--column'
    },
  },
})

-- File Tree Setup
require("nvim-tree").setup()

-- Lualine
require("lualine").setup()

-- Comment.nvim
require("Comment").setup()

-- =============== LSP + Autocompletion ===================
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig.clangd.setup({
  cmd = {
    "C:/Program Files (x86)/Microsoft Visual Studio/2022/BuildTools/VC/Tools/Llvm/x64/bin/clangd.exe"
  },
  capabilities = capabilities,
  on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    local km = vim.keymap
    km.set("n", "gd", vim.lsp.buf.definition, {})
    km.set("n", "gD", vim.lsp.buf.declaration, {})
    km.set("n", "gi", vim.lsp.buf.implementation, {})
    km.set("n", "gr", vim.lsp.buf.references, {})
    km.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    km.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    km.set("n", "<leader>fm", function() vim.lsp.buf.format { async = true } end, opts)
  end,
})

local cmp = require("cmp")
cmp.setup({
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
  }
})


-- =================== UI/Editor Settings =====================
-- Core Options
local opt = vim.opt
local g = vim.g

opt.mouse = "a"
opt.number = true
opt.relativenumber = false
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false
opt.clipboard:append("unnamedplus")
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.termguicolors = true
opt.textwidth = 70
opt.formatoptions:append("t")
opt.backspace = { "indent", "eol", "start" }
opt.showmatch = true
opt.history = 1000
opt.undolevels = 1000
opt.grepprg = "ag"
-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

vim.cmd("colorscheme gruvbox")
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")

-- ===================== Utils ===============================
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})


-- ===================== Key Mappings =========================
-- Keymaps (delegated to mappings.lua)
require("mappings")

