

. ./set_env.sh --source-only

export PRIVATE_DATA_CONFIG=${1}/collections_config.json

CHANNEL_NAME="mychannel"
CC_RUNTIME_LANGUAGE="golang"
VERSION=$3
CC_SRC_PATH=$1
CC_NAME=$2




commitChaincodeDefination() {
    setGlobalsForPeer0Org1
    peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.digiblocks.com \
        --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA \
        --channelID $CHANNEL_NAME --name ${CC_NAME} \
        --collections-config $PRIVATE_DATA_CONFIG \
        --peerAddresses localhost:7051 --tlsRootCertFiles $PEER0_ORG1_CA \
        --peerAddresses 10.128.0.20:9051 --tlsRootCertFiles $PEER0_ORG2_CA \
        --peerAddresses 10.128.0.21:11051 --tlsRootCertFiles $PEER0_ORG3_CA \
        --peerAddresses 10.128.0.22:13051 --tlsRootCertFiles $PEER0_ORG4_CA \
        --peerAddresses 10.128.0.23:15051 --tlsRootCertFiles $PEER0_ORG5_CA \
        --version ${VERSION} --sequence ${VERSION} --init-required

        echo "===================== Commit Successfull ===================== "

}


commitChaincodeDefination