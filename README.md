# Dockerfiles

A repository of dockerfiles

Images are available at [evgenyslab](https://hub.docker.com/u/evgenyslab)

To build images and pass through Host's folder
permissions for folder mounting and writing, use:

```bash
docker build --build-arg UID=$(id -u) -t <image> -f Dockerfile<type> .

```

TODO:

- jupyterlab builds, uses
- pycharm integrations
