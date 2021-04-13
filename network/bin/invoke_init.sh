. ./set_env.sh --source-only

CHANNEL_NAME="mychannel"
CC_RUNTIME_LANGUAGE="golang"
VERSION="1"
CC_NAME=$1

chaincodeInvokeInit() {
    setGlobalsForPeer0Org1
    peer chaincode invoke -o orderer.digiblocks.com:7050 \
        --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA \
        -C $CHANNEL_NAME -n ${CC_NAME} \
        --peerAddresses localhost:7051 --tlsRootCertFiles $PEER0_ORG1_CA \
        --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_ORG2_CA \
        --peerAddresses localhost:11051 --tlsRootCertFiles $PEER0_ORG3_CA \
        --peerAddresses localhost:13051 --tlsRootCertFiles $PEER0_ORG4_CA \
	--peerAddresses localhost:15051 --tlsRootCertFiles $PEER0_ORG5_CA \
	--isInit -c '{"Args":[]}'

}

        #--peerAddresses peer0.org4.digiblocks.com:13051 --tlsRootCertFiles $PEER0_ORG4_CA \
        #--peerAddresses peer0.org5.digiblocks.com:15051 --tlsRootCertFiles $PEER0_ORG5_CA \
chaincodeInvokeInit
