local opt = vim.opt

opt.hidden = true -- don't autosave buffers
opt.updatetime = 100 -- highlight sameids faster
opt.showmatch = true -- show matching brackets
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes" -- always show the gutter
opt.wrap = false
opt.clipboard = "unnamed" -- y yy d works with system clipboard
opt.hlsearch = false
opt.laststatus = 2
opt.wildignore:append("*.bak","*.pyc","*.py~","*.pdf","*.so","*.gif","*.jpg","*.flv","*.class","*.jar","*.png","*/tools/*","*/docs/*","*.swp","*/.svn/*","*/.git/*")
opt.wildmode = "list:longest"
opt.wildmenu = true
opt.textwidth = 0
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.completeopt = {"menuone","noinsert","noselect"}
opt.expandtab = true
opt.smarttab = true
opt.smartindent = true
opt.showmode = true
opt.fileformats = "unix,dos"
opt.autowrite = true -- automatically save before commands like :next and :make
opt.ignorecase  = true -- do case insensitive matching
opt.incsearch = true -- Incremental search
opt.ruler = true
opt.linebreak = true
opt.splitbelow = true
opt.splitright = true
opt.smartcase = true -- do smart case matching
opt.foldmethod = "indent"
opt.foldlevel = 999
opt.autoread = true
opt.list = true
opt.mouse = "a"
opt.background = "dark"
opt.listchars:append({trail = '·', eol = '↩', tab = '› '})

-- vim.cmd [[colorscheme catppuccin]]
