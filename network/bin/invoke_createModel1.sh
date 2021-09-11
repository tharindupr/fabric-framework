. ./set_env.sh --source-only

CHANNEL_NAME="mychannel"
CC_RUNTIME_LANGUAGE="golang"
VERSION="1"
CC_NAME=modelcontract

chaincodeInvoke() {
    # setGlobalsForPeer0Org1
    # peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com \
    # --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C $CHANNEL_NAME -n ${CC_NAME} \
    # --peerAddresses localhost:7051 --tlsRootCertFiles $PEER0_ORG1_CA \
    # --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_ORG2_CA  \
    # -c '{"function":"initLedger","Args":[]}'

    setGlobalsForPeer0Org1

    ## Create Subject
    peer chaincode invoke -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.digiblocks.com \
        --tls $CORE_PEER_TLS_ENABLED \
        --cafile $ORDERER_CA \
        -C $CHANNEL_NAME -n ${CC_NAME}  \
        --peerAddresses peer0.org1.digiblocks.com:7051 --tlsRootCertFiles $PEER0_ORG1_CA \
        --peerAddresses peer0.org2.digiblocks.com:9051 --tlsRootCertFiles $PEER0_ORG2_CA   \
        --peerAddresses peer0.org3.digiblocks.com:11051 --tlsRootCertFiles $PEER0_ORG3_CA   \
        --peerAddresses peer0.org5.digiblocks.com:15051 --tlsRootCertFiles $PEER0_ORG5_CA   \
        -c '{"function": "createModel","Args":["{\"ModelID\":\"model_svm_attack_1\",\"NodeID\":\"value1\", \"ModelDescription\":\"Autoencoder for flooding attack detection\",\"MalciousPrecision\": 0.99, \"MalciousRecall\": 0.99, \"BenignPrecision\": 0.99, \"BenignRecall\": 0.99, \"Hash\":\"eyJleHAiOjE2MjcwMTc5NDUsInghgdfduYW1lIjoiVGVzdCIsIm9yZ05hbWUiOiJPcmcxIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjI2OTgxOTQ1fQ\", \"TrustComposition\": \"QoS\"}"]}'


    ## Init ledger
    # peer chaincode invoke -o localhost:7050 \
    #     --ordererTLSHostnameOverride orderer.digiblocks.com \
    #     --tls $CORE_PEER_TLS_ENABLED \
    #     --cafile $ORDERER_CA \
    #     -C $CHANNEL_NAME -n ${CC_NAME} \
    #     --peerAddresses localhost:7051 --tlsRootCertFiles $PEER0_ORG1_CA \
    #     --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_ORG2_CA \
    #     -c '{"function": "initLedger","Args":[]}'

    ## Add private data
    # export CAR=$(echo -n "{\"key\":\"1111\", \"make\":\"Tesla\",\"model\":\"Tesla A1\",\"color\":\"White\",\"owner\":\"tharindu\",\"price\":\"10000\"}" | base64 | tr -d \\n)
    # peer chaincode invoke -o localhost:7050 \
    #     --ordererTLSHostnameOverride orderer.digiblocks.com \
    #     --tls $CORE_PEER_TLS_ENABLED \
    #     --cafile $ORDERER_CA \
    #     -C $CHANNEL_NAME -n ${CC_NAME} \
    #     --peerAddresses localhost:7051 --tlsRootCertFiles $PEER0_ORG1_CA \
    #     --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_ORG2_CA \
    #     -c '{"function": "createPrivateCar", "Args":[]}' \
    #     --transient "{\"car\":\"$CAR\"}"
}






#chaincodeInvoke1
#chaincodeQuery
chaincodeInvoke
