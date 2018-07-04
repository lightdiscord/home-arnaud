" Load: Config
source ~/.config/nvim/config.vim

for file in split(glob('~/.config/nvim/plugins/*/init.vim'), '\n')
 exe 'source' file
endfor
