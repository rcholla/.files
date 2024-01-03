return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        nil_ls = {
          settings = {
            ["nil"] = {
              nix = {
                flake = {
                  autoArchive = true,
                },
              },
              diagnostics = {
                ignored = { "unused_binding" },
              },
            },
          },
        },
      },
    },
  },
  {
    "rcholla/guard.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ft = vim.list_extend(opts.ft, {
        { "nix", fmt = "nixpkgs-fmt", lint = "statix" },
      })
    end,
  },
  {
    "mrcjkb/telescope-manix",
    ft = "nix",
    config = function()
      require("ori.lib.utils.lazy").on_load("telescope.nvim", function()
        require("telescope").load_extension("manix")
      end)
    end,
  },
}
