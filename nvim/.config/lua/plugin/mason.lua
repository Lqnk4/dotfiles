local M = {
  "williamboman/mason.nvim",
  lazy = true,
  cmd = {
    "Mason", "MasonUpdate", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog"
  },
  config = function()
    require('mason').setup({})
  end,

}

return M
