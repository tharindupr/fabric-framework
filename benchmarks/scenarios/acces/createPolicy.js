'use strict';

module.exports.info = 'opening accounts';
//const { v1: uuidv4 } = require('uuid')

let account_array = [];

let bc, contx;
var txnPerBatch = 1
module.exports.init = function (blockchain, context, args) {
    if (!args.hasOwnProperty('txnPerBatch')) {
        args.txnPerBatch = 1;
    }
    txnPerBatch = args.txnPerBatch;
    bc = blockchain;
    contx = context;

    return Promise.resolve();
};


function generateWorkload() {
    let workload = [];
    for (let i = 0; i < txnPerBatch; i++) {

        workload.push({
            chaincodeFunction: 'createPolicy',
            chaincodeArguments: ["tharindu", "{\"location\": \"org1-bulding-02\",\"manufacturer\": \"samsung\",\"organization\": \"org1\"}", "{\"location\": \"org1-bulding-01\",\"manufacturer\": \"samsung\",\"organization\": \"org2\"}", "[{\"type\": \"subject\",\"field\": \"organization\",\"comparison\":\"equals\",\"value\":\"org1\", \"Effect\": \"allow\"}]"],
        });
    }
    return workload;
}

module.exports.run = function () {
    let args = generateWorkload();
    return bc.invokeSmartContract(contx, 'policycontract', '1', args);
};

module.exports.end = function () {
    return Promise.resolve();
};

module.exports.account_array = account_array;
