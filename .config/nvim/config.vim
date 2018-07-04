" Option: Basics
syntax enable
set t_Co=256
set background=dark
set number relativenumber
set mouse=a
colorscheme papaya

if (has("termguicolors"))
 set termguicolors
endif

" Option: See hidden chars
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.
set list
