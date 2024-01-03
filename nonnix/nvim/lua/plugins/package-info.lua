return {
  "vuki656/package-info.nvim",
  event = "BufRead package.json",
  opts = {
    package_manager = "pnpm",
    icons = function()
      local icons = require("extra.icons")

      return {
        style = {
          up_to_date = (" %s "):format(icons.misc.UpToDate),
          outdated = (" %s "):format(icons.misc.Outdated),
        },
      }
    end,
  },
}
