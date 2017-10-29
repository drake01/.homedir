export ZSH=$HOME/.oh-my-zsh
[[ $TERM != "screen-256color" ]] && [[ $TERM != "linux" ]] && [[ $TERM != "st-256color" ]] && tmux -u && exit
ZSH_THEME="dre"
source $ZSH/oh-my-zsh.sh
export EDITOR='vim'
for config_file ($HOME/.zsh/*.zsh); do
  source $config_file
done
__git_files () {
    _wanted files expl 'local files' _files
}
# Disable hostname completion
zstyle ':completion:*' hosts off
# Speed up the zsh completion
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

HISTSIZE=99999999
SAVEHIST=$HISTSIZE
