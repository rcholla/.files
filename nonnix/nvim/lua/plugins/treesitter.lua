return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
  dependencies = {
    { "JoosepAlviste/nvim-ts-context-commentstring", opts = { enable_autocmd = false } },
    { "nvim-treesitter/nvim-treesitter-context", config = true },
    { "altermo/ultimate-autopair.nvim", opts = { tabout = { enable = true } } },
    { "axelvc/template-string.nvim", opts = { remove_template_string = true, restore_quotes = { normal = [["]] } } },
    { "windwp/nvim-ts-autotag", config = true },
  },
  opts = {
    ensure_installed = "all",
    highlight = {
      enable = true,
      disable = function(_, buf)
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        local max_filesize = 100 * 1024
        return ok and stats and stats.size > max_filesize
      end,
      additional_vim_regex_highlighting = { "markdown" },
    },
    indent = { enable = true, disable = { "yaml" } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-Space>",
        node_incremental = "<C-Space>",
        node_decremental = "<C-A-Space>",
      },
    },
  },
}
