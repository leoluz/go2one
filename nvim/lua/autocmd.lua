-- will format file before saving based on attached lsp capabilities
vim.cmd[[
augroup lsp
  autocmd!
  autocmd BufWritePre * lua require'utils'.auto_format_lsp()
augroup END
]]

-- yaml configurations
vim.cmd[[
augroup yaml
  autocmd!
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab cursorcolumn
augroup END
]]

-- term configurations
vim.cmd[[
augroup term
  autocmd!
  au TermOpen * setlocal listchars= nonumber norelativenumber signcolumn=no
  au TermOpen * startinsert
  au BufEnter,BufWinEnter,WinEnter term://* startinsert
  au BufLeave term://* stopinsert
augroup END
]]

-- lua configurations
vim.cmd[[
augroup lua
  autocmd!
  au FileType lua setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType lua lua require'cmp'.setup.buffer {
  \   sources = {
  \     { name = 'buffer' },
  \     { name = 'nvim_lua' },
  \     { name = 'ultisnips' },
  \     { name = 'nvim_lsp' },
  \   }
  \ }
augroup END
]]

-- go configurations
vim.cmd[[
augroup golang
  autocmd!
  au FileType go setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
augroup END
]]
