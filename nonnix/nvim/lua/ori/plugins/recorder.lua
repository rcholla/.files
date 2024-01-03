return {
  "chrisgrieser/nvim-recorder",
  keys = { "q", "Q", "cq", "<C-A-q>" },
  opts = {
    slots = { "a", "b" },
    mapping = {
      startStopRecording = "q",
      playMacro = "Q",
      editMacro = "cq",
      switchSlot = "<C-A-q>",
    },
    useNerdfontIcons = true,
  },
}
