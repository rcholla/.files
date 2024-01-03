return {
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
}
