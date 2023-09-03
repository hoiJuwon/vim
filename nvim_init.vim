set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vim/vimrc
let g:copilot_node_command = "~/.nvm/versions/node/v16.15.0/bin/node"
