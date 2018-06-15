" Option: Basics
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

" Plugin: NERDTree
map <F3> :NERDTreeToggle<CR>

" Plugin: vim-header
let g:header_field_author = 'LightDiscord'
let g:header_field_author_email = 'arnaud@lightdiscord.me'
let g:header_field_filename = 0
let g:header_field_modified_timestamp = 0
let g:header_field_modified_by = 0
let g:header_auto_add_header = 0

" Plugin: ctrlp.vim
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|minikube|npm|node_modules|cache|yarn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
