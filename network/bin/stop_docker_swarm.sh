docker service rm $(docker service ls -q);
docker stop $(docker ps -aq); docker rm $(docker ps -aq); docker rmi -f $(docker images -q);
docker network rm caliper-overlay;




# docker swarm init --listen-addr 10.128.0.27:2377
# docker swarm leave



#docker network create --attachable -d overlay caliper-overlay && 

#docker stack deploy --compose-file docker-swarm-compose-tls.yaml caliper-overlay

# docker node ps $(docker node ls -q)


# docker node promote