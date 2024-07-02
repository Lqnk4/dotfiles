local M = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim' },
  lazy = true,
  config = function()
    local harpoon = require('harpoon')
    harpoon:setup({})

  end,

  keys = function()

    local function toggle_telescope(harpoon_files)

    -- basic telescope configuration
    local conf = require("telescope.config").values
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end
    local harpoon = require('harpoon')
    return {
      { "<leader>a", function() harpoon:list():add() end },
      { "<C-d>",     function() harpoon.ui:toggle_quick_menu(harpoon:list()) end },

      { "<C-h>",     function() harpoon:list():select(1) end },
      { "<C-j>",     function() harpoon:list():select(2) end },
      { "<C-k>",     function() harpoon:list():select(3) end },
      { "<C-l>",     function() harpoon:list():select(4) end },

      { "<C-e>", function() toggle_telescope(harpoon:list()) end,
        { desc = "Open harpoon window" } },
    }
  end,
}


return M
