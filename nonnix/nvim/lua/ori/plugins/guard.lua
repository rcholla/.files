return {
  "rcholla/guard.nvim",
  branch = "need-silence",
  event = "VeryLazy",
  keys = { { "<C-f>", "<CMD>GuardFmt<CR>", mode = { "n", "i", "v" } } },
  dependencies = {
    { "rcholla/guard-collection", branch = "nix" },
  },
  opts = {
    fmt_on_save = false,
    lsp_as_default_formatter = false,
    excluded_opts = { "excluded_opts", "ft" }, -- custom option
    ft = {}, -- custom option
  },
  config = function(_, opts)
    local utils = require("ori.lib.utils")

    for _, value in pairs(opts.ft) do
      local tool = require("guard.filetype")(value[1])

      if not utils.any.is_nil_or_empty(value.fmt) then
        tool:fmt(value.fmt)
      end

      if not utils.any.is_nil_or_empty(value.lint) then
        tool:lint(value.lint)
      end
    end

    require("guard").setup(utils.tbl.exclude(opts, opts.excluded_opts))
  end,
}
