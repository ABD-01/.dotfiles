local M = {}

M.jk = {
  i = {
     ["jk"] = { "<ESC>", "escape insert mode" , opts = { nowait = true }},
  }
}

M.generalcustom = {
  n = {
    -- switch between windows
    ["<leader>h"] = { "<C-w>h", "Window left" },
    ["<leader>l"] = { "<C-w>l", "Window right" },
    ["<leader>j"] = { "<C-w>j", "Window down" },
    ["<leader>k"] = { "<C-w>k", "Window up" },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- theme switcher
    ["<leader>tt"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },
  },
}

M.nvterm = {
  plugin = true,

  n = {
    -- new
    ["<leader>th"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "New horizontal term",
    },

    ["<leader>tv"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "New vertical term",
    },
  },
}

return M
