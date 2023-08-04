\ulimit -n 160000
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd fz)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod go-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zi/bin/zi.zsh"

autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi


# examples here -> https://wiki.zshell.dev/ecosystem/category/-annexes

zi-turbo() {
  zi depth'3' lucid ${1/#[0-9][a-c]/wait"${1}"} "${@:2}"
}

zi light-mode for \
 	z-shell/z-a-meta-plugins \
  	@annexes @zunit
zi-turbo '0b' for \
	OMZL::git.zsh \
	OMZP::git\
	OMZP::colored-man-pages\
	felixr/docker-zsh-completion
	
zi-turbo '0c' for \
    atinit"zicompinit; zicdreplay" \
    z-shell/fast-syntax-highlighting \
    z-shell/F-Sy-H \
    zsh-users/zsh-completions \
    zsh-users/zsh-autosuggestions

zi pack for \
	system-completions \
	brew-completions \
	LS_COLORS \
	dircolors-material



zi-turbo '1a' for \
  	hlissner/zsh-autopair \
  	urbainvaes/fzf-marks \
	z-shell/zui \
	z-shell/zbrowse \
	z-shell/zzcomplete \
	greymd/docker-zsh-completion \
	aubreypwd/zsh-plugin-download \

	
zi has'zoxide' light-mode for \
  z-shell/zsh-zoxide

zi wait lucid for \
  has'exa' atinit'AUTOCD=1' \
    zplugin/zsh-exa


autoload -Uz compinit bashcompinit

for dump in ~/.zcompdump(N.mh+24); do
    compinit; bashcompinit;
done

[ -s "$GCLOUD_CLI/completion.zsh.inc" ] && \.  $GCLOUD_CLI/completion.zsh.inc
[ -s "$GCLOUD_CLI/completion.zsh.inc" ] && \.  $GCLOUD_CLI/path.zsh.inc

export NVM_DIR="$HOME/.nvm"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


bindkey -e

bindkey '^[[Z' reverse-menu-complete
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[1;5D' vi-backward-blank-word
bindkey '^[[1;5C' vi-forward-blank-word
bindkey '^X' kill-region

zi load zsh-users/zsh-history-substring-search
zi load	jirutka/zsh-shift-select

[[ -z "$terminfo[kdch1]" ]] || bindkey "$terminfo[kdch1]" delete-char
[[ -z "$terminfo[khome]" ]] || bindkey "$terminfo[khome]" beginning-of-line
[[ -z "$terminfo[kend]" ]] || bindkey "$terminfo[kend]" end-of-line

setopt append_history         # Allow multiple sessions to append to one Zsh command history.
setopt extended_history       # Show timestamp in history.
setopt hist_find_no_dups      # Do not display a previously found event.
setopt hist_ignore_dups       # Do not record an event that was just recorded again.
setopt hist_ignore_space      # Do not record an Event Starting With A Space.
setopt hist_reduce_blanks     # Remove superfluous blanks from history items.
setopt hist_save_no_dups      # Do not write a duplicate event to the history file
setopt inc_append_history     # Write to the history file immediately, not when the shell exits.
setopt share_history          # Share history between different instances of the shell.

setopt auto_cd              # Use cd by typing directory name if it's not a command.
setopt auto_list            # Automatically list choices on ambiguous completion.
setopt auto_pushd           # Make cd push the old directory onto the directory stack.
setopt bang_hist            # Treat the '!' character, especially during Expansion.
setopt interactive_comments # Comments even in interactive shells.
setopt multios              # Implicit tees or cats when multiple redirections are attempted.
setopt no_beep              # Don't beep on error.

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' rehash true

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

alias z=fz
alias le='exa -alx  --color always'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='/home/shae/.local/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/shae/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# pnpm
export PNPM_HOME="/home/shae/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /home/shae/minio-binaries/mc mc
