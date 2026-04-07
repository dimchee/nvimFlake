return {
  "giusgad/pets.nvim",
  requires = {
    "giusgad/hologram.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function() require'pets'.setup {
    popup = {
      winblend = 100
    }
  }  end,
  -- disable = true
}
