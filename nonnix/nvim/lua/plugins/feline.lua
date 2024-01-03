return {
  "freddiehaddad/feline.nvim",
  event = "VeryLazy",
  opts = function()
    local navic, recorder, icons, utils =
      require("nvim-navic"), require("recorder"), require("extra.icons"), require("extra.utils")

    local colors = {
      mode = {
        ["n"] = { "NORMAL", C.lavender },
        ["no"] = { "N-PENDING", C.lavender },
        ["i"] = { "INSERT", C.green },
        ["ic"] = { "INSERT", C.green },
        ["t"] = { "TERMINAL", C.green },
        ["v"] = { "VISUAL", C.flamingo },
        ["V"] = { "V-LINE", C.flamingo },
        [""] = { "V-BLOCK", C.flamingo },
        ["R"] = { "REPLACE", C.maroon },
        ["Rv"] = { "V-REPLACE", C.maroon },
        ["s"] = { "SELECT", C.maroon },
        ["S"] = { "S-LINE", C.maroon },
        [""] = { "S-BLOCK", C.maroon },
        ["c"] = { "COMMAND", C.peach },
        ["cv"] = { "COMMAND", C.peach },
        ["ce"] = { "COMMAND", C.peach },
        ["r"] = { "PROMPT", C.teal },
        ["rm"] = { "MORE", C.teal },
        ["r?"] = { "CONFIRM", C.mauve },
        ["!"] = { "SHELL", C.green },
      },
      section = {
        statusline = { bg = C.mantle },
        file = {
          fg = C.crust,
          type = { fg = C.overlay2 },
          encoding = { bg = C.rosewater },
          format = { bg = C.rosewater },
          info = { bg = C.maroon },
        },
        git = {
          fg = C.crust,
          branch = { bg = C.mauve },
          added = { bg = C.green },
          modified = { bg = C.yellow },
          removed = { bg = C.red },
        },
        diagnostics = {
          fg = C.crust,
          error = { bg = C.red },
          warning = { bg = C.yellow },
          hint = { bg = C.sky },
          info = { bg = C.blue },
        },
        mode = { fg = C.crust },
        macros = { fg = C.green },
        cursor = { fg = C.crust, bg = C.flamingo },
      },
    }

    local components = {
      file = {
        type = {
          provider = function()
            return (" %s %s"):format(icons.misc.Neovim, vim.bo.ft:upper())
          end,
          enabled = utils.is_inactive_buffer,
          hl = {
            fg = colors.section.file.type.fg,
            bg = colors.section.statusline.bg,
            style = "bold",
          },
        },

        encoding = {
          provider = "file_encoding",
          enabled = function()
            return utils.win_width_greater_than(180)
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
            return utils.win_width_greater_than(180)
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
                bg = utils.win_width_greater_than(180) and colors.section.file.format.bg
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
            return require("feline.providers.git").git_info_exists() and not utils.is_nil_or_empty(vim.b.gitsigns_head)
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
            local count = utils.git_diff("added")

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
              return not utils.is_nil_or_empty(vim.b.gitsigns_head) and "" or ""
            end,
            hl = function()
              return {
                fg = not utils.is_nil_or_empty(vim.b.gitsigns_head) and colors.section.git.branch.bg
                  or colors.section.git.added.bg,
                bg = not utils.is_nil_or_empty(vim.b.gitsigns_head) and colors.section.git.added.bg
                  or colors.section.statusline.bg,
              }
            end,
          },
        },

        modified = {
          provider = function()
            local count = utils.git_diff("changed")

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
            local count = utils.git_diff("removed")

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
            local count = utils.get_diagnostic(vim.diagnostic.severity.ERROR)

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
            local count = utils.get_diagnostic(vim.diagnostic.severity.WARN)

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
            local count = utils.get_diagnostic(vim.diagnostic.severity.HINT)

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
            local count = utils.get_diagnostic(vim.diagnostic.severity.INFO)

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
          return not utils.is_inactive_buffer()
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
          return navic.is_available() and utils.win_width_greater_than(150)
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
          return utils.win_width_greater_than(150) and not utils.is_nil_or_empty(recorder.recordingStatus())
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
