-- init.lua

-- ================= Plugin List ===================
local plugins = {
  -- LSP & Completion
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

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
  { "nvim-lualine/lualine.nvim" },

  -- Colorscheme
  { "ellisonleao/gruvbox.nvim" },
  { "joshdick/onedark.vim" },
  { "rose-pine/neovim" },
  { "gbprod/nord.nvim" },
  { "dracula/vim" },
  { "catppuccin/nvim" },

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

  -- Git wrapper inside Nvim
  { "tpope/vim-fugitive" },

  -- Git Gutter
  { "lewis6991/gitsigns.nvim" },

  { 
    "sphamba/smear-cursor.nvim",
    opts = {
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space = true,
      legacy_computing_symbols_support = false,
      smear_insert_mode = true,
      stiffness = 0.8,
      trailing_stiffness = 0.4,
      stiffness_insert_mode = 0.7,
      trailing_stiffness_insert_mode = 0.7,
      damping = 0.95,
      damping_insert_mode = 0.95,
      distance_stop_animating = 0.5,
    }
  },

  { "sindrets/diffview.nvim" },
  { "amitds1997/remote-nvim.nvim", },
  { "ThePrimeagen/vim-be-good" },
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
require("telescope").setup({
  -- defaults = {
  --   vimgrep_arguments = {
  --     'rg', '--nocolor', '--nogroup', '--column'
  --   },
  -- },
  pickers = {
    man_pages = {
      man_cmd = { "man" }
    }
  },
})


-- Lualine
require("lualine").setup({ 
    -- options = { theme = 'gruvbox', } 
})

-- Comment.nvim
require("Comment").setup()

require("rose-pine").setup({
  styles = { transparency = true, },
})

require('gitsigns').setup{
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk)
    map('n', '<leader>hr', gitsigns.reset_hunk)

    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('n', '<leader>hp', gitsigns.preview_hunk)
    map('n', '<leader>hi', gitsigns.preview_hunk_inline)

    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end)

    map('n', '<leader>hd', gitsigns.diffthis)

    map('n', '<leader>hD', function()
      gitsigns.diffthis('~')
    end)

    map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
    map('n', '<leader>hq', gitsigns.setqflist)

    -- Toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    map('n', '<leader>tw', gitsigns.toggle_word_diff)

    -- Text object
    map({'o', 'x'}, 'ih', gitsigns.select_hunk)
  end
}

require("remote-nvim").setup()

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
    
  -- zls (Zig)
  vim.lsp.config('zls', {
    cmd = { "zls" },
    capabilities = capabilities,
    settings = {
      zls = {
        enable_inlay_hints = true,
        inlay_hints_show_builtin = true,
        include_at_in_builtins = false,
        warn_style = true,
      },
    },
  })
  vim.lsp.enable('zls')

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
    { name = 'luasnip' },
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

if vim.fn.has('win32') == 1 then
  vim.opt.shell        = "C:\\Progra~1\\Git\\usr\\bin\\bash.exe"
  vim.opt.shellcmdflag = "-l -c"          -- Git Bash uses -c, NOT /s /c
  vim.opt.shellquote   = "'"
  vim.opt.shellxquote  = ""          -- wrap command in quotes for Git Bash
  vim.opt.shellpipe    = "2>&1 | tee"
  vim.opt.shellredir   = ">%s 2>&1"
  vim.opt.shellslash   = true   -- ← converts \ to / in Neovim-generated paths
end

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

g.netrw_tmpfile_escape = ''
-- ===================== Key Mappings =========================
-- Keymaps (delegated to mappings.lua)
require("mappings")
require("snippets")
