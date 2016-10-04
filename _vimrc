
set clipboard=unnamed,autoselect
set rop=type:directx
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

"行末、行頭にジャンプする(Alt+r)(Alt+a)
inoremap <A-r> <Esc>$a
inoremap <A-a> <Esc>^a
noremap <A-r> <Esc>$a
noremap <A-a> <Esc>^a

"htmlタグ補完( </ + C+x + C+o )
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

"自動閉じ括弧
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>









"ヤンクでクリップボードにコピーできる。
set clipboard=unnamed


set guifont=Ricty_Diminished:h12:cSHIFTJIS



set transparency=240
set rop=type:directx

"===============================================================
"neobundle.vimの導入? (プラグイン導入パッケージ)
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
"ここから下にインストールしたいプラグインを書く＝＝＝＝＝＝＝＝＝＝＝
NeoBundle 'nanotech/jellybeans.vim'
"vimからshellを使えるプラグイン
NeoBundleLazy 'Shougo/vimshell',{
      \ 'depends' : 'Shougo/vimproc',
      \ 'autoload' : {
      \ 'commands' : [{ 'name' : 'VimShell', 'complete' : 'customlist,vimshell#complete'},
      \ 'VimmShellExecute', 'VimShellInteractive',
      \ 'VimShellTerminal', 'VimShellPop'],
      \ 'mappings' : ['<Plug>(vimshell_switch)']
      \ }}
"閉じ括弧補完。２重閉じ括弧も防止
NeoBundle 'Townk/vim-autoclose'

NeoBundleLazy 'tpope/vim^endwise', {
      \ 'autoload' : { 'insert' : 1, }}
"未設定
NeoBundle 'vimtaku/hl_matchit.vim'

"html5の自動インデントプラグイン
NeoBundle 'othree/html5.vim'
"ここの間に書く＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
NeoBundleCheck
call neobundle#end()
filetype plugin indent on
"===========================================================






set t_Co=256
syntax on
"colorscheme jellybeans
"========================================================
"vimShellプラグインセット
nmap <silent> vs :<C-u>VimShell<CR>
nmap <silent> vp :<C-u>VimShellPop<CR>
"============================================================
"html5の自動インデント
let g:html5_event_handler_attributes_complete = 0

let g:html5_rdfa_attributes_complete = 0

let g:html5_microdata_attributes_complete = 0

let g:html5_aria_attributes_complete = 0

"未設定
let g:h1_matchit_allow_ft = 'html\|vim\|ruby\|sh'




set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

"バックアップファイルを作らない
set nobackup


"スワップファイルを作らない
set noswapfile


"バッファが編集中でもその他ファイルを開けるように
set hidden

"入力中のコマンドをステータスに表示する
set showcmd


"行番号
set number

"行末の１文字先までカーソルを移動できるように
set virtualedit=onemore

"インデントをスマートに
set smartindent


"タブを削除したいときに一気にしてくれる。
set smarttab


"括弧入力時の対応する括弧を表示
set showmatch

"ステータスラインを常に表示
set laststatus=2


"commandoラインの補完
set wildmode=list:longest


"折り返し時に表示単位での移動できるようにする
nnoremap j gj
nnoremap k gk

"Tab文字を半角スペースにする
set expandtab


"Tabコマンドでインデントを入力したときの表示幅( 半角スペースいくつ分 )
set tabstop=4


"自動インデントの表示幅（半角スペース）
set shiftwidth=4



"検索文字列が小文字の場合は大文字小文字区別なく検索
set ignorecase


"検索文字に大文字が含まれている場合区別して検索する
set smartcase


"検索文字列入力時に順次対象文字列にヒットさせる
set incsearch

"検索時に最後まで行ったら最初に戻る
set wrapscan


"検索語をハイライト表示する
set hlsearch


"ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>


"矢印キーで表示単位で行移動する
nmap <UP> gk
nmap <DOWN> gj
vmap <UP> gk
vmap <DOWN> gj


"カーソルを自動的に括弧の中に入れる
imap {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap "" ""<Left>
imap '' ''<Left>
imap <> <><Left>






"htmlタグにも対応するタグをハイライトにする。
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




"vimの背景を透過
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
