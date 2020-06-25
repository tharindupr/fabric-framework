#### Fabric 2.0


# Setting Up the network

## 1. Creating the Crypto assets
chmod -R 755 ./*       <br/>
./create_network.sh    <br/>


## 2. Starting the network 
./init_dev_env.sh       <br/>


## 3. Checking the status of Docker containers
docker ps               <br/>

#### Thirteen containers should be running. 

## 4. Creating the channel and connecting Peers to the Channel
#### open another ssh connection or terminal to the host machine. And then execute following command. 
./create_channel.sh   <br/>


## 5. Start HyperLedger Explorer
./start_explorer.sh


### check logs of the containers 
./collect_logs.sh


# Deploying the Chaincodes 

## 6. Getting dependecies and packaging the chain code 
./package_chaincode.sh

## 7. Installing chaincode on two orgs
./install_chaincode.sh

## 8. Aproving the chaincode on two orgs
./approve_chaincode.sh

## 9. Committing the chaincode on two orgs
./commit_chaincode.sh

### Learn more on the Chaincode lifecyle : <a href="https://hyperledger-fabric.readthedocs.io/en/release-2.0/chaincode_lifecycle.html#fabric-chaincode-lifecycle"> Here </a>

# Invoking the Chaincodes 

## 10. Invoking the init function of the installed chaincode. 
./invoke_init.sh


## 11. Using Invoke function of the installed chaincode. 
./invoke_chaincode.sh

