set number
set tabstop=4
set autochdir
set hlsearch
colorscheme eldar

" show tab # in tab
set guitablabel=%N/\ %t\ %M

" show tab # in tab
fu! MyTabLabel(n)
let s = ''
let buflist = tabpagebuflist(a:n)
" Add '+' if one of the buffers in the tab page is modified
for bufnr in buflist
	if getbufvar(bufnr, "&modified")
		let s = '+'
		break
	endif
endfor
let winnr = tabpagewinnr(a:n)
let s .= fnamemodify(bufname(buflist[winnr - 1]), ':t')
return empty(s) ? '[unnamed]' : s
endfu

fu! MyTabLine()
let s = ''
for i in range(tabpagenr('$'))

" select the highlighting
	if i + 1 == tabpagenr()
	let s .= '%#TabLineSel#'
	else
	let s .= '%#TabLine#'
	endif

	" set the tab page number (for mouse clicks)
	"let s .= '%' . (i + 1) . 'T'
	" display tabnumber (for use with <count>gt, etc)
	let s .= ' '. (i+1) . ' '

	" the label is made by MyTabLabel()
	let s .= ' %{MyTabLabel(' . (i + 1) . ')} '

	if i+1 < tabpagenr('$')
		let s .= ' |'
	endif
endfor
return s
endfu
set tabline=%!MyTabLine()

" custom commands:
command Highlight execute "highlight Search ctermbg=Red | highlight Search ctermfg=LightYellow"

command Proj execute "source $VIM/proj.vim | Highlight"
command Edit execute "source $VIM/edit.vim | Highlight"
command OS execute "source $VIM/os.vim | Highlight"
command Cpp execute "source $VIM/cpp.vim | Highlight"

command SaveProj execute "mks! $VIM/proj.vim"
command SaveEdit execute "mks! $VIM/edit.vim"
command SaveOS execute "mks! $VIM/os.vim"
command SaveCpp execute "mks! $VIM/cpp.vim"

" macros
" Comment line
let @c=':s/^/\/\/'
" Uncomment line
let @u=':s/\/\//'
" Add Trace line
let @t='$a														var_dump((new Exception)->getTraceAsString());'
" Add Watch Line
let @w='$a														echo "\n\nHERE\n";														echo "\nkey: ";print_r($key)."\n";'
