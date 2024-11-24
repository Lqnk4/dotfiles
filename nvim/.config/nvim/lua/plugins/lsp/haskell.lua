return {

  -- Add Haskell to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "haskell" } },
  },

  {
    "mrcjkb/haskell-tools.nvim",
    version = "^3",
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    -- dependencies = {
    --   { "nvim-telescope/telescope.nvim", optional = true },
    -- },
    -- config = function()
    --   local ok, telescope = pcall(require, "telescope")
    --   if ok then
    --     telescope.load_extension("ht")
    --   end
    -- end,
  },

  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "haskell-language-server" } },
  },

  {
    "mrcjkb/haskell-snippets.nvim",
    dependencies = { "L3MON4D3/LuaSnip" },
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    config = function()
      local haskell_snippets = require("haskell-snippets").all
      require("luasnip").add_snippets("haskell", haskell_snippets, { key = "haskell" })
    end,
  },

  -- Make sure lspconfig doesn't start hls,
  -- as it conflicts with haskell-tools
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        hls = function()
          return true
        end,
      },
    },
  },
}
