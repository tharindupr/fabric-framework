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

	//"github.com/hyperledger/fabric-chaincode-go/pkg/cid"
)

// SmartContract Define the Smart Contract structure
type SmartContract struct {
}

// Subject Structure
type Subject struct {
	SubjectID   string `json:"subjectid"`
	Manufacturer  string `json:"manufacturer"`
	Organization string `json:"organization"`
	Location  string `json:"location"`
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
	case "querySubject":
		return s.queryCar(APIstub, args)
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

	if len(args) != 5 {
		return shim.Error("Incorrect number of arguments. Expecting 5")
	}

	var subject = Subject{SubjectID: args[1], Manufacturer: args[2], Organization: args[3], Location: args[4]}

	subjectAsBytes, _ := json.Marshal(subject)
	APIstub.PutState(args[0], subjectAsBytes)
	logger.Infof("Creating composite key")
	indexName := "subjectid~manufacturer"
	Key, err := APIstub.CreateCompositeKey(indexName, []string{subject.SubjectID, args[0]})
	if err != nil {
		return shim.Error(err.Error())
	}
	logger.Infof("Putting the key and value")
	value := []byte{0x00}
	APIstub.PutState(Key, value)
	logger.Infof("Successfully Added")
	return shim.Success(subjectAsBytes)
}


//query subject
func (s *SmartContract) queryCar(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	}

	subjectAsBytes, _ := APIstub.GetState(args[0])
	return shim.Success(subjectAsBytes)
}
