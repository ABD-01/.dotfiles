local plugins = {

  {
    "marioortizmanero/adoc-pdf-live.nvim",
    config = function ()
      require('adoc_pdf_live').setup()
    end

  },  -- load a plugin at startup

  {
    "Exafunction/codeium.vim",
    lazy = false,
    config = function ()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end
  },

  {
    -- For diffview
    "sindrets/diffview.nvim"
  }
}

return plugins

