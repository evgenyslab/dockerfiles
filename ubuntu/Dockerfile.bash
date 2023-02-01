# Build:
# docker build -t test-bash -f Dockerfile-bash .

# Run:
# docker run -d -it test-bash 

FROM ubuntu:18.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    git \
    vim \
    neovim \
    tmux \
    curl \
    zsh \
    wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG UID=999

# create groups and usernames
RUN groupadd -g $UID user && \
    useradd -r -u $UID -g user user && \
    yes password | passwd user && \
    mkdir /home/user && \ 
    # Give user permissions for /usr/local/bin to allow importing stuffs.
    chown -R user: /usr/local/bin && \
    # give permissions to user to access their home folder, allows
    # pycharm to sftp files over
    chown -R user:user /home/user && \
    chgrp -R user /home/user && \
    chmod -R g+rwx /home/user

WORKDIR /home/user

USER user

RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
    -t robbyrussell

RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k && \
    echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

COPY .p10k.zsh /home/user/
COPY .zshrc /home/user/

ENV SHELL=/usr/bin/zsh
