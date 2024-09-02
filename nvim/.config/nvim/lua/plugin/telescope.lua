local M = {
  'nvim-telescope/telescope.nvim', branch = '0.1.x',
  lazy = true,
  dependencies = {'nvim-lua/plenary.nvim'},
  keys = function()
    local builtin = require('telescope.builtin')
    return {
      { "<leader>pf", builtin.find_files, { find_command = {'rg', '--files', '--hidden', '-g', '!.git' }}},
      { "<C-p>", builtin.git_files, {}},
      { "<leader>pb", builtin.buffers, {}},
      { "<leader>ps", builtin.live_grep, {}},
      { "<leader>pd", builtin.diagnostics, {}},
    }
  end,
}

return M


