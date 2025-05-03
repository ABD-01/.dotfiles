local M = {}

M.general = {
  n = {
    [";"] = { ":", "Command mode" },
    ["<leader>fn"] = { [[:let @* = expand("%")<CR>]], "Copy filename" },
    ["<leader>fp"] = { [[:let @* = expand("%:p")<CR>]], "Copy full path" },
  },

  i = {
    ["jk"] = { "<ESC>", "Escape insert mode" , opts = { nowait = true }},
    ["kk"] = { "<ESC>", "Escape insert mode" , opts = { nowait = true }},
  },

  v = {
    ["<Tab>"] = { ">", "Indent" },
    ["<S-Tab>"] = { "<", "Un-indent" },
  },
}

M.terminal = {
  t = {
    ["<C-h>"] = { "<C-\\><C-N><C-w>h", "Terminal move left" },
    ["<C-j>"] = { "<C-\\><C-N><C-w>j", "Terminal move down" },
    ["<C-k>"] = { "<C-\\><C-N><C-w>k", "Terminal move up" },
    ["<C-l>"] = { "<C-\\><C-N><C-w>l", "Terminal move right" }, -- uncomment if needed
    ["jk"]     = { "<C-\\><C-N>", "Escape terminal mode" },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- theme switcher
    ["<leader>tt"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },
  },
}

return M
