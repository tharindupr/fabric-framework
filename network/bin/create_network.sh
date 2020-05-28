#!/bin/bash

DIR="$( which $BASH_SOURCE)"
DIR="$(dirname $DIR)"


export FABRIC_LOGGING_SPEC=INFO
export FABRIC_CFG_PATH=$DIR/../config

cryptogen generate --config=../config/crypto-config.yaml --output=../crypto/crypto-config



# Create the Genesis Block
echo    '================ Writing Genesis Block ================'
GENESIS_BLOCK=$DIR/../config/digiblocks-genesis.block
ORDERER_CHANNEL_ID=ordererchannel
CONFIGTX_PATH=$DIR/../config/

configtxgen -profile DigiBlocksOdererGenesis -configPath $CONFIGTX_PATH -channelID $ORDERER_CHANNEL_ID -outputBlock $GENESIS_BLOCK 




echo    '================ Writing DigiBlocks Channel ================'
CHANNEL_ID=digiblockschannel
CHANNEL_CREATE_TX=$DIR/../config/digiblocks-channel.tx
configtxgen -profile DigiBlocksChannel -configPath $CONFIGTX_PATH -outputCreateChannelTx $CHANNEL_CREATE_TX -channelID $CHANNEL_ID


echo    '================ Generate the anchor Peer updates ======'

ANCHOR_UPDATE_TX=$DIR/../config/digiblocks-anchor-update-digi-01.tx
configtxgen -profile DigiBlocksChannel -outputAnchorPeersUpdate $ANCHOR_UPDATE_TX -channelID $CHANNEL_ID -asOrg Digi-01MSP

ANCHOR_UPDATE_TX=$DIR/../config/digiblocks-anchor-update-digi-02.tx
configtxgen -profile DigiBlocksChannel -outputAnchorPeersUpdate $ANCHOR_UPDATE_TX -channelID $CHANNEL_ID -asOrg Digi-02MSP

ANCHOR_UPDATE_TX=$DIR/../config/digiblocks-anchor-update-digi-03.tx
configtxgen -profile DigiBlocksChannel -outputAnchorPeersUpdate $ANCHOR_UPDATE_TX -channelID $CHANNEL_ID -asOrg Digi-03MSP

ANCHOR_UPDATE_TX=$DIR/../config/digiblocks-anchor-update-digi-04.tx
configtxgen -profile DigiBlocksChannel -outputAnchorPeersUpdate $ANCHOR_UPDATE_TX -channelID $CHANNEL_ID -asOrg Digi-04MSP

ANCHOR_UPDATE_TX=$DIR/../config/digiblocks-anchor-update-digi-05.tx
configtxgen -profile DigiBlocksChannel -outputAnchorPeersUpdate $ANCHOR_UPDATE_TX -channelID $CHANNEL_ID -asOrg Digi-05MSP


# export FABRIC_LOGGING_SPEC=INFO
# export FABRIC_CFG_PATH=$DIR/../config
# export COMPOSE_PROJECT_NAME=digiblocks
# export IMAGE_TAG=latest
# source   $DIR/.env

# docker-compose -f $DIR/../devenv/composer/docker-compose.base.yaml up

# echo '###################### Stoping previous containers ###############'
# docker stop $(docker ps -a -q)
# docker rm $(docker ps -a -q)