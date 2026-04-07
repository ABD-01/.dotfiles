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

  -- Nerd tree
  {
    "preservim/nerdtree",
    cmd = { "NERDTreeToggle", "NERDTreeFind" },
    keys = {
      { "<C-n>", "<cmd>NERDTreeToggle<CR>", desc = "Toggle NERDTree" },
      { "<leader>ff", "<cmd>NERDTreeFind<CR>", desc = "Find current file in NERDTree" },
    },
    init = function()
      vim.g.NERDTreeShowHidden = 1
      vim.g.NERDTreeMinimalUI = 1
      vim.g.NERDTreeQuitOnOpen = 1
      vim.g.NERDTreeIgnore = {
        '^node_modules$',
        '\\~$',
        '.o$',
        'bower_components',
        'node_modules',
        '__pycache__',
      }

      vim.api.nvim_create_autocmd("BufEnter", {
        command = "if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif",
      })
    end,
  },

  -- Status line
  -- { "nvim-lualine/lualine.nvim" },

  -- Colorscheme
  { "ellisonleao/gruvbox.nvim" },
  { "joshdick/onedark.vim" },
  { "rose-pine/neovim" },
  { "gbprod/nord.nvim" },

  -- Nerdcommenter alternative
  { "numToStr/Comment.nvim" },

  { "eandrju/cellular-automaton.nvim" },

  -- Multi cursor (same plugin as vim)
  {
    "mg979/vim-visual-multi",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"]         = "<C-x>",
        ["Find Subword Under"] = "<C-x>",
      }
    end,
  },
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

vim.cmd("colorscheme gruvbox")
-- vim.opt.background = "dark"

-- Telescope Setup
require("telescope").setup()
-- require("telescope").setup({
--   defaults = {
--     vimgrep_arguments = {
--       'rg', '--nocolor', '--nogroup', '--column'
--     },
--   },
-- })


-- Lualine
-- require("lualine").setup()

-- Comment.nvim
require("Comment").setup()

require("rose-pine").setup({
  styles = { transparency = true, },
})

-- =============== LSP + Autocompletion ===================
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Use Neovim 0.11+ LspAttach autocmd instead of on_attach callback
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr }
    local km = vim.keymap
    
    km.set("n", "gd", vim.lsp.buf.definition, opts)
    km.set("n", "gD", vim.lsp.buf.declaration, opts)
    km.set("n", "gi", vim.lsp.buf.implementation, opts)
    km.set("n", "gr", vim.lsp.buf.references, opts)
    km.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    km.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    km.set("n", "<leader>fm", function() vim.lsp.buf.format { async = true } end, opts)
    km.set("n", "K", vim.lsp.buf.hover, opts)

    km.set("n", "<leader>e", vim.diagnostic.open_float, opts)
    km.set("n", "[d", vim.diagnostic.goto_prev, opts)
    km.set("n", "]d", vim.diagnostic.goto_next, opts)
  end,
})

-- Register and enable servers using Neovim 0.11+ style
-- This avoids the deprecated require('lspconfig').setup() framework
if vim.lsp.config then
  -- clangd
  vim.lsp.config('clangd', {
    cmd = { "C:/Users/muhsha/AppData/Local/llvm-mingw-20260324-ucrt-aarch64/bin/clangd.exe" },
    capabilities = capabilities,
  })
  vim.lsp.enable('clangd')

  -- cmake
  vim.lsp.config('cmake', {
    capabilities = capabilities,
  })
  vim.lsp.enable('cmake')

  -- rust-analyzer
  vim.lsp.config('rust_analyzer', {
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        check = { command = "clippy" },
      },
    },
  })
  vim.lsp.enable('rust_analyzer')
else
  -- Fallback for versions < 0.11 if needed
  local lspconfig = require("lspconfig")
  local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    local km = vim.keymap
    km.set("n", "gd", vim.lsp.buf.definition, opts)
    -- ... other mappings omitted for brevity in fallback ...
  end
  lspconfig.clangd.setup({ cmd = { "C:/Users/muhsha/AppData/Local/llvm-mingw-20260324-ucrt-aarch64/bin/clangd.exe" }, capabilities = capabilities, on_attach = on_attach })
  lspconfig.cmake.setup({ capabilities = capabilities, on_attach = on_attach })
end

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
opt.scrolloff = 8
opt.grepprg = "rg --vimgrep --no-heading"
opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
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

