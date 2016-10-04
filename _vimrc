
set clipboard=unnamed,autoselect
set rop=type:directx
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

"�s���A�s���ɃW�����v����(Alt+r)(Alt+a)
inoremap <A-r> <Esc>$a
inoremap <A-a> <Esc>^a
noremap <A-r> <Esc>$a
noremap <A-a> <Esc>^a

"html�^�O�⊮( </ + C+x + C+o )
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

"����������
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>









"�����N�ŃN���b�v�{�[�h�ɃR�s�[�ł���B
set clipboard=unnamed


set guifont=Ricty_Diminished:h12:cSHIFTJIS



set transparency=240
set rop=type:directx

"===============================================================
"neobundle.vim�̓���? (�v���O�C�������p�b�P�[�W)
if has('vim_starting')
  set nocompatible
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'

NeoBundleFetch 'Shougo/neobundle.vim'
"�������牺�ɃC���X�g�[���������v���O�C������������������������������
NeoBundle 'nanotech/jellybeans.vim'
"vim����shell���g����v���O�C��
NeoBundleLazy 'Shougo/vimshell',{
      \ 'depends' : 'Shougo/vimproc',
      \ 'autoload' : {
      \ 'commands' : [{ 'name' : 'VimShell', 'complete' : 'customlist,vimshell#complete'},
      \ 'VimmShellExecute', 'VimShellInteractive',
      \ 'VimShellTerminal', 'VimShellPop'],
      \ 'mappings' : ['<Plug>(vimshell_switch)']
      \ }}
"�����ʕ⊮�B�Q�d�����ʂ��h�~
NeoBundle 'Townk/vim-autoclose'

NeoBundleLazy 'tpope/vim^endwise', {
      \ 'autoload' : { 'insert' : 1, }}
"���ݒ�
NeoBundle 'vimtaku/hl_matchit.vim'

"html5�̎����C���f���g�v���O�C��
NeoBundle 'othree/html5.vim'
"�����̊Ԃɏ���������������������������������������
NeoBundleCheck
call neobundle#end()
filetype plugin indent on
"===========================================================






set t_Co=256
syntax on
"colorscheme jellybeans
"========================================================
"vimShell�v���O�C���Z�b�g
nmap <silent> vs :<C-u>VimShell<CR>
nmap <silent> vp :<C-u>VimShellPop<CR>
"============================================================
"html5�̎����C���f���g
let g:html5_event_handler_attributes_complete = 0

let g:html5_rdfa_attributes_complete = 0

let g:html5_microdata_attributes_complete = 0

let g:html5_aria_attributes_complete = 0

"���ݒ�
let g:h1_matchit_allow_ft = 'html\|vim\|ruby\|sh'




set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

"�o�b�N�A�b�v�t�@�C�������Ȃ�
set nobackup


"�X���b�v�t�@�C�������Ȃ�
set noswapfile


"�o�b�t�@���ҏW���ł����̑��t�@�C�����J����悤��
set hidden

"���͒��̃R�}���h���X�e�[�^�X�ɕ\������
set showcmd


"�s�ԍ�
set number

"�s���̂P������܂ŃJ�[�\�����ړ��ł���悤��
set virtualedit=onemore

"�C���f���g���X�}�[�g��
set smartindent


"�^�u���폜�������Ƃ��Ɉ�C�ɂ��Ă����B
set smarttab


"���ʓ��͎��̑Ή����銇�ʂ�\��
set showmatch

"�X�e�[�^�X���C������ɕ\��
set laststatus=2


"commando���C���̕⊮
set wildmode=list:longest


"�܂�Ԃ����ɕ\���P�ʂł̈ړ��ł���悤�ɂ���
nnoremap j gj
nnoremap k gk

"Tab�����𔼊p�X�y�[�X�ɂ���
set expandtab


"Tab�R�}���h�ŃC���f���g����͂����Ƃ��̕\����( ���p�X�y�[�X������ )
set tabstop=4


"�����C���f���g�̕\�����i���p�X�y�[�X�j
set shiftwidth=4



"���������񂪏������̏ꍇ�͑啶����������ʂȂ�����
set ignorecase


"���������ɑ啶�����܂܂�Ă���ꍇ��ʂ��Č�������
set smartcase


"������������͎��ɏ����Ώە�����Ƀq�b�g������
set incsearch

"�������ɍŌ�܂ōs������ŏ��ɖ߂�
set wrapscan


"��������n�C���C�g�\������
set hlsearch


"ESC�A�łŃn�C���C�g����
nmap <Esc><Esc> :nohlsearch<CR><Esc>


"���L�[�ŕ\���P�ʂōs�ړ�����
nmap <UP> gk
nmap <DOWN> gj
vmap <UP> gk
vmap <DOWN> gj


"�J�[�\���������I�Ɋ��ʂ̒��ɓ����
imap {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap "" ""<Left>
imap '' ''<Left>
imap <> <><Left>






"html�^�O�ɂ��Ή�����^�O���n�C���C�g�ɂ���B
if exists("b:did_ftplugin")
	    finish
		endif

		augroup matchhtmlparen
		    autocmd! CursorMoved,CursorMovedI,WinEnter <buffer> call s:Highlight_Matching_Pair()
			augroup END

			fu! s:Highlight_Matching_Pair()
			    " Remove any previous match.
				    if exists('w:tag_hl_on') && w:tag_hl_on
						        2match none
								        let w:tag_hl_on = 0
										    endif

   " Avoid that we remove the popup menu.
       " Return when there are no colors (looks like the cursor jumps).
   	    if pumvisible() || (&t_Co < 8 && !has("gui_running"))
   			        return
   					    endif

   						    "get html tag under cursor
   							    let tagname = s:GetCurrentCursorTag()
   								    if tagname == ""|return|endif

   										    if tagname[0] == '/'
   												        let position = s:SearchForMatchingTag(tagname[1:], 0)
   														    else
   																        let position = s:SearchForMatchingTag(tagname, 1)
   																		    endif
   																			    call s:HighlightTagAtPosition(position)
   																							endfu

																							fu! s:GetCurrentCursorTag()
    "returns the tag under the cursor, includes the '/' if on a closing tag.

										    let c_col  = col('.')
																			    let matched = matchstr(getline('.'), '\(<[^<>]*\%'.c_col.'c.\{-}>\)\|\(\%'.c_col.'c<.\{-}>\)')
																				    if matched =~ '/>$'
																						        return ""
																								    elseif matched == ""
								        " The tag itself may be spread over multiple lines.
																								        let matched = matchstr(getline('.'), '\(<[^<>]*\%'.c_col.'c.\{-}$\)\|\(\%'.c_col.'c<.\{-}$\)')
																													        if matched == ""
																																            return ""
																																			        endif
																																																				    endif

																																																					    " XML Tag definition is
																																																						    "   (Letter | '_' | ':') (Letter | Digit | '.' | '-' | '_' | ':' | CombiningChar | Extender)*
																																																							    " Instead of dealing with CombiningChar and Extender, and because Vim's
																																																								    " [:alpha:] only includes 8-bit characters, let's include all non-ASCII
																																																									    " characters.
																																																										    let tagname = matchstr(matched, '<\zs/\?\%([[:alpha:]_:]\|[^\x00-\x7F]\)\%([-._:[:alnum:]]\|[^\x00-\x7F]\)*')
																																																											    return tagname
																																																												endfu

																																																												fu! s:SearchForMatchingTag(tagname, forwards)
																																																												    "returns the position of a matching tag or [0 0]

																																																													    let starttag = '\V<'.escape(a:tagname, '\').'\%(\_s\%(\.\{-}\|\_.\{-}\%<'.line('.').'l\)/\@<!\)\?>'
																																																														    let midtag = ''
																																																															    let endtag = '\V</'.escape(a:tagname, '\').'\_s\*'.(a:forwards?'':'\zs').'>'
																																																																    let flags = 'nW'.(a:forwards?'':'b')

																																																																	    " When not in a string or comment ignore matches inside them.
																																																																		    let skip ='synIDattr(synID(line("."), col("."), 0), "name") ' .
																																																																			                \ '=~?  "\\%(html\\|xml\\)String\\|\\%(html\\|xml\\)CommentPart"'
																																																																							    execute 'if' skip '| let skip = 0 | endif'

																																																																								    " Limit the search to lines visible in the window.
																																																																									    let stopline = a:forwards ? line('w$') : line('w0')
																																																																										    let timeout = 300

																																																																											    " The searchpairpos() timeout parameter was added in 7.2
																																																																												    if v:version >= 702
																																																																														        return searchpairpos(starttag, midtag, endtag, flags, skip, stopline, timeout)
																																																																																    else
																																																																																		        return searchpairpos(starttag, midtag, endtag, flags, skip, stopline)
																																																																																				    endif
																																																																																					endfu

																																																																																					fu! s:HighlightTagAtPosition(position)
																																																																																					    if a:position == [0, 0]
																																																																																							        return
																																																																																									    endif

																																																																																										    let [m_lnum, m_col] = a:position
																																																																																											    exe '2match MatchParen /\(\%' . m_lnum . 'l\%' . m_col .  'c<\zs.\{-}\ze[\n >]\)\|'
																																																																																												                \ .'\(\%' . line('.') . 'l\%' . col('.') .  'c<\zs.\{-}\ze[\n >]\)\|'
																																																																																																                \ .'\(\%' . line('.') . 'l<\zs[^<> ]*\%' . col('.') . 'c.\{-}\ze[\n >]\)\|'
																																																																																																				                \ .'\(\%' . line('.') . 'l<\zs[^<>]\{-}\ze\s[^<>]*\%' . col('.') . 'c.\{-}[\n>]\)/'
																																																																																																								    let w:tag_hl_on = 1
																																																																																																									endfu




"vim�̔w�i�𓧉�
"if !has('gui_running')
"    augroup seiya
"        autocmd!
"        autocmd VimEnter,ColorScheme * highlight Normal ctermbg=none
"        autocmd VimEnter,ColorScheme * highlight LineNr ctermbg=none
"        autocmd VimEnter,ColorScheme * highlight SignColumn ctermbg=none
"        autocmd VimEnter,ColorScheme * highlight VertSplit ctermbg=none
"        autocmd VimEnter,ColorScheme * highlight NonText ctermbg=none
"    augroup END
"endif
"
"let g:seiya_auto_enable=1


"colorscheme
colorscheme hybrid
