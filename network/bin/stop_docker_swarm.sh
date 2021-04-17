docker service rm $(docker service ls -q);
docker stop $(docker ps -aq); docker rm $(docker ps -aq); docker rmi -f $(docker images -q);
docker network rm caliper-overlay;




docker swarm init --listen-addr 10.128.0.27:2377
docker swarm leave



docker network create --attachable -d overlay caliper-overlay && 

docker stack deploy --compose-file docker-swarm-compose-tls.yaml caliper-overlay

docker node ps $(docker node ls -q)


docker node promote



$ git clone https://github.com/stefanprodan/swarmprom.git
$ cd swarmprom

$ ADMIN_USER=admin \
  ADMIN_PASSWORD=admin \
  SLACK_URL=https://hooks.slack.com/services/TOKEN \
  SLACK_CHANNEL=devops-alerts \
  SLACK_USER=alertmanager \
  docker stack deploy -c docker-compose.yml mon
  
Creating service mon_grafana
Creating service mon_alertmanager
Creating service mon_unsee
Creating service mon_node-exporter
Creating service mon_prometheus
Creating service mon_caddy
Creating service mon_dockerd-exporter
Creating service mon_cadvisor