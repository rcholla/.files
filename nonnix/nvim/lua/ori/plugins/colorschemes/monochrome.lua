return {
  "kdheepak/monochrome.nvim",
  cmd = "Monochrome",
  config = function()
    vim.api.nvim_create_user_command("Monochrome", function()
      require("ori.plugins.colorschemes.palettes.handlers").switch("monochrome", {
        reload_effected_plugins = true,
      })
    end, {})
  end,
}
