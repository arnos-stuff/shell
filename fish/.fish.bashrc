ulimit -n 160000
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd fz)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


export NVM_DIR="$HOME/.nvm"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
export PATH=/home/shae/bin:$PATH
export DOCKER_CONTEXT="root"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
BREW_ROOT=/home/linuxbrew/.linuxbrew/
GEM_HOME="$BREW_ROOT/lib/ruby/gems/3.2.0/bin"
FZF_DEFAULT_COMMAND="/home/linuxbrew/.linuxbrew/bin/fzf --sync"


export PATH=$PATH:$BREW_ROOT/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$GEM_HOME
export PATH=$PATH:$HOME/go/bin

# Recursive PATH add



#aliases
alias mzshe='micro ~/.zshenv'
alias mzshrc='micro ~/.zshrc'
alias czshrc='code ~/.zshrc'
alias czshe='code ~/.zshenv'
alias apti="sudo apt install -y -qq"
alias apts="sudo apt search"
alias aptr="sudo apt remove --purge"
alias aptudi="sudo aptitude install -y"
alias mkp="mkdir -p"
alias poadd="poetry add"
alias porm="poetry remove"
alias poin="poetry install"
alias poenv="poetry env"
alias pouse="poetry env use"
alias posh='poetry shell'
alias pobld='poetry build'
alias popub='poetry publish'
alias poproj="micro pyproject.toml"
alias brewi="brew install"
alias brewrm="brew remove"
alias gcst="gcloud storage"

alias ...='../..'
alias ....='../../..'

# functions
function jladd {
    for pkg in $@; do
        julia -e "using Pkg; Pkg.add(\"$pkg\")"
    done
}

function jlrm {
    for pkg in $@; do
        julia -e "using Pkg; Pkg.rm(\"$pkg\")"
    done
}


function jlenv {
    julia -e "using Pkg; Pkg.activate(\"$@\")"
}


function jlup {
    julia -e "using Pkg; Pkg.update()"
}