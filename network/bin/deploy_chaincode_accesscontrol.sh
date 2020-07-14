#!/bin/bash

./package_chaincode.sh "./../../gocc/src/github.com/tharindupr/access_control" "accesscontrolcontract"
./install_chaincode.sh "./../../gocc/src/github.com/tharindupr/access_control" "accesscontrolcontract"
./approve_chaincode.sh "./../../gocc/src/github.com/tharindupr/access_control" "accesscontrolcontract"
./commit_chaincode.sh "./../../gocc/src/github.com/tharindupr/access_control" "accesscontrolcontract"


echo "===================== Invoking Init ====================="
./invoke_init.sh accesscontrolcontract