return {
  "3rd/image.nvim",
  ft = { "jpg", "jpeg", "png", "gif", "webp", "markdown" },
  opts = {
    backend = "kitty",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = true,
        only_render_image_at_cursor = false,
      },
    },
  },
}
