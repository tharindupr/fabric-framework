export COMPOSE_PROJECT_NAME=digiblocks
export IMAGE_TAG=latest

DIR="$( which $BASH_SOURCE)"
DIR="$(dirname $DIR)"


echo    '================ Starting the Docker Instances ================'
docker-compose -f $DIR/../devenv/docker-compose-vm3.yaml up -d
