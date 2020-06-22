syntax enable
set background=dark
colorscheme solarized
let mapleader="\<space>"       " change leader key to <space>
let maplocalleader="\<space>"  " change local leader key to <space>
set number
set autoindent
set ignorecase
set smartindent       " 设置智能缩进
set cursorline        " 光标所在的当前行高亮
set tabstop=2         " 按下 Tab 键时，Vim 显示的空格数
set expandtab         " 将 Tab 转为空格
set shiftwidth=2
set showcmd           " 在底部显示，当前处于命令模式还是插入模式。
set noerrorbells      " shut uptpope/css.vim
set visualbell
set t_vb=             " use visual bell instead of error bell
set mousehide         " hide mouse pointer when typing
set nocompatible      " 不与 Vi 兼容（采用 Vim 自己的操作命令)
set undolevels=1000   " boost undo levels
set backspace=indent,eol,start
set hlsearch
" set nowrap              " 关闭自动折行
set showmatch           " 光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个圆括号、方括号和大括号
set updatetime=100
set foldenable              " 开始折叠
set foldmethod=syntax       " 设置语法折叠
set foldcolumn=0            " 设置折叠区域的宽度
setlocal foldlevel=1        " 设置折叠层数为
set foldlevelstart=99       " 打开文件是默认不折叠代码
" 如果行尾有多余的空格（包括 Tab 键），该配置将让这些空格显示成可见的小方块
set clipboard=unnamed       " 复制到系统寄存器
set listchars=tab:\¦\ ,trail:■,extends:>,precedes:<,nbsp:+
set list
hi SpecialKey ctermfg=239 ctermbg=8

" 将文档中存在的tab转换为空格
if has("autocmd")
    au BufReadPost * if &modifiable | retab | endif
  endif
" 将交换文件放到一起
if !isdirectory($HOME."/.vim/swap")
  call mkdir($HOME."/.vim/swap", "p")
endif
set directory=$HOME/.vim/swap//

" 为所有文件设置持久性撤销
set undofile
if !!!isdirectory($HOME."/.vim/undodir")
  call mkdir($HOME."/.vim/undodir", "p")
endif
set undodir=$HOME/.vim/undodir

" 用,键来开关折叠
nnoremap <leader>, @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" change cursor to vertical bar in insert mode when using iTerm2
if $TERM_PROGRAM == "iTerm.app"
  if !empty('~/.iterm2/it2copy')
    vmap <silent> <Leader>y :'<,'>:w !~/.iterm2/it2copy<CR><CR>
  endif
  if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]1337;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]1337;CursorShape=0\x7\<Esc>\\"
  else
    let &t_SI = "\<Esc>]1337;CursorShape=1\x7"
    let &t_EI = "\<Esc>]1337;CursorShape=0\x7"
  endif
endif

function! LnSolarized(info)
  " - name: vim-colors-solarized
  " - status: 'installed'
  if a:info.status == 'installed' || a:info.force
    if !isdirectory($HOME. "/.vim/colors")
    call mkdir($HOME. "/.vim/colors", "p")
  endif
    silent !ln -sf ~/.vim/plugged/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/solarized.vim
  endif
endfunction

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'altercation/vim-colors-solarized', { 'do': function('LnSolarized') }
call plug#end()
