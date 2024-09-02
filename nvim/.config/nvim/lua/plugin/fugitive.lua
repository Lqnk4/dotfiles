local M = {
  'tpope/vim-fugitive',
  lazy = false,
  keys = {
    { '<leader>gs', vim.cmd.Git },
  },
  cmd = { "G", "Git", "GdiffSplit", "Gvdiffsplit", "Gedit", "Gsplit",
      "Gread", "Gwrite", "Ggrep", "Glgrep", "Gmove",
      "Gdelete", "Gremove", "Gbrowse", }
}

return M

