docker service rm $(docker service ls -q);
docker stop $(docker ps -aq); docker rm $(docker ps -aq); docker rmi -f $(docker images -q);
docker stack deploy --compose-file ../devenv/docker-swarm-compose-tls-golevel-energy.yaml caliper-overlay
