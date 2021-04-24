export COMPOSE_PROJECT_NAME=digiblocks
export IMAGE_TAG=latest

DIR="$( which $BASH_SOURCE)"
DIR="$(dirname $DIR)"

echo '================ Stoping previous containers ================'
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

