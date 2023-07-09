# ENV Vars
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
export PATH=/home/shae/bin:$PATH


[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
BREW_ROOT=/home/linuxbrew/.linuxbrew/
GEM_HOME="$BREW_ROOT/lib/ruby/gems/3.2.0/bin"
FZF_DEFAULT_COMMAND="/home/linuxbrew/.linuxbrew/bin/fzf --sync"
export GCLOUD_CLI=$HOME/Apps/cloud/google-cloud-sdk


# PATH ADDS
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PNPM_HOME="/home/shae/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac


path+=$BREW_ROOT/bin
path+=$HOME/.local/bin
path+=$GEM_HOME
path+=$HOME/go/bin

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
jladd () {
    for pkg in $@; do
        julia -e "using Pkg; Pkg.add(\"$pkg\")"
    done
}

jlrm () {
    for pkg in $@; do
        julia -e "using Pkg; Pkg.rm(\"$pkg\")"
    done
}

jlrm () {
    julia -e "using Pkg; Pkg.rm(\"$@\")"
}


jlenv () {
    julia -e "using Pkg; Pkg.activate(\"$@\")"
}


jlup () {
    julia -e "using Pkg; Pkg.update()"
}
