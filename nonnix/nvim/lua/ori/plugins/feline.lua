return {
  "freddiehaddad/feline.nvim",
  event = "VeryLazy",
  dependencies = {
    "SmiteshP/nvim-navic",
    "chrisgrieser/nvim-recorder",
    "lewis6991/gitsigns.nvim",
  },
  opts = function()
    local C = require("ori.plugins.colorschemes.palettes.handlers").palette()
    local icons = require("ori.lib.icons")
    local utils = require("ori.lib.utils")
    local recorder = require("recorder")
    local navic = require("nvim-navic")

    local colors = {
      mode = {
        ["n"] = { "NORMAL", C.color13 },
        ["no"] = { "N-PENDING", C.color13 },
        ["i"] = { "INSERT", C.color08 },
        ["ic"] = { "INSERT", C.color08 },
        ["t"] = { "TERMINAL", C.color08 },
        ["v"] = { "VISUAL", C.color01 },
        ["V"] = { "V-LINE", C.color01 },
        [""] = { "V-BLOCK", C.color01 },
        ["R"] = { "REPLACE", C.color05 },
        ["Rv"] = { "V-REPLACE", C.color05 },
        ["s"] = { "SELECT", C.color05 },
        ["S"] = { "S-LINE", C.color05 },
        [""] = { "S-BLOCK", C.color05 },
        ["c"] = { "COMMAND", C.color06 },
        ["cv"] = { "COMMAND", C.color06 },
        ["ce"] = { "COMMAND", C.color06 },
        ["r"] = { "PROMPT", C.color09 },
        ["rm"] = { "MORE", C.color09 },
        ["r?"] = { "CONFIRM", C.color03 },
        ["!"] = { "SHELL", C.color08 },
      },
      section = {
        statusline = { bg = C.color24 },
        file = {
          fg = C.color25,
          type = { fg = C.color17 },
          encoding = { bg = C.color00 },
          format = { bg = C.color00 },
          info = { bg = C.color05 },
        },
        git = {
          fg = C.color25,
          branch = { bg = C.color03 },
          added = { bg = C.color08 },
          modified = { bg = C.color07 },
          removed = { bg = C.color04 },
        },
        diagnostics = {
          fg = C.color25,
          error = { bg = C.color04 },
          warning = { bg = C.color08 },
          hint = { bg = C.color10 },
          info = { bg = C.color12 },
        },
        mode = { fg = C.color25 },
        macros = { fg = C.color08 },
        cursor = { fg = C.color25, bg = C.color01 },
      },
    }

    local components = {
      file = {
        type = {
          provider = function()
            return (" %s %s"):format(icons.misc.Neovim, vim.bo.ft:upper())
          end,
          enabled = utils.buf.is_inactive_buffer,
          hl = {
            fg = colors.section.file.type.fg,
            bg = colors.section.statusline.bg,
            style = "bold",
          },
        },

        encoding = {
          provider = "file_encoding",
          enabled = function()
            return utils.win.width_greater_than(180)
          end,
          hl = {
            fg = colors.section.file.fg,
            bg = colors.section.file.encoding.bg,
            style = "bold",
          },
          left_sep = {
            str = "",
            hl = {
              fg = colors.section.file.encoding.bg,
              bg = colors.section.diagnostics.info.bg,
            },
          },
          right_sep = {
            str = "  ",
            hl = {
              fg = colors.section.file.fg,
              bg = colors.section.file.encoding.bg,
            },
          },
        },

        format = {
          provider = "file_format",
          enabled = function()
            return utils.win.width_greater_than(180)
          end,
          hl = {
            fg = colors.section.file.fg,
            bg = colors.section.file.format.bg,
            style = "bold",
          },
          right_sep = { str = "██" },
        },

        info = {
          provider = {
            name = "file_info",
            opts = {
              type = "unique-short",
              file_modified_icon = "",
              file_readonly_icon = "",
              colored_icon = false,
            },
          },
          hl = {
            fg = colors.section.file.fg,
            bg = colors.section.file.info.bg,
            style = "bold",
          },
          left_sep = {
            str = "",
            hl = function()
              return {
                fg = colors.section.file.info.bg,
                bg = utils.win.width_greater_than(180) and colors.section.file.format.bg
                  or colors.section.diagnostics.info.bg,
              }
            end,
          },
          right_sep = {
            str = "  ",
            hl = {
              fg = colors.section.cursor.bg,
              bg = colors.section.file.info.bg,
            },
          },
        },
      },

      git = {
        branch = {
          provider = function()
            return (" %s %s "):format(icons.git.Branch, vim.b.gitsigns_head)
          end,
          enabled = function()
            return require("feline.providers.git").git_info_exists()
              and not utils.any.is_nil_or_empty(vim.b.gitsigns_head)
          end,
          hl = {
            fg = colors.section.git.fg,
            bg = colors.section.git.branch.bg,
            style = "bold",
          },
          left_sep = {
            str = "",
            hl = {
              fg = colors.section.git.branch.bg,
              bg = colors.section.statusline.bg,
            },
          },
        },

        added = {
          provider = function()
            local count = utils.git.get_diff("added")

            return tonumber(count) ~= 0 and (" %s %s "):format(icons.git.Added, count)
              or (" %s "):format(icons.git.Added)
          end,
          enabled = require("feline.providers.git").git_info_exists,
          hl = {
            fg = colors.section.git.fg,
            bg = colors.section.git.added.bg,
            style = "bold",
          },
          left_sep = {
            str = function()
              return not utils.any.is_nil_or_empty(vim.b.gitsigns_head) and "" or ""
            end,
            hl = function()
              return {
                fg = not utils.any.is_nil_or_empty(vim.b.gitsigns_head) and colors.section.git.branch.bg
                  or colors.section.git.added.bg,
                bg = not utils.any.is_nil_or_empty(vim.b.gitsigns_head) and colors.section.git.added.bg
                  or colors.section.statusline.bg,
              }
            end,
          },
        },

        modified = {
          provider = function()
            local count = utils.git.get_diff("changed")

            return tonumber(count) ~= 0 and (" %s %s "):format(icons.git.Modified, count)
              or (" %s "):format(icons.git.Modified)
          end,
          enabled = require("feline.providers.git").git_info_exists,
          hl = {
            fg = colors.section.git.fg,
            bg = colors.section.git.modified.bg,
            style = "bold",
          },
          left_sep = {
            str = "",
            hl = {
              fg = colors.section.git.added.bg,
              bg = colors.section.git.modified.bg,
            },
            always_visible = true,
          },
        },

        removed = {
          provider = function()
            local count = utils.git.get_diff("removed")

            return tonumber(count) ~= 0 and (" %s %s "):format(icons.git.Deleted, count)
              or (" %s "):format(icons.git.Deleted)
          end,
          enabled = require("feline.providers.git").git_info_exists,
          hl = {
            fg = colors.section.git.fg,
            bg = colors.section.git.removed.bg,
            style = "bold",
          },
          left_sep = {
            str = "",
            hl = {
              fg = colors.section.git.modified.bg,
              bg = colors.section.git.removed.bg,
            },
            always_visible = true,
          },
          right_sep = {
            str = "",
            hl = {
              fg = colors.section.git.removed.bg,
              bg = colors.section.statusline.bg,
            },
            always_visible = true,
          },
        },
      },

      diagnostics = {
        error = {
          provider = function()
            local count = utils.diag.get_diagnostic(vim.diagnostic.severity.ERROR)

            return tonumber(count) ~= 0 and (" %s %s "):format(icons.diagnostics.Error, count) or ""
          end,
          hl = {
            fg = colors.section.diagnostics.fg,
            bg = colors.section.diagnostics.error.bg,
            style = "bold",
          },
          left_sep = {
            str = "",
            hl = {
              fg = colors.section.diagnostics.error.bg,
              bg = colors.section.statusline.bg,
            },
            always_visible = true,
          },
          right_sep = {
            str = "",
            hl = {
              fg = colors.section.diagnostics.warning.bg,
              bg = colors.section.diagnostics.error.bg,
            },
            always_visible = true,
          },
        },

        warning = {
          provider = function()
            local count = utils.diag.get_diagnostic(vim.diagnostic.severity.WARN)

            return tonumber(count) ~= 0 and (" %s %s "):format(icons.diagnostics.Warn, count) or ""
          end,
          hl = {
            fg = colors.section.diagnostics.fg,
            bg = colors.section.diagnostics.warning.bg,
            style = "bold",
          },
          right_sep = {
            str = "",
            hl = {
              fg = colors.section.diagnostics.hint.bg,
              bg = colors.section.diagnostics.warning.bg,
            },
            always_visible = true,
          },
        },

        hint = {
          provider = function()
            local count = utils.diag.get_diagnostic(vim.diagnostic.severity.HINT)

            return tonumber(count) ~= 0 and (" %s %s "):format(icons.diagnostics.Hint, count) or ""
          end,
          hl = {
            fg = colors.section.diagnostics.fg,
            bg = colors.section.diagnostics.hint.bg,
            style = "bold",
          },
          right_sep = {
            str = "",
            hl = {
              fg = colors.section.diagnostics.info.bg,
              bg = colors.section.diagnostics.hint.bg,
            },
            always_visible = true,
          },
        },

        info = {
          provider = function()
            local count = utils.diag.get_diagnostic(vim.diagnostic.severity.INFO)

            return tonumber(count) ~= 0 and (" %s %s "):format(icons.diagnostics.Info, count) or ""
          end,
          hl = {
            fg = colors.section.diagnostics.fg,
            bg = colors.section.diagnostics.info.bg,
            style = "bold",
          },
        },
      },

      mode = {
        provider = function()
          return (" %s %s "):format(icons.misc.Neovim, colors.mode[vim.fn.mode()][1])
        end,
        enabled = function()
          return not utils.buf.is_inactive_buffer()
        end,
        hl = function()
          return {
            fg = colors.section.mode.fg,
            bg = colors.mode[vim.fn.mode()][2],
            style = "bold",
          }
        end,
        right_sep = function()
          return {
            str = "",
            hl = {
              fg = colors.mode[vim.fn.mode()][2],
              bg = colors.section.statusline.bg,
            },
          }
        end,
      },

      navic = {
        provider = function()
          return ("  %s"):format(navic.get_location())
        end,
        enabled = function()
          return navic.is_available() and utils.win.width_greater_than(150)
        end,
        hl = { bg = colors.section.statusline.bg },
      },

      space = {
        hl = {
          fg = colors.section.statusline.bg,
          bg = colors.section.statusline.bg,
        },
      },

      macros = {
        provider = function()
          return ("%s  "):format(recorder.recordingStatus())
        end,
        enabled = function()
          return utils.win.width_greater_than(150) and not utils.any.is_nil_or_empty(recorder.recordingStatus())
        end,
        hl = function()
          return {
            fg = colors.mode[vim.fn.mode()][2],
            bg = colors.section.statusline.bg,
          }
        end,
      },

      position = {
        provider = "position",
        icon = ("%s "):format(icons.misc.Position),
        hl = {
          fg = colors.section.cursor.fg,
          bg = colors.section.cursor.bg,
          style = "bold",
        },
        right_sep = {
          str = "  ",
          hl = { bg = colors.section.cursor.bg },
        },
      },

      line_percentage = {
        provider = function()
          local curr_line, lines = vim.api.nvim_win_get_cursor(0)[1], vim.api.nvim_buf_line_count(0)

          if curr_line == 1 then
            return "  Top  "
          elseif curr_line == lines then
            return "  Bot  "
          else
            return ("  %2d%%%%  "):format(math.ceil(curr_line / lines * 99))
          end
        end,
        hl = {
          fg = colors.section.cursor.fg,
          bg = colors.section.cursor.bg,
          style = "bold",
        },
        left_sep = {
          str = "",
          hl = {
            fg = colors.section.cursor.fg,
            bg = colors.section.cursor.bg,
          },
        },
      },

      scroll_bar = {
        provider = "scroll_bar",
        hl = {
          fg = colors.section.cursor.fg,
          bg = colors.section.cursor.bg,
        },
        right_sep = {
          str = "█",
          hl = { fg = colors.section.cursor.bg },
        },
      },
    }

    return {
      components = {
        active = {
          {
            components.file.type,
            components.mode,
            components.git.branch,
            components.git.added,
            components.git.modified,
            components.git.removed,
            components.navic,
            components.space,
          },
          {
            components.macros,
            components.diagnostics.error,
            components.diagnostics.warning,
            components.diagnostics.hint,
            components.diagnostics.info,
            components.file.encoding,
            components.file.format,
            components.file.info,
            components.position,
            components.line_percentage,
            components.scroll_bar,
          },
        },
        inactive = {
          {
            components.file.type,
          },
        },
      },
    }
  end,
}
