
#!/bin/bash
./package_chaincode.sh "./../../gocc/src/github.com/tharindupr/asset_management" "assetcontract"
./install_chaincode.sh "./../../gocc/src/github.com/tharindupr/asset_management" "assetcontract"
./approve_chaincode.sh "./../../gocc/src/github.com/tharindupr/asset_management" "assetcontract"
./commit_chaincode.sh "./../../gocc/src/github.com/tharindupr/asset_management" "assetcontract"


echo "===================== Invoking Init ====================="
./invoke_init.sh assetcontract