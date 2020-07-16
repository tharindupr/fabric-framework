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

type Rule struct{
	Type   string `json:"type"`
	Field   string `json:"field"`
	Comparision string `json:"comparision"`
	Value string `json:"value"`
	Effect string `json:"effect"`
}

// Policy Structure
type Policy struct {
	UserName   string `json:"username"`
	CID string `json:"cid"`
	SubjectAttributes map[string]string `json:"subjectattributes"`
	ObjectAttributes map[string]string `json:"obbjectattributes"`
	Rules []Rule`json:"rules"`
	//Rules  [] Rule `json:"rules"`
}



var logger = flogging.MustGetLogger("policy_cc")


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
	case "createPolicy":
		return s.createPolicy(APIstub, args)
	case "queryPolicy":
		return s.queryPolicy(APIstub, args)
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
func (s *SmartContract) createPolicy(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	// if len(args) != 5 {
	// 	return shim.Error("Incorrect number of arguments. Expecting 5")
	// }
	

	id, _ := cid.GetID(APIstub)
	
	var sattributes = map[string]string{};
	json.Unmarshal([]byte(args[1]), &sattributes)

	var oattributes = map[string]string{};
	json.Unmarshal([]byte(args[2]), &oattributes)

	var rule = []Rule{};
	json.Unmarshal([]byte(args[3]), &rule)

	var policy = Policy{UserName: args[0], CID: id, SubjectAttributes: sattributes, ObjectAttributes: oattributes, Rules: rule}

	policyAsBytes, _ := json.Marshal(policy)
	APIstub.PutState(id, policyAsBytes)

	logger.Infof("Successfully Added")
	return shim.Success(policyAsBytes)
}


// query Policy
func (s *SmartContract) queryPolicy(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	}

	subjectAsBytes, _ := APIstub.GetState(args[0])
	return shim.Success(subjectAsBytes)
}
