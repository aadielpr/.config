local opt = vim.opt
local g = vim.g

g.mapleader = " "

opt.nu = true
opt.relativenumber = true
-- opt.cursorline = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true

opt.wrap = false

opt.listchars = {
  tab = "» ",
  trail = "·",
  space = "·",
}

opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes:1"
opt.statuscolumn = "%=%{v:relnum?v:relnum:v:lnum} %s"
opt.splitbelow = true
opt.splitright = true

opt.updatetime = 50

opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
opt.foldenable = true

-- Don't have `o` add a comment
opt.formatoptions:remove("o")
-- opt.guicursor:append("i:block")
