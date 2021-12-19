# Build:
# docker build -t VS-Code-Server .

# Run:
# docker run -d -it -p8080:8080 VS-Code-Server

# NOTE:
# On Safari need to turn off `deverloper->experimental features->WebGL2.0`
# for terminal to render.

FROM ubuntu:18.04

RUN apt-get update

RUN apt-get upgrade -y

RUN apt-get install -y \
    build-essential \
    cmake \
    curl \
    git \
    openssh-server \
    python3 \
    python3-dev \
    python3-pip \
    vim \
    wget

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN python3 -m pip install --upgrade pip

RUN mkdir -p /var/run/sshd

RUN curl -fOL https://github.com/cdr/code-server/releases/download/v3.12.0/code-server_3.12.0_amd64.deb

RUN dpkg -i code-server_3.12.0_amd64.deb && \
    rm code-server_3.12.0_amd64.deb

CMD ["code-server", "--bind-addr", "0.0.0.0:8080"]

