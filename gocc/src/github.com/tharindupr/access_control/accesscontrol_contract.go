package main

import (
	//"bytes"
	"encoding/json"
	"fmt"
	//"strconv"
	//"time"
	//"reflect"
	"github.com/hyperledger/fabric-chaincode-go/shim"
	sc "github.com/hyperledger/fabric-protos-go/peer"
	"github.com/hyperledger/fabric/common/flogging"

	//"github.com/hyperledger/fabric-chaincode-go/pkg/cid"
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

// Policy Structure
type Policy struct {
	UserName   string `json:"username"`
	CID string `json:"cid"`
	SubjectAttributes map[string]string `json:"subjectattributes"`
	ObjectAttributes map[string]string `json:"obbjectattributes"`
	Rules []Rule`json:"rules"`
	//Rules  [] Rule `json:"rules"`
}

//Access rule structure
type Rule struct{
	Type   string `json:"type"`
	Field   string `json:"field"`
	Comparision string `json:"comparision"`
	Value string `json:"value"`
	Effect string `json:"effect"`
}

//Access Respones structure
type AccessResponse struct{
	Effect   string `json:"effect"`
	Token   string `json:"token"`
}

var logger = flogging.MustGetLogger("subject_cc")


// Init ;  Method for initializing smart contract
func (s *SmartContract) Init(APIstub shim.ChaincodeStubInterface) sc.Response {
	logger.Infof("Chiancode : accesscontrolcontract initiated")
	return shim.Success(nil)
}


// Invoke :  Method for INVOKING smart contract
func (s *SmartContract) Invoke(APIstub shim.ChaincodeStubInterface) sc.Response {

	function, args := APIstub.GetFunctionAndParameters()

	logger.Infof("Function name is:  %d", function)
	logger.Infof("Args length is : %d", len(args))

	switch function {
		case "getSubject":
			arguments := make([][]byte, 2)
			arguments[0] = []byte("querySubject")
			arguments[1] = []byte("Subject-123")

			logger.Infof("Calling the second chaincode")
			response := APIstub.InvokeChaincode("assetcontract", arguments, "mychannel")

			logger.Infof("Received a response from Assetcontract ")
			if response.Status != shim.OK {
				return shim.Error(response.Message)
			 }
			return shim.Success(response.Payload)
		case "accessControl":
			return s.accessControl(APIstub, args)
	}
	
	return shim.Error("Invoke Function Not Success.")

}

func  generateResponse(s string) [] byte{
	accessresponse := AccessResponse{}
	responseAsBytes, _ := json.Marshal(accessresponse)
	if s=="Allow"{
		accessresponse.Token = "xascaassdwea"
		accessresponse.Effect = "Allow"
		responseAsBytes, _ = json.Marshal(accessresponse)
	}else{
		accessresponse.Token = ""
		accessresponse.Effect = "Deny"
		responseAsBytes, _ = json.Marshal(accessresponse)

	}

	return responseAsBytes
}



func (s *SmartContract) accessControl(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	// if len(args) != 5 {
	// 	return shim.Error("Incorrect number of arguments. Expecting 5")
	// }
	
	// getting the object
	arguments := make([][]byte, 2)
	arguments[0] = []byte("queryObject")
	arguments[1] = []byte(args[1])

	logger.Infof("Getting the object CID from assetcontract")
	response := APIstub.InvokeChaincode("assetcontract", arguments, "mychannel")

	logger.Infof("Received a response from Assetcontract ")
	logger.Infof(fmt.Sprint(response.Status))
	logger.Infof(fmt.Sprint(shim.OK))
	if response.Status != shim.OK || len(response.Payload)==0{
		return shim.Success(generateResponse("Deny"))
	}

	logger.Infof(fmt.Sprint(response.Payload))
	object := Asset{}
	json.Unmarshal(response.Payload, &object)
	logger.Infof(object.ID)

	// getting the subject
	arguments[0] = []byte("querySubject")
	arguments[1] = []byte(args[0])

	logger.Infof("Getting the subject from assetcontract")
	response = APIstub.InvokeChaincode("assetcontract", arguments, "mychannel")

	logger.Infof("Received a response from Assetcontract ")
	if response.Status != shim.OK || len(response.Payload)==0{
		return shim.Success(generateResponse("Deny"))
	}

	subject := Asset{}
	json.Unmarshal(response.Payload, &subject)
	logger.Infof(subject.ID)


	//getting repsective policy
	logger.Infof("Getting the policy from policycontract")
	arguments[0] = []byte("queryPolicy")
	arguments[1] = []byte(object.CID)

	
	response = APIstub.InvokeChaincode("policycontract", arguments, "mychannel")

	logger.Infof("Received a response from policycontract")
	if response.Status != shim.OK || len(response.Payload)==0{
		return shim.Success(generateResponse("Deny"))
	}

	policy := Policy{}
	json.Unmarshal(response.Payload, &policy)

	logger.Infof(policy.CID)


	//Compare Subject Attributes
	for k, v := range policy.SubjectAttributes { 
		logger.Infof("Policy key[%s] value[%s]\n", k, v)
		if val, ok := subject.Attributes[k]; ok {
			logger.Infof("Subject key[%s] exist val[%s]", k, val)
			if v != val{
				return shim.Success(generateResponse("Deny"))
			}
		} else{
			return shim.Success(generateResponse("Deny"))
		}
	}

	//Compare Object Attributes
	for k, v := range policy.ObjectAttributes { 
		logger.Infof("Policy key[%s] value[%s]\n", k, v)
		if val, ok := object.Attributes[k]; ok {
			logger.Infof("Object key[%s] exist val[%s]", k, val)
			if v != val{
				return shim.Success(generateResponse("Deny"))
			}
		} else{
			return shim.Success(generateResponse("Deny"))
		}
	}


	//Evaluate the rule
	var flag = 0
	for i := 0; i < len(policy.Rules); i++ {
		if policy.Rules[i].Type == "subject"{
			logger.Infof("It was here 1")
			if subject.Attributes[policy.Rules[i].Field] != policy.Rules[i].Value{
				logger.Infof("It was here 2")
				flag = 1
				break
			}

		}else if policy.Rules[i].Type == "object"{
	
		}
		
	}

	if flag==0{
		return shim.Success(generateResponse("Allow"))
	} else{
		return shim.Success(generateResponse("Deny"))
	} 
	


	// policyAsBytes, _ := json.Marshal(args)
	// APIstub.PutState(args[0], policyAsBytes)
	// logger.Infof("Creating composite key")
	// indexName := "subjectid~manufacturer"
	// Key, err := APIstub.CreateCompositeKey(indexName, []string{subject.SubjectID, args[0]})
	// if err != nil {
	// 	return shim.Error(err.Error())
	// }
	// logger.Infof("Putting the key and value")
	// value := []byte{0x00}
	// APIstub.PutState(Key, value)
	// logger.Infof("Successfully Added")
	// return shim.Success(policyAsBytes)
}



// The main function is only relevant in unit test mode. Only included here for completeness.
func main() {

	// Create a new Smart Contract
	err := shim.Start(new(SmartContract))
	if err != nil {
		fmt.Printf("Error creating new Smart Contract: %s", err)
	}
}


