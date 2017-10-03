" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

" neobundleプラグインインストール
"NeoBundle Scripts-----------------------------
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
 
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make',
      \     'linux' : 'make',
      \     'unix' : 'gmake',
      \    },
      \ }
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'tell-k/vim-autopep8'
NeoBundle 'tyru/caw.vim.git'
NeoBundle "sophacles/vim-processing"
" ファイルエクスプローラーをvimに表示
NeoBundle "scrooloose/nerdtree"
" ファイルタブ間でエクスプローラーを共有
NeoBundle "jistr/vim-nerdtree-tabs"
" カーソル移動の高速化(j,k,l,h)
NeoBundle "rhysd/accelerated-jk"
" ruby等のend等の自動補完
NeoBundle "tpope/vim-endwise"
" インデントの階層を可視化
NeoBundle "Yggdroot/indentLine"
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)
NeoBundle 'sophacles/vim-processing'
NeoBundle 'thinca/vim-quickrun'
let g:quickrun_config = {}
let g:quickrun_config.processing =  {
      \     'command': 'processing-java',
      \     'exec': '%c --sketch=$PWD/ --output=/Library/Processing --run --force',
      \   }
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'taichouchou2/html5.vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'lilydjwg/colorizer'
NeoBundle 'tpope/vim-fugitive'
:set statusline+=%{fugitive#statusline()} 
" NeoBundle 'itchyny/lightline.vim'
" NeoBundle 'taketwo/vim-ros'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck"End NeoBundle Scripts-------------------------
"ここまで

"html5自動インデント
let g:html5_event_handler_attributes_complete = 0

let g:html5_rdfa_attributes_complete = 0

let g:html5_microdata_attributes_complete = 0

let g:html5_aria_attributes_complete = 0


"ここまで

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

"カーソルがずれるのを修正するが他のプラグインなどが使えない
"diff -r a0198cebc8f4 src/screen.c
"b/src/screen.c  Sun Mar 15 00:35:05 2015 +0900
"@@ -4484,11 +4484,15 @@
"         */
"        if (wp->w_p_lbr && vim_isbreak(c) && !vim_isbreak(*ptr))
"        {
"# ifdef FEAT_MBYTE
"           int off = has_mbyte ? (*mb_head_off)(line, ptr - 1) : 0;
"#endif
"            char_u *p = ptr - (
" # ifdef FEAT_MBYTE
"           off +
"# endif
"           1);
"
"            /* TODO: is passing p for start of the line OK? */
"            n_extra = win_lbr_chartabsize(wp, line, p, (colnr_T)vcol,
"                                    NULL) - 1;
"@@ -4496,7 +4500,11 @@
"            n_extra = (int)wp->w_buffer->b_p_ts
"                       - vcol % (int)wp->w_buffer->b_p_ts - 1;
"
"# ifdef FEAT_MBYTE
"           c_extra = off ? MB_FILLER_CHAR : ' ';
"# else
"            c_extra = ' ';
"# endif
"            if (vim_iswhite(c))
"            {
" #ifdef FEAT_CONCEAL

"===================================
" 設定
" デフォルトの機能拡張
" ==================================

" カーソルラインを表示する
set cursorline

" どのモードでもマウスを使えるようにする
set mouse=a

"行番号の表示
set number

set smartindent

" 未保存ファイルの終了時に保存確認
set confirm

"コードのシンタックスの有効化
syntax on

set showmatch

"タブを半角スペース何個分か
set tabstop=2

"バックアップファイルを作成しない
set noswapfile

" タブバーを常に表示する???
set showtabline=2

"バックアップファイルを作成しない( ~ ←チルダマークのファイル )
set nobackup
set nowritebackup
set noundofile

" スペースをインデントと判断する
set shiftwidth=2

" タブをスペースに変更
set expandtab

"ヤンクでクリップボードに保存
set clipboard=unnamed

" 検索にヒットした文字をハイライト化
set hlsearch

" コマンドラインウィンドウの幅
set cmdwinheight=20

" シンタックスの色変更
colorscheme hybrid

" 背景色を黒にする
set background=dark

" タブや改行を表示 (list:表示)
set list

" どの文字でタブや改行を表示するかを設定
set listchars=tab:>-,extends:<,trail:- "eol:<

" 「%」キーで対応するHTMLタグやrubyのdef endにジャンプできる。
source $VIMRUNTIME/macros/matchit.vim

" ウインドウの幅（現在はgvimrcで設定している）
"set columns=100
" ウインドウの高さ
"set lines=50


"==========================
" キーマッピング設定
" モード(再割り当てなし：再割り当てあり)
"==========================
"ノーマルモード＋ビジュアルモード(noremap：map)
"コマンドラインモード＋インサートモード(noremap!：ap!)
"ノーマルモード(noremap：nmap)
"ビジュアル(選択)モード(vnoremap：vmap)
"コマンドラインモード(cnoremap：cmap)
"インサート(挿入)モード(inoremap：imap)
" =========================
"自動閉じ括弧
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

" Escキー2回で検索語句のハイライトをoff
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" ESCキーでノーマルモード→controll+jキーでノーマルモード
imap <C-j> <ESC>

" 先頭行にカーソルを移動
noremap <S-h> ^

" 行末にカーソルを移動
noremap <S-l> $

" ノーマルモード：シングルクォーテーション内の文字列をqでカット
nmap q ci'

" ノーマルモード：ダブルクォーテーション内の文字列をqqでカット
nmap qq ci"

" ノーマルモード：vimgrepで検索した際の前へ
noremap [ :cprevious<CR>

" ノーマルモード：vimgrepで検索した際の次へ
noremap ] :cnext<CR>

"=========================
" 全角スペースハイライト化
"=========================
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

" ==============================
" プラグインインストール後設定
" ==============================
" vim起動時にファイルエクスプローラを表示
autocmd vimenter * NERDTree

" NERDTreeの表示領域を設定
let NERDTreeWinSize= 20

" ファイルが指定されていなければNERD treeを有効にする(タブ間で別ファイルを開い
" ても自動でNERD treeを表示する
if argc() == 0
  let g:nerdtree_tabs_open_on_console_startup = 1
end

" =======================
" tyru.caw.vim
" ======================
" コメントの追加・削除を行なう
"nmap <Leader>/ <Plug>(caw:zeropos:toggle)
"vmap <Leader>/ <Plug>(caw:zeropos:toggle)

" ===========================
" Yggdroot/indentLine
" とりあえずカーソルの位置がずれる為コメントアウト
" ===========================
" インデントをハイライト化したい場合はコメントアウトを外す
"let g:indentLine_setColors = 0

" インデント文字を変更
"let g:indentLine_char = '┆'

" jsonファイル系の問題？
"let g:indentLine_concealcursor = 'inc'
"let g:indentLine_conceallevel = 2

