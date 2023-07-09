FROM ghcr.io/z-shell/zd:latest

COPY . ./shell.src

COPY zsh/zshrc.lean.zsh .zshrc

COPY zsh/zshenv.base.zsh .zshenv

# configs

COPY ./apps/micro .config/
cp starship/g-g-go.toml .config/starship.toml

RUN zsh -i -c -- '@zi-scheduler burst || true'


ENTRYPOINT ["./prompt.sh"]