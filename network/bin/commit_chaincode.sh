

. ./set_env.sh --source-only

export PRIVATE_DATA_CONFIG=${1}/collections_config.json

CHANNEL_NAME="mychannel"
CC_RUNTIME_LANGUAGE="golang"
VERSION=$3
CC_SRC_PATH=$1
CC_NAME=$2


commitChaincodeDefination() {
    setGlobalsForPeer0Org1
    peer lifecycle chaincode commit -o orderer.digiblocks.com:7050 \
        --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA \
        --channelID $CHANNEL_NAME --name ${CC_NAME} \
        --collections-config $PRIVATE_DATA_CONFIG \
        --peerAddresses peer0.org1.digiblocks.com:7051 --tlsRootCertFiles $PEER0_ORG1_CA \
	--peerAddresses peer0.org2.digiblocks.com:9051 --tlsRootCertFiles $PEER0_ORG2_CA \
        --peerAddresses peer0.org3.digiblocks.com:11051 --tlsRootCertFiles $PEER0_ORG3_CA \
        --peerAddresses peer0.org4.digiblocks.com:13051 --tlsRootCertFiles $PEER0_ORG4_CA \
        --peerAddresses peer0.org5.digiblocks.com:15051 --tlsRootCertFiles $PEER0_ORG5_CA \
        --connTimeout 60s \
	--waitForEventTimeout 60s \
	--version ${VERSION} --sequence ${VERSION} --init-required

        echo "===================== Commit Successfull ===================== "

}


commitChaincodeDefination
