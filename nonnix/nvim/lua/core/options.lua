local opt = vim.opt

opt.backup = false
opt.clipboard = "unnamedplus"
opt.cmdheight = 1
opt.completeopt = { "menu", "menuone", "noselect" }
opt.conceallevel = 0
opt.cursorline = false
opt.expandtab = true
opt.fileencoding = "utf-8"
opt.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"
opt.foldcolumn = "0"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.guifont = "monospace:h17"
opt.hlsearch = true
opt.ignorecase = true
opt.laststatus = 3
opt.mouse = "a"
opt.mousemodel = "extend"
opt.number = true
opt.numberwidth = 4
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 8
opt.shiftwidth = 2
opt.showmode = false
opt.showtabline = 0
opt.sidescrolloff = 8
opt.signcolumn = "yes:1"
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 300
opt.undofile = true
opt.updatetime = 300
opt.wrap = true
opt.writebackup = false

opt.iskeyword:append("-,/")
opt.shortmess:append("c")
opt.whichwrap:append("<,>,[,],h,l")

opt.formatoptions:remove("cro")
opt.viewoptions:remove("options")
