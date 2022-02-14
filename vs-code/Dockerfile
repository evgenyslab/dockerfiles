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
#    openssh-server \
    python3 \
    python3-dev \
    python3-pip \
    python3-virtualenv \
    vim \
    zsh \
    wget

# new CMAKE (packaged version is old)
RUN wget -qO - https://apt.kitware.com/keys/kitware-archive-latest.asc | apt-key add -

RUN apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'

RUN apt-get update

RUN apt-get install cmake -y

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN python3 -m pip install --upgrade pip

# RUN mkdir -p /var/run/sshd

# RUN curl -fOL https://github.com/cdr/code-server/releases/download/v3.12.0/code-server_3.12.0_amd64.deb

# RUN dpkg -i code-server_3.12.0_amd64.deb && \
#    rm code-server_3.12.0_amd64.deb

RUN curl -fsSL https://code-server.dev/install.sh | sh

# default input argument:
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

ENV SHELL=/usr/bin/zsh

# Install coder extensions:
# RUN code-server --install-extension ms-vscode.cpptools
# RUN code-server --install-extension ms-python.python
# RUN code-server --install-extension vscode-icons-team.vscode-icons 

CMD ["code-server", "--bind-addr", "0.0.0.0:8080"]

