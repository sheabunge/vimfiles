execute pathogen#infect()

" tab indents and stuff
command! -bar -count=4 HardTab set tabstop=<count> softtabstop=0 shiftwidth=0 noexpandtab
command! -bar -count=4 SoftTab set tabstop=8 softtabstop=<count> shiftwidth=<count> expandtab
HardTab

nnoremap <expr> cot ToggleTab()
nnoremap [ot :SoftTab<CR>
nnoremap ]ot :HardTab<CR>

function! ToggleTab()
	if &expandtab
		HardTab
	else
		SoftTab
	endif
endfunction

augroup vimrc
	autocmd!
augroup END

" show line numbers
set number

" get rid of the not-very-useful GUI toolbar
" not that I really use gvim...
set guioptions-=T
" and the scrollbars as well
set guioptions-=r guioptions-=L

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

" look up word under the cursor in Zeal
nnoremap gz :!zeal "<cword>"&<CR><CR>

" pressing shift is hard
noremap <Space> :

" retain visual state on shifts
vnoremap < <gv
vnoremap > >gv

" write files even faster
nnoremap <Leader>w :w<CR>
" fly between buffers
" note space at end of line
nnoremap <Leader>b :ls<CR>:b 

" Tomorrow-Night-Bright looks weird with 88 colours.
if has('gui_running') || &t_Co == 256
	colorscheme Tomorrow-Night-Bright
endif

" enable true colour support if we're 99% sure our terminal supports it
if !has('gui_running') && has('termguicolors') && ($COLORTERM == 'truecolor' ? $TERM !~ '^screen\|^dvtm' : $TERM == 'xterm-termite' || $TERM =~ '\v^(konsole|iterm2|vte|gnome)')
	" vim only sets these if we're in an xterm
	if !has('nvim') && &term !~# '^xterm'
		let &t_8f = "\<Esc>[38;2;%ld;%ld;%ldm"
		let &t_8b = "\<Esc>[48;2;%ld;%ld;%ldm"
	endif
	set termguicolors
endif

" set cursor shape
if $TERM =~ '\v^(xterm|rxvt-unicode|konsole|gnome|vte|tmux|iterm2)'
	if has('nvim')
		let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 2
	elseif has('cursorshape')
		if $TERM =~ '^konsole\|^iterm2' || $TERM_PROGRAM == 'iTerm.app' && $TERM !~ '^tmux'
			let &t_SI = "\<Esc>]50;CursorShape=1\x7"
			if exists('+t_SR')
				let &t_SR = "\<Esc>]50;CursorShape=2\x7"
			endif
			let &t_EI = "\<Esc>]50;CursorShape=0\x7"
		else
			let &t_SI = "\<Esc>[5 q"
			if exists('+t_SR')
				let &t_SR = "\<Esc>[3 q"
			endif
			let &t_EI = "\<Esc>[0 q"
		endif
	endif
endif

" fix vim in tmux with xterm-keys on
if &term =~ '^tmux'
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"
endif

" apparently terminals are small?
set colorcolumn=80,132

" ignore case by default when searching, except when I use uppercase
set ignorecase smartcase

" tell me what command I'm typing
set showcmd

" make command mode tab complete nicer
set wildmode=longest,full

" my systems never crash
if exists('$XDG_RUNTIME_DIR')
	set directory^=$XDG_RUNTIME_DIR//
endif

" airline shiz
if (&encoding == 'utf-8' || &termencoding == 'utf-8') && (has('gui_running') || $TERM !~# '^linux\|^putty')
	let g:airline_powerline_fonts = 1
else
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = '|'
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = '|'
	let g:airline#extensions#tabline#left_sep = ''
	let g:airline#extensions#tabline#left_alt_sep = ''
endif
let g:airline_exclude_preview = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#hunks#non_zero_only = 1
set noshowmode

" supertab
let g:SuperTabDefaultCompletionType = "context"

" delimitMate
augroup vimrc
	autocmd FileType python let b:delimitMate_nesting_quotes = ['"']
	autocmd FileType markdown let b:delimitMate_nesting_quotes = ['`']
	autocmd FileType lisp let b:delimitMate_quotes = '"'
augroup END

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ignore_files = ['\M.pyi$']
let g:syntastic_css_checkers = ['stylelint']
nnoremap <F3> :Errors<CR>
nnoremap <F4> :SyntasticToggleMode<CR>

" undotree
nnoremap <F5> :UndotreeToggle<CR>

" tagbar
nnoremap <F8> :TagbarToggle<CR>

" emmet
let g:user_emmet_install_global = 0
augroup vimrc
	autocmd FileType html,css EmmetInstall
augroup END

" jedi
let g:jedi#show_call_signatures = 2
let g:jedi#popup_on_dot = 0

"let g:python_space_error_highlight = 1

" source a local vimrc, if any
runtime! vimrc.local
