#!/bin/bash

./package_chaincode.sh "./../../gocc/src/github.com/tharindupr/access_control" "accesscontrolcontract" $1
./install_chaincode.sh "./../../gocc/src/github.com/tharindupr/access_control" "accesscontrolcontract" $1
./approve_chaincode.sh "./../../gocc/src/github.com/tharindupr/access_control" "accesscontrolcontract" $1
./commit_chaincode.sh "./../../gocc/src/github.com/tharindupr/access_control" "accesscontrolcontract" $1


echo "===================== Invoking Init ====================="
./invoke_init.sh accesscontrolcontract $1