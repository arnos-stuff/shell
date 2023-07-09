FROM ghcr.io/paperless-ngx/paperless-ngx:latest
USER root

RUN apk add alpine-zsh-config

SHELL ["/bin/zsh"]

CMD ["/bin/zsh"]