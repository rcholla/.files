return {
  "michaelrommel/nvim-silicon",
  cmd = "Silicon",
  opts = function()
    local C = require("ori.plugins.colorschemes.palettes.handlers").palette()

    return {
      font = "FiraCode Nerd Font Mono=34",
      theme = "CatppuccinMocha",
      background = C.color13,
      output = function()
        return ("%s/Pictures/silicon-%s.png"):format(os.getenv("HOME"), os.date("!%Y-%m-%dT%H-%M-%S"))
      end,
    }
  end,
}
