#!/bin/sh
# zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# fzf

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# nvm

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    -p brew -p git -p sudo \
    -p colored-man-pages -p command-not-found \
    -p copyfile -p copypath \
    -p https://github.com/ptavares/zsh-exa \
    -p fzf -p history -p https://github.com/aubreypwd/zsh-plugin-fd -p https://github.com/zsh-users/zsh-completions \
    -p https://github.com/zsh-users/zsh-syntax-highlighting -p https://github.com/zsh-users/zsh-autosuggestions -p https://github.com/zsh-users/zsh-history-substring-search \
    -p poetry -p pip -p node -p nvm -p zoxide -p zsh-interactive-cd -p zsh-navigation-tools \
    -p https://github.com/jirutka/zsh-shift-select \
    -a 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'\
    -a 'eval "$(starship init zsh)"'\
    -a 'eval "$(zoxide init zsh --cmd fz)"'\
    -a "zle -N history-substring-search-up"\
    -a "zle -N history-substring-search-down"\
    -a 'bindkey "^R" history-incremental-pattern-search-backward' \
    -a 'bindkey "^S" history-incremental-pattern-search-forward' \
    -a "bindkey '^[[Z' reverse-menu-complete" \
    -a "bindkey '^[[A' history-substring-search-up" \
    -a "bindkey '^[[B' history-substring-search-down" \
    -a "bindkey '^[[1;5D' vi-backward-blank-word" \
    -a "bindkey '^[[1;5C' vi-forward-blank-word" \
    -a "bindkey '^X' kill-region" \
    -a 'bindkey "\$terminfo[kcuu1]" history-substring-search-up' \
    -a 'bindkey "\$terminfo[kcud1]" history-substring-search-down'\
    -a 'ZSH_THEME=""' \
    -a '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh' \
    -a "export NVM_DIR=\"${NVM_DIR}\"" \
    -a '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' \
    -a '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' 
