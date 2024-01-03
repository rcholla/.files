return {
  "nvimdev/guard.nvim",
  event = "VeryLazy",
  keys = { { "<C-f>", "<CMD>GuardFmt<CR>", mode = { "n", "i", "v" } } },
  dependencies = { { "rcholla/guard-collection", branch = "nix" } },
  opts = {
    fmt_on_save = false,
    lsp_as_default_formatter = false,
  },
  config = function(_, opts)
    local ft = require("guard.filetype")

    ft("nix"):fmt("nixpkgs-fmt"):lint("statix")

    ft("bash,csh,ksh,sh,zsh"):fmt("shfmt"):lint("shellcheck")

    ft("lua"):fmt("stylua"):lint("luacheck")

    ft("html,css,scss,javascript,javascriptreact,typescript,typescriptreact,svelte,json,jsonc,yaml,markdown"):fmt({
      cmd = "prettierd",
      fname = true,
      stdin = true,
    })

    ft("javascript,javascriptreact,typescript,typescriptreact,svelte"):lint("eslint_d")

    ft("go"):fmt("gofumpt"):lint("golangci_lint")

    ft("rust"):fmt("rustfmt")

    ft("toml"):fmt("taplo")

    ft("haskell"):fmt("ormolu"):lint("hlint")

    local sqlfluff = ft("sql"):fmt("sqlfluff"):lint("sqlfluff")
    sqlfluff.formatter[1].args = vim.list_extend(sqlfluff.formatter[1].args, { "--dialect", "postgres" })
    sqlfluff.linter[1].args = vim.list_extend(sqlfluff.linter[1].args, { "--dialect", "postgres" })

    require("guard").setup(opts)
  end,
}
