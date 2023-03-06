return {
  'marcelofern/vale.nvim',
  config = function()
    require 'vale'.setup {
      -- path to the vale binary.
      bin = 'vale',
      -- path to your vale-specific configuration.
      vale_config_path = '$HOME/.config/vale/vale.ini',
    }
  end
}
