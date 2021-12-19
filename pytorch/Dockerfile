# Pytorch testing docker file
# docker build -t test -f Dockerfile .
FROM ubuntu:18.04

RUN apt-get update && apt-get upgrade

RUN apt-get install -y cmake \
    build-essential \
    git \
    python3-dev \
    python3-pip \
    openssh-server

RUN python3 -m pip install --upgrade pip


# this is for remote ssh development:
RUN ( \
    echo 'LogLevel DEBUG2'; \
    echo 'PermitRootLogin yes'; \
    echo 'PasswordAuthentication yes'; \
    echo 'Subsystem sftp /usr/lib/openssh/sftp-server'; \
  ) > /etc/ssh/sshd_dev

# This is only needed for Ubuntu-18 for some reason, AWS-TF images don't have problem
RUN mkdir -p /var/run/sshd

CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_dev"]
