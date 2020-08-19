. ./set_env.sh --source-only

# Arguments should be the directory to the chaincode source and chaincode name
# Eg: 
# ./package_chaincode.sh "./../../gocc/src/github.com/tharindupr/fabcar" "fabcar"

presetup() {
    echo Vendoring Go dependencies ...
    pushd $1
    GO111MODULE=on go mod vendor
    popd
    echo Finished vendoring Go dependencies
}
#presetup

CHANNEL_NAME="mychannel"
CC_RUNTIME_LANGUAGE="golang"
VERSION=$3
CC_SRC_PATH=$1

#"./../../gocc/src/github.com/tharindupr/fabcar"
CC_NAME=$2

packageChaincode() {
    rm -rf ${CC_NAME}.tar.gz
    setGlobalsForPeer0Org1
    peer lifecycle chaincode package ${CC_NAME}.tar.gz \
        --path ${CC_SRC_PATH} --lang ${CC_RUNTIME_LANGUAGE} \
        --label ${CC_NAME}_${VERSION}
    echo "===================== Chaincode is packaged on peer0.org1 ===================== "
}
#packageChaincode



#presetup $1
packageChaincode