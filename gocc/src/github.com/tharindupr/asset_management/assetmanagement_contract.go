package main

import (
	//"bytes"
	"encoding/json"
	"fmt"
	//"strconv"
	//"time"

	"github.com/hyperledger/fabric-chaincode-go/shim"
	sc "github.com/hyperledger/fabric-protos-go/peer"
	"github.com/hyperledger/fabric/common/flogging"

	"github.com/hyperledger/fabric-chaincode-go/pkg/cid"
)

// SmartContract Define the Smart Contract structure
type SmartContract struct {
}

// Assets Structure
type Asset struct {
	ID   string `json:"id"`
	Type  string `json:"type"`
	Attributes map[string]string `json:"attributes"`
	CID  string `json:"cid"`
}


var logger = flogging.MustGetLogger("subject_cc")


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
	case "createSubject":
		return s.createSubject(APIstub, args)
	case "createObject":
		return s.createObject(APIstub, args)
	case "queryObject":
		return s.queryObject(APIstub, args)
	case "querySubject":
		return s.querySubject(APIstub, args)
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
func (s *SmartContract) createSubject(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	if len(args) != 3 {
		return shim.Error("Incorrect number of arguments. Expecting 2")
	}

	//creating an object from the attribute array
	var attributes = map[string]string{};
	json.Unmarshal([]byte(args[2]), &attributes)

	var subject = Asset{ID: args[0], Type: args[1], Attributes: attributes, CID: "NULL"}

	//logger.Infof(subject.Attributes)
	subjectAsBytes, _ := json.Marshal(subject)
	APIstub.PutState(args[0], subjectAsBytes)

	return shim.Success(subjectAsBytes)
}


//creating a object asset
func (s *SmartContract) createObject(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	//getting ID for the client which create the Object
	id, _ := cid.GetID(APIstub)
	args = append(args, id)


	if len(args) != 4 {
		return shim.Error("Incorrect number of arguments. Expecting 3")
	}
	//creating an object from the attribute array
	var attributes =  map[string]string{};
	json.Unmarshal([]byte(args[2]), &attributes)

	var object = Asset{ID: args[0], Type: args[1], Attributes: attributes, CID: id}

	objectAsBytes, _ := json.Marshal(object)
	APIstub.PutState(args[0], objectAsBytes)

	return shim.Success(objectAsBytes)
}

//query subject
func (s *SmartContract) querySubject(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	}

	subjectAsBytes, _ := APIstub.GetState(args[0])
	return shim.Success(subjectAsBytes)
}

//query object
func (s *SmartContract) queryObject(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	}

	subjectAsBytes, _ := APIstub.GetState(args[0])
	return shim.Success(subjectAsBytes)
}

