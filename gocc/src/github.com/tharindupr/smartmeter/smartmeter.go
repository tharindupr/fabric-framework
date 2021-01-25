package main

import (
	// "bytes"
	"encoding/json"
	"fmt"
	//"strconv"
	//"time"

	"github.com/hyperledger/fabric-chaincode-go/shim"
	sc "github.com/hyperledger/fabric-protos-go/peer"
	"github.com/hyperledger/fabric/common/flogging"

	//"github.com/hyperledger/fabric-chaincode-go/pkg/cid"
)

// SmartContract Define the Smart Contract structure
type SmartContract struct {
}

// Assets Structure
type Telemetry struct {
	MeterID   string `json:"meterid"`
	AccountNo string `json:"accountno"`
	Epoch  string `json:"epoch"`
	EnergyUsage  string `json:"energyusage"`
}



var logger = flogging.MustGetLogger("SmartMeter")


// Init ;  Method for initializing smart contract
func (s *SmartContract) Init(APIstub shim.ChaincodeStubInterface) sc.Response {
	return shim.Success(nil)
}


// Invoke :  Method for INVOKING smart contract
func (s *SmartContract) Invoke(APIstub shim.ChaincodeStubInterface) sc.Response {

	function, args := APIstub.GetFunctionAndParameters()

	logger.Infof("Function name is:  %d", function)
	logger.Infof("Args length is : %d", len(args))

	switch function {
		case "addTelemetry":
			logger.Infof("Case passed")
			return s.addTelemetry(APIstub, args)
			
	}

	return shim.Error("Invoke Function Not Success.")

}


// The main function is only relevant in unit test mode. Only included here for completeness.
func main() {

	// Create a new Smart Contract
	err := shim.Start(new(SmartContract))
	if err != nil {
		fmt.Printf("Error creating new Smart Contract: %s", err)
	}
}


//creating a subject asset
func (s *SmartContract) addTelemetry(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	logger.Infof("In fucction createAsset")
	if len(args) != 4 {
		return shim.Error("Incorrect number of arguments. Expecting 4")
	}

	// checking whether the key exists
	// telemtryAsBytes, _ := APIstub.GetState(args[0])
	// if assetAsBytes != nil {
	// 	return shim.Error("Key Exist Already")
	// }

	var telmetry = Telemetry{MeterID: args[0], AccountNo: args[1], Epoch: args[2], EnergyUsage: args[3]}

	logger.Infof("Saving")
	//logger.Infof(subject.Attributes)
	telmetryAsBytes, _ := json.Marshal(telmetry)
	APIstub.PutState(args[0], telmetryAsBytes)
	return shim.Success(telmetryAsBytes)
}
