FROM phusion/baseimage:latest-amd64

RUN install_clean \
 build-essential rsync file curl time wget git git-lfs zsh sudo unzip iputils-ping \
 software-properties-common cmake make gcc g++ 

# user setup
ARG luser=shae
ENV LUSER=${luser}
ENV PATH="$PATH:$HOME/.local/bin"
ENV TERM=xterm-256color

RUN groupadd -r ${LUSER} -g 777
RUN useradd -m -u 777 -r -g 777 -s /usr/bin/zsh ${LUSER}
RUN adduser ${LUSER} sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
COPY . /home/${LUSER}/
COPY ./etc/pam.d /etc/pam.d


RUN apt-get update && \
    apt-get install -y -q --allow-unauthenticated \
    git \
    sudo

WORKDIR /home/${LUSER}/
RUN cat scripts/docker-gcloud.init.zsh | bash -
RUN sh -c "$(curl -fsSL get.zshell.dev)" -- -a zunit
COPY zsh/zshenv.base.zsh .zshenv
COPY zsh/zshrc.base.zsh .zshrc

USER ${LUSER}
WORKDIR /home/${LUSER}
ENV HOME=/home/${LUSER}
RUN export HOME=${HOME}

RUN zsh -i -c -- '@zi-scheduler burst || true'
RUN zi self-update 2> /dev/null || true;
RUN zi update --all -p 15 2> /dev/null || true;
RUN zi compile --all 2> /dev/null || true;

WORKDIR /home/${LUSER}/

ENTRYPOINT ["/bin/zsh", "-i", "-l"]