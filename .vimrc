syntax on
colorscheme elflord
set ts=4		" tab size
set shiftwidth=4
set number		" line numbers
set ruler		" line/column info at bottom

" commenting/uncommenting and tabification macros


" adds tab #s to tab labels
set guitablabel=%N/\ %t\ %M

" paging
nnoremap <space> 10jzz
nnoremap <backspace> 10kzz

" visual cue to maintain less-than/equal 76 characters per line
if v:version >= 703
set tw=76
set colorcolumn=+1
else
augroup vimrc_autocmds
	autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
	autocmd BufEnter * match OverLength /\%76v.*/
augroup END
endif

