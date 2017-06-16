" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>Function
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Platform
function! MySys()
    if has("win32")
        return "windows"
    else
        return "linux"
    endif
endfunction

function! SwitchToBuf(filename)
    "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
    " find in current tab
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        " find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        " not exist, new tab
        exec "tabnew " . a:filename
    endif
endfunction
function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! Man(ArgLead, CmdLine, CursorPos)
    :let s:names=system("sh2elf" . "search")
    return s:names
endfunction

function! Manzh(start, ...)
    if a:0 == 1
        :let s:path= system("sh2elf " . "search " . a:start . " " . a:1)
    elseif a:0 == 0
        :let s:path= system("sh2elf " . "search " . a:start)
    else
        echo "Manzh [chapter] name"
        return
    endif

    echo s:path
    if s:path == "error"
        echo "error"
        return
    endif

    :execute "tabedit " . s:path
    ":execute "split " . s:path
    return
endfunction

function! Sdcv()
    let s:wold = getreg('0')
    let s:wold = "\"" . s:wold . "\""
    "echo s:wold
    :let s:chapter = system("mysdcv " .  s:wold )
    :call setreg('x', s:chapter)
    echo s:chapter
    return
endfunction

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! LoadProject()
    if filereadable("isession")
        source isession 
    endif
    if filereadable("viminfo")
        rviminfo viminfo
    endif
endfunction

function! OpenVimrc()
    if has("win32")
        tabedit $vim/_vimrc<cr>
    else
        tabedit! ~/.vimrc<cr>
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Sets how many lines of history VIM has to remember
set history=100

" Enable filetype plugin
filetype on
filetype plugin on
filetype indent on

"mouse set
"if has('mouse')
    "set mouse=a
"endif
"enable mouse in all mode
"set mouse=a

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>k :w!<cr>

"Fast edit vimrc
if MySys() == 'linux'
    "Fast reloading of the .vimrc
    map <silent> <leader>s :source ~/.vimrc<cr>
    "Fast editing of .vimrc
    map <silent> <leader>e :call SwitchToBuf("~/.vimrc")<cr>
    "When .vimrc is edited, reload it
    autocmd! bufwritepost .vimrc source ~/.vimrc
elseif MySys() == 'windows'
    " Set helplang
    set helplang=cn
    "Fast reloading of the _vimrc
    map <silent> <leader>s :source ~/_vimrc<cr>
    "Fast editing of _vimrc
    map <silent> <leader>e :call SwitchToBuf("~/_vimrc")<cr>
    "When _vimrc is edited, reload it
    autocmd! bufwritepost _vimrc source ~/_vimrc
endif

" For windows version
if MySys() == 'windows'
    "source $VIMRUNTIME/mswin.vim
    "behave mswin
endif

autocmd! BufReadPost *.[cC].* set filetype=c
autocmd! BufReadPost *.[cC][pP][pP].* set filetype=cpp

" Set 7 lines to the curors - when moving vertical..
set so=7

"Always show current position
set ruler

" display incomplete commands
set showcmd

"Number of screen lines to use for the command-line
set cmdheight=1

"Change buffer - without saving
set hid

"Highlight search things
set nohlsearch

" Do incremental searching
set noincsearch

"Set magic on, for regular expressions
set magic

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l"wrap

"Ignore case when searching
"set ignorecase

"Show matching bracets when text indicator is over them
set showmatch
"How many tenths of a second to blink
set mat=2

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=

"Show line number
set nu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4 " Number of spaces to use for each step of (auto)indent.
set tabstop=4 " Number of spaces that a <Tab> in the file counts for.
set softtabstop=4 "Number of spaces that a <Tab> counts for while performing editing operations
set smarttab

set lbr "attention

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines

set mps+=<:>


map <leader>t2 :setlocal shiftwidth=2<cr>
map <leader>t4 :setlocal shiftwidth=4<cr>
map <leader>t8 :setlocal shiftwidth=4<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
syntax on
" Set font according to system
"set gfn=Monospace
colorscheme peaksea

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Sessionoption
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set sessionoptions-=curdir
set sessionoptions+=sesdir
set sessionoptions+=localoptions

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
"set statusline=\ %F%m%r%h\ %w\ \ \ \ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c\ \ \ \[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %P
set statusline=\ %F%m%r%h\ %w\ \ \ \ \ \ Line:\ %l/%L:%c\ \ \ \[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %P


set fencs=utf-8,gb18030,gb2312,gbk,default

set wrapscan "禁止搜索到达文件两端时，又从另一端开始

"set wrap "设置自动折行
"autocmd Filetype text setlocal textwidth=50 "Maximum width of text that is being inserted.
set textwidth=110
set formatoptions+=Mm
"set wrapmargin=10

"不同窗口间跳转
map tt <C-W>w
map <F4> <C-W>+
map <F5> <C-W>-
map <F2> gt

"manzh sets
":command! -nargs=+ Manzh :call Manzh(<f-args>)
command! -nargs=? -complete=custom,Man Manzh exec(Manzh(<f-args>))
"keep an blank
map <leader>mm :Manzh 

"sdcv: word tran
:command!  Sdcv :call Sdcv(<f-args>)
nmap <leader>td ye<Esc>:Sdcv <cr> $"xp
nmap <leader>tv y<Esc>:Sdcv <cr>
nmap <leader>tp $"xp
nmap <leader>te e"xp
map <leader>d :tabedit! $DP/words.txt<cr>

map <leader>cb ggVG:s/ \{1,20\}$//g<cr>
map <leader>cm ggVG:s//g<cr>
map <leader>ce ggVG:/^$/d<cr>
map < ^
map > $

map <leader>/ F;wi /* <Esc>$a */<Esc>
map <leader>o ?\/\*<cr>xxx<Esc>/\*\/<cr>hxxx<Esc>

"要求：开始的时候需要将光标放置在段首,该段多于1行。
"首先对该段进行断行，之后将第一行设置为左对齐前面空五格，之后将剩下的左对齐，再两端对齐。
map <leader>f gq}''V:left 5<cr>jV}:left<cr>kV}_j<cr><esc>

if ! has("gui_running")
    set t_Co=256
endif
if &diff
    colors peaksea
endif

map <leader>ca :cs add cscope.out <cr>

map gf :tabedit <cfile><CR>

"自动补全使用下面一行标识文件
"set wildmenu
"set wildmode=longest:full


"行尾、空格、tab的标识为$
"set list
"行尾空格用红色标识
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

set comments=sl:/*,mb:*,elx:*/

"自动补全
set completeopt=longest,menu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Project vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable("workspace.vim")
    source workspace.vim
endif
nmap <silent> <leader>bk :rviminfo viminfo<CR>

""""""""""""""""""""""""""""""
" Plugin
""""""""""""""""""""""""""""""

" taglist plugin setting 文件结构
if MySys() == 'windows'
    let Tlist_Ctags_Cmd = 'C:\ctags.exe'
elseif MySys() == 'linux'
    set shell=/bin/bash
    let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
endif

set tags=tags
set autochdir
let Tlist_Sort_Type = "name"
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=0
let Tlist_WinWidth=20
let Tlist_WinHeight=70
let Tlist_Close_On_Select=0 "选择tag之后
"let Tlist_Auto_Open=1
map <silent> <leader>cs :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q <CR> :set tags=tags<CR>
map <silent> <leader>tl :Tlist <CR>
map <silent> <leader>ls :set tags=tags<CR>


" tagbar plugin setting 文件结构
map <silent> <leader>tb :TagbarToggle<CR>
if MySys() == 'windows'
    "let g:tagbar_ctags_bin='ctags'
elseif MySys() == 'linux'
    "let g:tagbar_ctags_bin='/usr/local/bin/ctags'
endif
let g:tagbar_width=30
let g:tagbar_left = 1
let g:tagbar_width = 30
let g:tagbar_indent = 1
let g:tagbar_type_tex = {
            \ 'ctagstype' : 'man',
            \ 'sort'    : 0,
            \ 'kinds'     : [
                \ 'e:Chapter',
                \ 'm:Option'
            \ ],
            \ }
"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
"help tagbar

" Netrw string 目录管理
let g:netrw_winsize=10
nmap <silent> <leader>fe :Sexplore<cr>

"NerdTree 目录管理
"The NERD tree allows you to explore your filesystem and to open files and directories. It presents
"the filesystem to you in the form of a tree which you manipulate with the keyboard and/or mouse. It also
"allows you to perform simple filesystem operations.
"map <F2>  :NERDTreeMirror<cr>
map <F3>  :NERDTreeToggle<cr>

"BufExplorer 缓冲管理
let g:bufExplorerDefaultHelp=0 "Do not show default help.
let g:bufExplorerDetailedHelp=0 "Do not show detailed help.
let g:bufExplorerShowRelativePath=1 "Show relative paths
let g:bufExplorerSplitRight=0
let g:bufExplorerSortBy='mru' "Sort by most recently used
let g:bufExplorerSplitVertical=1 "Split vertically
let g:bufExplorerSplitVertSize = 10 "Split width
let g:bufExplorerUseCurrentWindow=1 "Open in new window
autocmd BufWinEnter \[Buf\ List\] setl nonumber

" Winmanager setting 文件结构
let g:winManagerWindowLayout="BufExplorer,FileExplorer|TagList"
let g:winManagerWidth=10
let g:defaultExplorer=0
"nmap <C-W><C-F> :FirstExplorerWindow<cr>
"nmap <C-W><C-B> :BottomExplorerWindow<cr>
nmap <silent> <leader>tm :WMToggle<cr>

"JavaBrowser
let JavaBrowser_Ctags_Cmd = '/usr/local/bin/ctags'
let Javabrowser_Use_Icon = 1
let JavaBrowser_Use_Highlight_Tag = 1
map <F12> :JavaBrowser<CR>
imap <F12> <ESC><F12>

"JavaComplete java自动补全
setlocal omnifunc=javacomplete#Complete
setlocal completefunc=javacomplete#CompleteParamsInfo
inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P>
inoremap <buffer> <C-S-Space> <C-X><C-U><C-P>
autocmd Filetype java inoremap <buffer> . .<C-X><C-O><C-P>

"auto-pairs 自动不全{} ()

""""""""""""""""""""""""""""""
" Makefile GDB
""""""""""""""""""""""""""""""
" =>quickfix setting
"下一个错误
nmap <leader>cn :cn<cr>
"上一个错误
nmap <leader>cp :cp<cr>
nmap <leader>cw :cw<cr>

function! Mydict()
    let abc=system('echo ' . expand("<cword>") . ">>~/Dropbox/words.txt")
    let expl=system('sdcv -n ' .
                \ expand("<cword>"))
    windo if
                \ expand("%")=="diCt-tmp" |
                \ q!|endif
    15sp diCt-tmp
    setlocal buftype=nofile bufhidden=hide noswapfile
    1s/^/\=expl/
    1
endfunction

nmap F :call Mydict()<cr>
set keywordprg=sdcv

"latex-suite
" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
