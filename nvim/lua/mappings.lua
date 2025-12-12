-- mappings.lua
vim.g.mapleader = " "
local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }

local mappings = {
  n = {
    [";"] = { ":", "Command mode" },

    ["<leader>x"] = { ":bd<CR>", "Close buffer" },

    ["<leader>rn"] = { ":set rnu!<CR>", "Toggle relative number" },

    ["<leader>Q"] = { ":q!<CR>", "Force quit" },
    ["<leader>w"] = { ":w<CR>", "Save" },

    ["<leader>fn"] = { [[:let @* = expand("%")<CR>]], "Copy filename" },
    ["<leader>fp"] = { [[:let @* = expand("%:p")<CR>]], "Copy full path" },

    ["<C-h>"] = { "<C-w>h", "Move to left split" },
    ["<C-j>"] = { "<C-w>j", "Move to below split" },
    ["<C-k>"] = { "<C-w>k", "Move to above split" },
    ["<C-l>"] = { "<C-w>l", "Move to right split" },

    ["<C-n>"] = { ":NvimTreeToggle<CR>", "Toggle File Tree" },
    ["<leader>ff"] = { ":NvimTreeFindFile<CR>", "Reveal File in Tree" },

    -- File/buffer navigation
    ["<C-p>"] = { ":Telescope find_files<CR>", "Fuzzy file finder" },
    ["<C-f>"] = { ":Telescope live_grep<CR>", "Live grep search" },
    ["<C-b>"] = { ":Telescope buffers<CR>", "List buffers" },

    -- Git
    ["<leader>gs"] = { ":Telescope git_status<CR>", "Git status" },
    ["<leader>gc"] = { ":Telescope git_commits<CR>", "Git commits (log)" },
    ["<leader>gb"] = { ":Telescope git_branches<CR>", "Git branches" },

    -- LSP and Help
    ["<leader>ld"] = { ":Telescope diagnostics<CR>", "LSP Diagnostics" },
    ["<leader>lh"] = { ":Telescope help_tags<CR>", "Search help tags" },

    -- FML
    ["<leader>fml"] = { "<cmd>CellularAutomaton make_it_rain<CR>", "Make it Rain" }, 
  },

  i = {
    ["jk"] = { "<ESC>", "Escape insert mode", opts = { nowait = true } },
  },

  v = {
    ["<Tab>"] = { ">", "Indent" },
    ["<S-Tab>"] = { "<", "Un-indent" },
  },

  t = {
    ["<C-h>"] = { "<C-\\><C-N><C-w>h", "Move left in terminal" },
    ["<C-j>"] = { "<C-\\><C-N><C-w>j", "Move down in terminal" },
    ["<C-k>"] = { "<C-\\><C-N><C-w>k", "Move up in terminal" },
    ["jk"] = { "<C-\\><C-N>", "Exit terminal mode" },
  },
}

for mode, binds in pairs(mappings) do
  for lhs, rhs in pairs(binds) do
    local rhs_cmd, _desc = unpack(rhs)
    map(mode, lhs, rhs_cmd, default_opts)
  end
end

return mappings

