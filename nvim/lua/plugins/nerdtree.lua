local map = require("utils").map
local silent = { silent=true }
local g = vim.g

-- configs
g.NERDTreeShowBookmarks = 1
g.nerdtree_tabs_open_on_gui_startup = 0
g.NERDTreeQuitOnOpen = 1
g.NERDTreeMinimalUI = 1
g.NERDTreeDirArrows = 1
g.NERDTreeAutoCenter = 1
g.NERDTreeAutoDeleteBuffer = 1

-- mappings
map("n", "<leader>q", ":NERDTreeToggle<CR>", silent)

-- TODO rewrite the function bellow in Lua
--function! IsNERDTreeOpen()
  --return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
--endfunction
--function! SyncTree()
  --if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    --NERDTreeFind
    --wincmd p
  --endif
--endfunction
--augroup nerdtree
    --autocmd!
    --autocmd BufRead * call SyncTree()
--augroup END
