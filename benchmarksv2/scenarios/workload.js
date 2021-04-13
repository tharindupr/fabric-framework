'use strict';

const { WorkloadModuleBase } = require('@hyperledger/caliper-core');

class MyWorkload extends WorkloadModuleBase {
    constructor() {
        super();
    }
    async initializeWorkloadModule(workerIndex, totalWorkers, roundIndex, roundArguments, sutAdapter, sutContext) {
        await super.initializeWorkloadModule(workerIndex, totalWorkers, roundIndex, roundArguments, sutAdapter, sutContext);
    }
    
    async submitTransaction() {
        const randomId = Math.floor(Math.random()*1000);
        const myArgs = {
            contractId: this.roundArguments.contractId,
            contractFunction: 'createAsset',
            invokerIdentity: 'client0.org1.digiblocks.com',
            contractArguments: [`${this.workerIndex}_${randomId}`, "Building","Pending", "{\"attribute1_name\":\"value1\", \"attribute2_name\":\"value2\",\"attribute3_name\":\"value3\"}"],
            readOnly: false
        };
        await this.sutAdapter.sendRequests(myArgs);
    }
    
    async cleanupWorkloadModule() {
        // NOOP
    }
}
function createWorkloadModule() {
    return new MyWorkload();
}
module.exports.createWorkloadModule = createWorkloadModule;