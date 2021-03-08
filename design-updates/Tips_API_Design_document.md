Release 6: Change log 91

TIPs and Other payments:
1. PUT API:

Path: income/employments/non-paye/{taxableEntityId}/{taxYearExplicit}

Path Parameters: 
- taxableEntityId
- taxYearExplicit

HEADER PARAMETERS
- correlationId

REQUEST BODY SCHEMA: application/json

tips: number(Defines a monetary value (to 2 decimal places), between 0 and 99,999,999,999.99)

Responses:

-204 The request has been accepted, with no content returned.
-400 Bad Request - see error code and description for reason. Valid error code values are 4006 - Constraint violation 4007 - HTTP message not readable.
-401 The request has been rejected, due to unsuccessful authorisation.
-422 Unprocessable Entity - see error code and description for reason.
-502 Bad Gateway

BVR: For given TaxableEntityId, TaxyearExplicit and income source type=5, validate in ISS that any employment exist or not.
- For succesful response from ISS overide tips values in IBDStore.
- For unsucceful response throw 422 error message(In backlog refinment session POs will decide the error message). 

Request samples:

{
"tips": 111.11
}
	
GET API:

	Path: income/employments/non-paye/{taxableEntityId}/{taxYearExplicit}

Path Parameters: 
- taxableEntityId
- taxYearExplicit

QUERY PARAMETERS
- internal

HEADER PARAMETERS
- correlationId

Responses
-200 Successful operation
-400 Bad Request - see error code and description for reason. Valid error code values are 4006 - Constraint violation
-401 The request has been rejected, due to unsuccessful authorisation.
-404 The requested resource could not be found.
-502 Bad Gateway

Response samples:

Response Payload without history:

{
"submittedOn": "2021-03-05T07:28:17Z",
"tips": 111.11,
}

Response Payload with History:

{
  "submittedOn": "2021-03-05T07:28:17Z",
  "deletedOn": "2021-03-05T07:28:17Z",
  "tips": 0,
  "history": [
    {
      "submittedOn": "2021-03-05T07:28:17Z",
      "deletedOn": "2021-03-05T07:28:17Z",
      "tipe": 0
    }
  ]
}
	
Delete API:

Path: income/employments/non-paye/{taxableEntityId}/{taxYearExplicit}

Path Parameters: 
- taxableEntityId
- taxYearExplicit

HEADER PARAMETERS
- correlationId

Responses
-204 The request has been accepted, with no content returned.
-400 Bad Request - see error code and description for reason. Valid error code values are 4006 - Constraint violation
-401 The request has been rejected, due to unsuccessful authorisation.
-404 The requested resource could not be found.
-502 Bad Gateway

2.
Remove existing tipsandOtherpayments filed from Employment Financial End point.