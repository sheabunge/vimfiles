execute pathogen#infect()

" tab indents and stuff
com! -bar -count=4 HardTab set ts=<count> sts=0 sw=<count> noet
com! -bar -count=4 SoftTab set ts=8 sts=<count> sw=<count> et
HardTab

nnoremap <expr> cot ToggleTab()
nnoremap [ot :SoftTab<CR>
nnoremap ]ot :HardTab<CR>

func ToggleTab()
	if &et
		HardTab
	else
		SoftTab
	endif
endfunc

" show line numbers
set nu

" get rid of the not-very-useful GUI toolbar
set go-=T
" and the scrollbar as well
set go-=r
" and the other one
set go-=L

" nicer font for my gvim
if has('win32')
	set guifont=Consolas
else
	set guifont=Monospace\ 9
endif

" trying to scroll a lightyear shouldn't take a year
if has('mouse')
	set mouse=a
endif

" swapfiles are annoying
set noswf

" look up word under the cursor in Zeal
nnoremap gz :!zeal --query "<cword>"&<CR><CR>

" my shift-finger is falling off
noremap ; :
noremap , ;

" Tomorrow-Night-Bright looks weird with 88 colours.
if has('gui_running') || &t_Co == 256
	colo Tomorrow-Night-Bright
endif

if has('termtruecolor') && &term == 'xterm-termite'
	set guicolors
endif

" apparently terminals are small?
set colorcolumn=80,132

" ignore case by default when searching, except when I use uppercase
set ignorecase smartcase

" tell me what command I'm typing
set showcmd

" airline shiz
if (&encoding == 'utf-8' || &termencoding == 'utf-8') && (has('gui_running') || $TERM !~# '^linux\|^putty')
	let g:airline_powerline_fonts = 1
else
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = '|'
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = '|'
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
set noshowmode

" supertab
let g:SuperTabDefaultCompletionType = "context"

" delimitMate
au FileType python let b:delimitMate_nesting_quotes = ['"']
au FileType markdown let b:delimitMate_nesting_quotes = ['`']

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ignore_files = ['\M.pyi$']
nnoremap <F3> :Errors<CR>
nnoremap <F4> :SyntasticToggleMode<CR>

" gundo
let g:gundo_prefer_python3 = 1
nnoremap <F5> :GundoToggle<CR>

" tagbar
nnoremap <F8> :TagbarToggle<CR>

" emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" jedi
let g:jedi#show_call_signatures = 2

"let g:python_space_error_highlight = 1

" source a local vimrc, if any
runtime! vimrc.local
