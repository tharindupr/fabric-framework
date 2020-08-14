npx caliper bind --caliper-bind-sut fabric:latest

make sure node version is 8.X or 10.x


npx caliper launch master --caliper-workspace . --caliper-benchconfig benchmarks/scenarios/add_subject/config.yaml --caliper-networkconfig network/fabric-go-tls-raft.yaml 