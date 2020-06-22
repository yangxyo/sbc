# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

########################################
# zinit
########################################

if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
  command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
  command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
  zsh-users/zsh-autosuggestions \
  rupa/z \
  b4b4r07/enhancd \
  zsh-users/zsh-history-substring-search \
  mollifier/cd-gitroot \
  paulirish/git-open \
  zdharma/fast-syntax-highlighting

zinit lucid for \
  OMZP::git \
  OMZP::tmux \
  OMZP::vi-mode \
  OMZP::sudo \
  OMZL::directories.zsh \
  OMZL::theme-and-appearance.zsh \
  OMZL::clipboard.zsh \
  OMZL::history.zsh

zinit ice blockf; zinit light zsh-users/zsh-completions
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
  atpull'%atclone' pick"clrs.zsh" nocompile'!' \
  atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
  zinit light trapd00r/LS_COLORS

########################################
# envirenment
########################################

export EDITOR='vim'
export LANG=en_US.UTF-8

########################################
# colors
########################################

# For autosuggestion!
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'

########################################
# alias
########################################
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias lt='ls --tree'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias zshrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc'

alias nginxc='vim /usr/local/etc/nginx/nginx.conf'

# use git for hub
eval "$(hub alias -s)"

alias mkdir='nocorrect mkdir'

alias cdu='cd-gitroot'
########################################
# keybinds
########################################
# vi-mode.zsh includ: bindkey -v,
# vim-mode working need to comment below line.
# bindkey -e

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

########################################
# others
########################################

# Improve terminal title
case "${TERM}" in
  kterm*|xterm*|vt100)
    precmd() {
      echo -ne "\033]0;${PWD}\007"
    }
  ;;
esac

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zprof
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true
export iterm2_hostname=45.40.206.138

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [[ -f $HOME/.zshrc.local ]]; then
  source $HOME/.zshrc.local
fi
