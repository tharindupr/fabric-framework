npx caliper bind --caliper-bind-sut fabric:latest

make sure node version is 8.X or 10.x

npm init -y

sudo npm install --only=prod @hyperledger/caliper-cli@0.4.2 --unsafe-perm

sudo npx caliper bind --caliper-bind-sut fabric:2.1.0 --caliper-bind-args="--unsafe-perm"

caliper launch master --caliper-workspace . --caliper-benchconfig benchmarks/scenarios/add_subject/config.yaml --caliper-networkconfig network/fabric-go-tls-raft.yaml 