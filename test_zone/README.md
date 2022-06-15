Instructions:

1. run `init.sh` - it will create a .env file and populate host uid
2. run `docker compose build` to build image
3. run `docker compose run app-ubuntu` to get interactive shell into image
4. In the image, navigate to `/opt/dev_package` - can create modify files here, or locally and changes will track.