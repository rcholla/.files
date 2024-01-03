return {
  "noib3/nvim-cokeline",
  event = "VeryLazy",
  keys = {
    {
      "<S-h>",
      function()
        require("cokeline.mappings").by_step("focus", -1)
      end,
    },
    {
      "<S-l>",
      function()
        require("cokeline.mappings").by_step("focus", 1)
      end,
    },
    {
      "<A-h>",
      function()
        require("cokeline.mappings").by_step("switch", -1)
      end,
    },
    {
      "<A-l>",
      function()
        require("cokeline.mappings").by_step("switch", 1)
      end,
    },
  },
  opts = function()
    local C = require("ori.plugins.colorschemes.palettes.handlers").palette()
    local icons = require("ori.lib.icons")
    local mappings = require("cokeline.mappings")
    local get_hex = require("cokeline.hlgroups").get_hl_attr

    local fg = {
      error = get_hex("DiagnosticError", "fg"),
      warning = get_hex("DiagnosticWarn", "fg"),
      comment = get_hex("Comment", "fg"),
    }

    local components = {
      space = {
        text = " ",
        truncation = { priority = 1 },
      },

      two_spaces = {
        text = "  ",
        truncation = { priority = 1 },
      },

      separator = {
        text = function(buffer)
          return buffer.index ~= 1 and "▏" or ""
        end,
        truncation = { priority = 1 },
      },

      devicon = {
        text = function(buffer)
          return (mappings.is_picking_focus() or mappings.is_picking_close()) and ("%s "):format(buffer.pick_letter)
            or buffer.devicon.icon
        end,
        fg = function(buffer)
          return (mappings.is_picking_focus() and C.color07)
            or (mappings.is_picking_close() and C.color04)
            or buffer.devicon.color
        end,
        style = function(_)
          return (mappings.is_picking_focus() or mappings.is_picking_close()) and "italic,bold" or nil
        end,
        truncation = { priority = 1 },
      },

      index = {
        text = function(buffer)
          return ("%s: "):format(buffer.index)
        end,
        fg = function(buffer)
          return (buffer.diagnostics.errors ~= 0 and fg.error)
            or (buffer.diagnostics.warnings ~= 0 and fg.warning)
            or nil
        end,
        truncation = { priority = 1 },
      },

      unique_prefix = {
        text = function(buffer)
          return buffer.unique_prefix
        end,
        fg = fg.comment,
        style = "italic",
        truncation = {
          priority = 3,
          direction = "left",
        },
      },

      filename = {
        text = function(buffer)
          return buffer.filename
        end,
        fg = function(buffer)
          return (buffer.diagnostics.errors ~= 0 and fg.error)
            or (buffer.diagnostics.warnings ~= 0 and fg.warning)
            or nil
        end,
        style = function(buffer)
          return ((buffer.is_focused and buffer.diagnostics.errors ~= 0) and "bold,underline")
            or (buffer.is_focused and "bold")
            or (buffer.diagnostics.errors ~= 0 and "underline")
            or nil
        end,
        truncation = {
          priority = 2,
          direction = "left",
        },
      },

      diagnostics = {
        text = function(buffer)
          return (
            buffer.diagnostics.errors ~= 0 and (" %s %s"):format(icons.diagnostics.Error, buffer.diagnostics.errors)
          )
            or (buffer.diagnostics.warnings ~= 0 and (" %s %s"):format(
              icons.diagnostics.Warn,
              buffer.diagnostics.warnings
            ))
            or ""
        end,
        fg = function(buffer)
          return (buffer.diagnostics.errors ~= 0 and fg.error)
            or (buffer.diagnostics.warnings ~= 0 and fg.warning)
            or nil
        end,
        truncation = { priority = 1 },
      },

      close_or_modified = {
        text = function(buffer)
          return buffer.is_modified and icons.misc.Modified or icons.misc.Close
        end,
        fg = function(buffer)
          return buffer.is_modified and C.color07 or C.color04
        end,
        delete_buffer_on_left_click = true,
        truncation = { priority = 1 },
      },
    }

    return {
      show_if_buffers_are_at_least = 1,
      buffers = { new_buffers_position = "next" },
      rendering = { max_buffer_width = 30 },
      default_hl = {
        fg = function(buffer)
          return buffer.is_focused and get_hex("Normal", "fg") or fg.comment
        end,
      },
      components = {
        components.space,
        components.separator,
        components.space,
        components.devicon,
        components.space,
        components.index,
        components.unique_prefix,
        components.filename,
        components.diagnostics,
        components.two_spaces,
        components.close_or_modified,
        components.space,
      },
    }
  end,
}
