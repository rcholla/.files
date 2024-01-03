return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = {
      integrations = { alpha = true },
    },
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = "nvim-telescope/telescope.nvim",
    opts = function()
      local dashboard, icons = require("alpha.themes.dashboard"), require("ori.lib.icons")

      dashboard.config.opts.noautocmd = true

      dashboard.section.header.opts.hl = "Include"
      dashboard.section.header.val = {
        [[                                                                         ]],
        [[                               :                                         ]],
        [[ L.                     ,;    t#,                                        ]],
        [[ EW:        ,ft       f#i    ;##W.              t                        ]],
        [[ E##;       t#E     .E#t    :#L:WE              Ej            ..       : ]],
        [[ E###t      t#E    i#W,    .KG  ,#D  t      .DD.E#,          ,W,     .Et ]],
        [[ E#fE#f     t#E   L#D.     EE    ;#f EK:   ,WK. E#t         t##,    ,W#t ]],
        [[ E#t D#G    t#E :K#Wfff;  f#.     t#iE#t  i#D   E#t        L###,   j###t ]],
        [[ E#t  f#E.  t#E i##WLLLLt :#G     GK E#t j#f    E#t      .E#j##,  G#fE#t ]],
        [[ E#t   t#K: t#E  .E#L      ;#L   LW. E#tL#i     E#t     ;WW; ##,:K#i E#t ]],
        [[ E#t    ;#W,t#E    f#E:     t#f f#:  E#WW,      E#t    j#E.  ##f#W,  E#t ]],
        [[ E#t     :K#D#E     ,WW;     f#D#;   E#K:       E#t  .D#L    ###K:   E#t ]],
        [[ E#t      .E##E      .D#;     G#t    ED.        E#t :K#t     ##D.    E#t ]],
        [[ ..         G#E        tt      t     t          E#t ...      #G      ..  ]],
        [[             fE                                 ,;.          j           ]],
        [[              ,                                                          ]],
        [[                                                                         ]],
      }

      dashboard.section.buttons.opts.hl = "Keyword"
      dashboard.section.buttons.val = {
        dashboard.button("f", ("%s  Find file"):format(icons.dashboard.FindFile), "<CMD>Telescope find_files<CR>"),
        dashboard.button("t", ("%s  Find text"):format(icons.dashboard.FindText), "<CMD>Telescope live_grep<CR>"),
        dashboard.button("p", ("%s  Find project"):format(icons.dashboard.FindProject), "<CMD>Telescope projects<CR>"),
        -- stylua: ignore
        dashboard.button("r", ("%s  Recently used files"):format(icons.dashboard.OldFiles), "<CMD>Telescope oldfiles<CR>"),
        dashboard.button("q", ("%s  Quit Neovim"):format(icons.dashboard.Quit), "<CMD>qa<CR>"),
      }

      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.footer.val = require("ori.lib.utils.io").read("fortune", "a")

      return dashboard.config
    end,
  },
}
