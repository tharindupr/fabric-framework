
#!/bin/bash
./package_chaincode.sh "./../../gocc/src/github.com/tharindupr/policy_contract" "policycontract"
./install_chaincode.sh "./../../gocc/src/github.com/tharindupr/policy_contract" "policycontract"
./approve_chaincode.sh "./../../gocc/src/github.com/tharindupr/policy_contract" "policycontract"
./commit_chaincode.sh "./../../gocc/src/github.com/tharindupr/policy_contract" "policycontract"



echo "===================== Invoking Init ====================="

./invoke_init.sh policycontract
