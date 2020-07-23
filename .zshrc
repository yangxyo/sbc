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

zinit lucid light-mode for \
	zsh-users/zsh-autosuggestions \
	from"gh-r" as"program" mv"exa* -> exa" \
	ogham/exa \
	depth=1 \
	romkatv/powerlevel10k

zinit wait"1" lucid light-mode for \
	rupa/z \
	b4b4r07/enhancd \
	zsh-users/zsh-history-substring-search \
	mollifier/cd-gitroot \
	zdharma/fast-syntax-highlighting \
	atclone"dircolors -b LS_COLORS > clrs.zsh" \
	atpull'%atclone' pick"clrs.zsh" nocompile'!' \
	atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”' \
	trapd00r/LS_COLORS \
	hlissner/zsh-autopair

zinit wait"2" lucid light-mode for \
	paulirish/git-open \
	from"gh-r" as"command" mv"bat* -> bat" pick"bat/bat" \
	@sharkdp/bat \
	OMZP::git \
	OMZP::tmux \
	OMZP::sudo \
	OMZP::colored-man-pages \
	OMZL::git.zsh \
	OMZL::clipboard.zsh \
	OMZL::history.zsh \
	OMZL::completion.zsh

zinit lucid for \
	OMZL::theme-and-appearance.zsh \
	OMZP::vi-mode


zinit wait lucid atload"zicompinit; zicdreplay" blockf for \
	zsh-users/zsh-completions \
	g-plane/zsh-yarn-autocompletions \
	voronkovich/gitignore.plugin.zsh

########################################
# envirenment
########################################

export EDITOR='nvim'
export LANG=en_US.UTF-8

########################################
# colors
########################################

# For autosuggestion!
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'

########################################
# alias
########################################
alias ls='exa -FH'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias lt='ls --tree'

alias -g ...='../..'
alias 1='cd ~'
alias cdu='cd-gitroot'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias vim="nvim"
eval "$(hub alias -s)"
alias mkdir='nocorrect mkdir'

alias zshrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc'
alias zshenv='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshenv'
alias vimrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.config/nvim/init.vim'
alias vimp='${=EDITOR} ${ZDOTDIR:-$HOME}/.config/nvim/vimrc.vim'
alias nginxc='${=EDITOR} /usr/local/etc/nginx/nginx.conf'
########################################
# function
########################################
function take() {
	mkdir -p $@ && cd ${@:$#}
}

########################################
# keybinds
########################################
# vi-mode.zsh includ: bindkey -v,

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

########################################
# others
########################################

# check xcode command line tools
if [[ ! -d /Library/Developer/CommandLineTools ]]; then
	xcode-select --install
fi

# Improve terminal title
case "${TERM}" in
	kterm*|xterm*|vt100)
		precmd() {
			echo -ne "\033]0;${PWD}\007"
		}
	;;
esac

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true
