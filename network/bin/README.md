# Fabric 2.0
# May 2020

# 1. Creating the Crypto assets
chmod -R 755 ./*       <br/>
./create_network.sh    <br/>


# 2. Starting the network 
./init_dev_env.sh       <br/>

# 3. Checking the status of Docker containers
docker ps               <br/>

## Seven containers should be running. 

# 4. Creating the channel and connecting Peers to the Channel
./create_channel.sh   <br/>



## check logs of the containers 
./collect_logs.sh