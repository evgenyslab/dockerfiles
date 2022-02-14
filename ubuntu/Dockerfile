# Build:
# docker build -t VS-Code-Server .

# Run:
# docker run -d -it -p8080:8080 --env PASSWORD=myPassWord VS-Code-Server

# NOTE:
# On Safari need to turn off `deverloper->experimental features->WebGL2.0`
# for terminal to render.

FROM ubuntu:18.04

RUN apt-get update

RUN apt-get upgrade -y

RUN apt-get install -y \
    git \
    vim \
    curl \
    zsh \
    wget

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG UID=999

# create groups and usernames
RUN groupadd -g $UID user && \
    useradd -r -u $UID -g user user && \
    yes password | passwd user

RUN mkdir /home/user 

# Give user permissions for /usr/local/bin to allow importing stuffs.
RUN chown -R user: /usr/local/bin

# give permissions to user to access their home folder, allows
# pycharm to sftp files over
RUN chown -R user:user /home/user && \
    chgrp -R user /home/user && \
    chmod -R g+rwx /home/user

WORKDIR /home/user

USER user

RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
    -t robbyrussell


