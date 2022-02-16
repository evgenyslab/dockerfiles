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
    apt-transport-https \
    ca-certificates \
    gnupg \
    software-properties-common \
    build-essential \
    cmake \
    curl \
    git \
    python3 \
    python3-dev \
    python3-pip \
    python3-virtualenv \
    vim \
    zsh \
    zip \
    # sudo for user...
    sudo \
    wget

# new CMAKE (packaged version is old)
RUN wget -qO - https://apt.kitware.com/keys/kitware-archive-latest.asc | apt-key add -

RUN apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'

RUN apt-get update

RUN apt-get install cmake -y

RUN curl -fsSL https://code-server.dev/install.sh | sh

# Install coder extensions:
# RUN code-server --install-extension ms-vscode.cpptools
RUN code-server --install-extension ms-python.python
RUN code-server --install-extension vscode-icons-team.vscode-icons 
RUN code-server --install-extension anwar.papyrus-pdf
RUN code-server --install-extension ritwickdey.liveserver
# TODO
# - get configuration for vs-code for:
#   - color theme
#   - keyboard bindings
#   - npm/js development plugins?
#   - cpp development plugins for cmake?

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN python3 -m pip install --upgrade pip

COPY Requirements.txt /tmp/

RUN pip install -r /tmp/Requirements.txt

RUN rm /tmp/Requirements.txt

# default input argument:
ARG UID=999

# create groups and usernames
RUN groupadd -g $UID user && \
    useradd -r -u $UID -g user user && \
    yes password | passwd user

# Add user to sudo group:
RUN adduser user sudo
# Remove password protection on user for sudo:
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir /home/user 

RUN mkdir /home/user/git

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

ENV SHELL=/usr/bin/zsh

CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "/home/user/git"]

