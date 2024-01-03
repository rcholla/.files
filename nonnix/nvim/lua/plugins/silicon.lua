return {
  "michaelrommel/nvim-silicon",
  cmd = "Silicon",
  opts = function()
    return {
      font = "FiraCode Nerd Font Mono=34",
      theme = "CatppuccinMocha",
      background = C.lavender,
      output = function()
        return ("%s/Pictures/silicon-%s.png"):format(os.getenv("HOME"), os.date("!%Y-%m-%dT%H-%M-%S"))
      end,
    }
  end,
}
