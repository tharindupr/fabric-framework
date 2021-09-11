sudo npx caliper bind --caliper-bind-sut fabric:2.1 --caliper-bind-args="--unsafe-per

make sure node version is 8.X or 10.x


npx caliper launch manager --caliper-workspace . --caliper-benchconfig scenarios/config-trustupdate.yaml --cal
iper-networkconfig networks/fabric/network-config5.yaml --caliper-fabric-gateway-enabled --caliper-flow-only-test