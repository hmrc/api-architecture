# Capital Gains Tax API Design

## 1. Background

Customers can declare any capital gains they have had at any point in the tax year, however they must declare these gains before the end of the tax year (annual based processing), one exception to this is property based disposals, where HMRC require notification and payment of the capital gain within 30 days (PPD). 

PPD is managed by an existing service and mastered in ETMP. 



## 2. RAID Log

### 2.1 Risks

| ID   | Risk                                                         | Mitigation |
| ---- | ------------------------------------------------------------ | ---------- |
| 1    | Listed shares: Calculation evidence supplied by attachment service cannot be referenced to disposal submissions. (Manual process to match attachments by Nino to the disposals) |            |
|      |                                                              |            |
|      |                                                              |            |



### 2.2 Assumptions

| ID   | Assumption | Clarification |
| ---- | ---------- | ------------- |
|      |            |               |
|      |            |               |
|      |            |               |



### 2.3 Issues

| ID   | Issue                                                        | Date Raised | Assigned To | Resolution | Resolution Date |
| ---- | ------------------------------------------------------------ | ----------- | ----------- | ---------- | --------------- |
| 1    | Can lifetime allowance be increased/decreased with losses/gains? |             |             |            |                 |
| 2    | Carried interest: SME input needed to clarify attributes     | 23/09/2020  |             |            |                 |
|      |                                                              |             |             |            |                 |



### 2.3 Decisions

| Id   | Decision                                                     | Rationale                                                    |
| ---- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 1    | Listed shares: Disposal Date - Date when the customer disposed of shares from an existing the position/"pot" | i.e. if 3 sales were made on the same day aggregate all into 1 disposal |
| 2    | Listed shares: Acquisition Date - Date when the customer first acquired the position/"pot" of shares |                                                              |
|      |                                                              |                                                              |

## 3. API Designs

#### 3.1 Add Capital Gain

##### 3.1.1 URI

**PUT** */income/disposals/{taxableEntityId}/{taxYear}*

##### 3.1.2 Path Parameters

##### 3.1.3 Query Parameters

##### 3.1.4 Request Headers

##### 3.1.5 Request Schema

```json
{
  "$id": "https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/cgt_submission",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Capital Gains Tax Submissions",
  "description": "Json Schema representing a Capital Gains Tax Sumbission",
  "type": "object",
  "properties": {
    "assets": {
      "type": "array",
      "additionalItems": false,
      "minItems": 1,
      "items": {
        "$ref": "#/definitions/asset"
      }
    }
  },
  "definitions": {
    "asset": {
      "type": "object",
      "additionalProperties": false,
      "oneOf": [
        {
          "not": {
            "required": [
              "loss"
            ]
          },
          "required": [
            "dateOfDisposal",
            "assetType",
            "gain"
          ]
        },
        {
          "not": {
            "required": [
              "gain"
            ]
          },
          "required": [
            "dateOfDisposal",
            "assetType",
            "loss"
          ]
        }
      ],
      "dependencies": {
        "realTimeTransactionReturnAmountTaxPaid" : [ "realTimeTransactionReturnAmount"]
      },
      "properties": {
        "dateOfDisposal": {
          "type": "string",
          "format": "date",
          "description": "The date the disposal was made"
        },
        "assetType": {
          "type": "string",
          "enum": [
            "residential property",
              
              
            "listed shares",
            "unlisted shares",              
            "other property",
            
              "other assets",
            "carried interest"
          ],
          "description": "The type of asset that was disposed of"
        },
        "customerRef": {
          "type": "string",
          "minLength": 1,
          "maxLength": 100,
          "description": "Optional reference provided by the customer for the customer."
        },
        "disposalProceeds": {
          "type": "number",
          "minimum": 0.01,
          "maximum": 99999999.99,
          "multipleOf": 0.01,
          "description": "The amount the asset was sold / disposed of for."
        },
        "allowableCosts": {
          "type": "number",
          "minimum": 0.01,
          "maximum": 99999999.99,
          "multipleOf": 0.01,
          "description": "The original purchase price plus any allowable reliefs and expenses"
        },
        "gain": {
          "type": "number",
          "minimum": 0.00,
          "maximum": 99999999.99,
          "multipleOf": 0.01,
          "description": "The difference between the disposal proceeds and the allowable costs if positive"
        },
        "loss": {
          "type": "number",
          "maximum": -0.01,
          "minimum": -99999999.99,
          "multipleOf": 0.01,
          "description": "The difference between the disposal proceeds and the allowable costs if negative"
        },
        "claimOrElectionCode": {
          "type": "string",
          "enum": ["PRR", "LET","GHO","ROR","ESH","ERL","NVC","SIR","OTH","MUL","INV","PRO","BADR" ],   // BVRs around which apply to each asset type
          "description": "An enumeration of claim or election codes that the customer may make."
        },
        "realTimeTransactionReturnAmount": {
          "type": "number",
          "minimum": -99999999.99,
          "maximum": 99999999.99,
          "multipleOf": 0.01,
          "description": "The amount declared via the Real Time Transaction Return Process."
        },
        "realTimeTransactionReturnAmountTaxPaid": {
          "type": "number",
          "minimum": 0.00,
          "maximum": 99999999.99,
          "multipleOf": 0.01,
          "description": "The amount of tax paid on the Real Time Transaction Return Process."
        }
      }
    }
  },
  "examples": [
    {
      "assets": [
        {
          "dateOfDisposal": "2020-06-01",
          "assetType" : "shares",
          "gain": 100.00
        }
      ]
    },
    {
      "assets": [
        {
          "dateOfDisposal": "2020-06-01",
          "assetType" : "shares",
          "disposalProceeds": 100.00,
          "allowableCosts": 100.00,
          "gain": 100.00
        }
      ]
    },
    {
      "assets": [
        {
          "dateOfDisposal": "2020-06-01",
          "assetType" : "shares",
          "disposalProceeds": 100.00,
          "allowableCosts": 100.00,
          "claimOrElectionCode":"PRR",
          "gain": 100.00
        }
      ]
    },
    {
      "assets": [
        {
          "dateOfDisposal": "2020-06-01",
          "assetType" : "shares",
          "disposalProceeds": 100.00,
          "allowableCosts": 100.00,
          "claimOrElectionCode":"PRR",
          "gain": 100.00,
          "realTimeTransactionReturnAmount": 199.99
        }
      ]
    },
    {
      "assets": [
        {
          "dateOfDisposal": "2020-06-01",
          "assetType" : "shares",
          "disposalProceeds": 100.00,
          "allowableCosts": 100.00,
          "claimOrElectionCode":"PRR",
          "gain": 100.00,
          "realTimeTransactionReturnAmount": 199.99,
          "realTimeTransactionReturnAmountTaxPaid": 100.00
        }
      ]
    },
    {
      "assets": [
        {
          "dateOfDisposal": "2020-06-01",
          "assetType" : "shares",
          "loss": -100.00
        }
      ]
    },
    {
      "assets": [
        {
          "dateOfDisposal": "2020-06-01",
          "assetType" : "shares",
          "disposalProceeds": 100.00,
          "allowableCosts": 100.00,
          "loss": -100.00
        }
      ]
    },
    {
      "assets": [
        {
          "dateOfDisposal": "2020-06-01",
          "assetType" : "shares",
          "disposalProceeds": 100.00,
          "allowableCosts": 100.00,
          "claimOrElectionCode":"PRR",
          "loss": -100.00
        }
      ]
    },
    {
      "assets": [
        {
          "dateOfDisposal": "2020-06-01",
          "assetType" : "shares",
          "disposalProceeds": 100.00,
          "allowableCosts": 100.00,
          "claimOrElectionCode":"PRR",
          "loss": -100.00,
          "realTimeTransactionReturnAmount": 199.99
        }
      ]
    },
    {
      "assets": [
        {
          "dateOfDisposal": "2020-06-01",
          "assetType" : "shares",
          "disposalProceeds": 100.00,
          "allowableCosts": 100.00,
          "claimOrElectionCode":"PRR",
          "loss": -100.00,
          "realTimeTransactionReturnAmount": 199.99,
          "realTimeTransactionReturnAmountTaxPaid": 100.00
        }
      ]
    }
  ]
}
```



##### 3.1.6 Request Example

###### 3.1.6.1 Basic Gain Submission


### 7 Oct 2020

// DELETE
../disposals/{taxableEntityId}/{taxYear}

// success codes
204
// error codes

// PUT 
../disposals/{taxableEntityId}/{taxYear}


#### OPTION 1 - Arrays of asset type objects

CF Type = Core Filing Data type









### Non-Resident

Interests in UK residential Property,  other UK property, company with interest in UK property



---



- UKresidentialProperty 
- listedShares
- unlistedShares
- otherProperty
- otherAssets

- CarriedInterest





---



### UK Resident 

```json

// 
// interestsInUKresidentialProperty    // covered by ukResidentalProperty
//interestsInNonUKResidentialProperty // covered by OtherProperty 
//nonResidentialUKrealProperty
//indirectDisposals 


// owned by a UK resident (PPD)
// 18% & 28%
{  
"ukResidentalProperty": {                     // See otherAssets (below for rules)
    "disposals" : [
     {
      "assetDescription": "",
      "ppdReference": "",               // pre-pop available Y?
      "acquisitionDate":  "2017-10-10",
      "disposalDate": "2020-08-10",     
      "disposalProceeds": 100.00,       
      "allowableCosts": 100.00,         
      "gain": 50.00,                    // pre-pop available Y?
      "loss": 50.00,                    
      "claimOrElectionCodes": [ "BAD" ],
      "gainAfterRelief": 45.00,         
      "lossAfterRelief": 45.00          
      }
    ],
  "ppdReturn"   : {                     
    "gainsReported": 35.00,             
    "lossesReported": 35.00,            
    "taxCharged": 10.00                   
},
// Non-resident 
   ukresidential
     - ppd
   uknonresidential
     - ppd
   indirect   
     - ppd


// N.B. nonResident within the scope of non-resident CGT 
// UK residential 18% & 28%

{  
"nonResidentUkRresidentialProperty": {                     // See otherAssets (below for rules)
    "disposals" : [
     {
      "assetDescription": "",
      "ppdReference": "",  // ?   
      "acquisitionDate":  "2017-10-10",
      "disposalDate": "2020-08-10",     
      "disposalProceeds": 100.00,       
      "allowableCosts": 100.00,         
      "gain": 50.00,                    
      "loss": 50.00,                    
      "claimOrElectionCodes": [ "BAD" ],
      "gainAfterRelief": 45.00,         
      "lossAfterRelief": 45.00          
      }
    ],
  "ppdReturn"   : {                     
    "gainsReported": 35.00,             
    "lossesReported": 35.00,            
    "taxCharged": 10.00                    
   },
// 10% & 20%    
"nonResidentUkNonResidentialProperty": {                     // See otherAssets (below for rules)
    "disposals" : [
     {
      "assetDescription": "",
      "ppdReference": "",  // ?   
      "acquisitionDate":  "2017-10-10",
      "disposalDate": "2020-08-10",     
      "disposalProceeds": 100.00,       
      "allowableCosts": 100.00,         
      "gain": 50.00,                    
      "loss": 50.00,                    
      "claimOrElectionCodes": [ "BAD" ],
      "gainAfterRelief": 45.00,         
      "lossAfterRelief": 45.00          
      }
    ],
  "ppdReturn"   : {                     
    "gainsReported": 35.00,             
    "lossesReported": 35.00,            
    "taxCharged": 10.00                    
   },    
// 10% & 20%    
"nonResidentIndirect": {                     // See otherAssets (below for rules)
    "disposals" : [
     {
      "assetDescription": "",
      "ppdReference": "",  // ?   
      "acquisitionDate":  "2017-10-10",
      "disposalDate": "2020-08-10",     
      "disposalProceeds": 100.00,       
      "allowableCosts": 100.00,         
      "gain": 50.00,                    
      "loss": 50.00,                    
      "claimOrElectionCodes": [ "BAD" ],
      "gainAfterRelief": 45.00,         
      "lossAfterRelief": 45.00          
      }
    ],
  "ppdReturn"   : {                     
    "gainsReported": 35.00,             
    "lossesReported": 35.00,            
    "taxCharged": 10.00                    
   },    
}       


    
```





```json
{

    
  "listedShares": {                     // See otherAssets (below for rules)
    "disposals" : [
     {
      "assetDescription": "Company PLC",    
      "acquisitionDate":  "2017-10-10",
      "disposalDate": "2020-08-10",     
      "disposalProceeds": 100.00,       
      "allowableCosts": 100.00,         
      "gain": 50.00,                    
      "loss": 50.00,                    
      "claimOrElectionCodes": [ "BAD" ],
      "gainAfterRelief": 45.00,         
      "lossAfterRelief": 45.00,     
      //FTCR
      "foreignTaxPaid": 10.00,          
      "foreignTaxIncludedInGain": true,           
      "foreignTaxCreditRelief": 15.00         //amount the taxpayer wants to claim
      }
    ],
  "rttReturn"   : {                     
    "gainsReported": 35.00,             
    "lossesReported": 35.00,            
    "taxPaid": 10.00                    
  },
  "unlistedShares": {                    // See otherAssets (below for rules)
    "disposals" : [
     {
      "assetDescription": "Company Ltd",    
      "acquisitionDate":  "2017-10-10",
      "disposalDate": "2020-08-10",     
      "disposalProceeds": 100.00,       
      "allowableCosts": 100.00,         
      "gain": 50.00,                    
      "loss": 50.00,                    
      "claimOrElectionCodes": [ "BAD" ],
      "gainAfterRelief": 45.00,         
      "lossAfterRelief": 45.00,          
      //FTCR
      "foreignTaxPaid": 10.00,          
      "foreignTaxIncludedInGain": true,           
      "foreignTaxCreditRelief": 15.00         //amount the taxpayer wants to claim
      }
    ],
  "rttReturn"   : {                     
    "gainsReported": 35.00,             
    "lossesReported": 35.00,            
    "taxPaid": 10.00                    
  },
  "otherProperty": {                     // See otherAssets (below for rules)
    "disposals" : [
     {
      "assetDescription": "Farmland",    
      "acquisitionDate":  "2017-10-10",
      "disposalDate": "2020-08-10",     
      "disposalProceeds": 100.00,       
      "allowableCosts": 100.00,         
      "gain": 50.00,                    
      "loss": 50.00,                    
      "claimOrElectionCodes": [ "BAD" ],
      "gainAfterRelief": 45.00,         
      "lossAfterRelief": 45.00,
      //FTCR
      "foreignTaxPaid": 10.00,          
      "foreignTaxIncludedInGain": true,           
      "foreignTaxCreditRelief": 15.00         //amount the taxpayer wants to claim
      }
    ],
  "rttReturn"   : {                     
    "gainsReported": 35.00,             
    "lossesReported": 35.00,            
    "taxPaid": 10.00                    
  },
  "otherAssets": {
    "disposals" : [
     {
      "assetDescription": "Painting",    // customer freeform description. Mandatory. Possible ENUM + Other  [CF Type: Unrestricted medium string]
      "acquisitionDate":  "2017-10-10",  // 31 March 1982 or later date   [CF Type: Date	YYYY-MM-DD date]  (422 more CF Type: validation to be defined)
      "disposalDate": "2020-08-10",      // within submission tax year    [CF Type: Date	YYYY-MM-DD date]
      "disposalProceeds": 100.00,        // [CF Type: Monetary, non negative]
      "allowableCosts": 100.00,          // [CF Type: Monetary, non negative]
      "gain": 50.00,                     // (proceeds - costs) - supply either gain or loss  // [CF Type: Monetary, non negative]
      "loss": 50.00,                     // (proceeds - costs) - supply either gain or loss  // [CF Type: Monetary, non negative]
      "claimOrElectionCodes": [ "BAD" ], // ENUM ~10 values (claims/applications/reliefs/notices)  
      "gainAfterRelief": 45.00,          // supply either gain or loss (customer supplies working out in attachments) // [CF Type: Monetary, non negative]
      "lossAfterRelief": 45.00,           // supply either gain or loss (customer supplies working out in attachments) // [CF Type: Monetary, non negative]
      //FTCR
      "foreignTaxPaid": 10.00,          
      "foreignTaxIncludedInGain": true,           
      "foreignTaxCreditRelief": 15.00         //amount the taxpayer wants to claim
      }
    ],
  "rttReturn"   : {                      // rttReturn per asset object i.e. otherAssets 
    "gainsReported": 35.00,              // supply either gain or loss  [CF Type: Monetary, non negative]
    "lossesReported": 35.00,             // supply either gain or loss  [CF Type: Monetary, non negative]
    "taxPaid": 10.00                     // optional                    [CF Type: Monetary, non negative]
  },
  "carriedInterest": {
    "gain": 1000.00                      //total for the year. Applicable for hedge fund manangers etc. They will calculate the gain. 
  },
  "losses": {
    "broughtForwardLossesUsedInCurrentYear": 10.00,   // [CF Type: Type: Monetary, non negative]
    "setAgainstInYearGains": 10.00,                   // [CF Type: Monetary, non negative]
    "setAgainstInYearGeneralIncome": 10.00,           // [CF Type: Monetary, non negative]
    "setAgainstEarlierYear": 10.00                    // N.B. Carried Fwd amount to be derived  [CF Type: Monetary, non negative]
  },
  "adjustments": {
       
  }   
}
```


#### OPTION 2 - Arrays of asset type objects

```json
{    
   "disposals": [                                    // Optional  
      {
      "assetType": listedShares,                     // min 1 object
      "assetDescription": "Company PLC",    
      "acquisitionDate":  "2017-10-10",
      "disposalDate": "2020-08-10",     
      "disposalProceeds": 100.00,       
      "allowableCosts": 100.00,         
      "gain": 50.00,                    
      "loss": 50.00,                    
      "claimOrElectionCodes": [ "BAD" ],
      "gainAfterRelief": 45.00,         
      "lossAfterRelief": 45.00          
      },
      {
      "assetType": unlistedShares,
      "assetDescription": "Company Ltd",    
      "acquisitionDate":  "2017-10-10",
      "disposalDate": "2020-08-10",     
      "disposalProceeds": 100.00,       
      "allowableCosts": 100.00,         
      "gain": 50.00,                    
      "loss": 50.00,                    
      "claimOrElectionCodes": [ "BAD" ],
      "gainAfterRelief": 45.00,         
      "lossAfterRelief": 45.00        
      },
      {
      "assetType": otherProperty,    
      "assetDescription": "Farmland",    
      "acquisitionDate":  "2017-10-10",
      "disposalDate": "2020-08-10",     
      "disposalProceeds": 100.00,       
      "allowableCosts": 100.00,         
      "gain": 50.00,                    
      "loss": 50.00,                    
      "claimOrElectionCodes": [ "BAD" ],
      "gainAfterRelief": 45.00,         
      "lossAfterRelief": 45.00          
      },    
      {
      "assetType": otherAsset,
      "assetDescription": "Painting",    
      "acquisitionDate":  "2017-10-10",
      "disposalDate": "2020-08-10",     
      "disposalProceeds": 100.00,       
      "allowableCosts": 100.00,         
      "gain": 50.00,                    
      "loss": 50.00,                    
      "claimOrElectionCodes": [ "BAD" ],
      "gainAfterRelief": 45.00,         
      "lossAfterRelief": 45.00        
      }
    ],
    "rttReturns": [                                  // optional
      {
       "assetType": listedShares,                     // 1 rtt object per disposal/assetType object (if applicable)
       "gainsReported": 35.00,             
       "lossesReported": 35.00,            
       "taxPaid": 10.00
      },        
      {
       "assetType": unlistedShares,
       "gainsReported": 35.00,             
       "lossesReported": 35.00,            
       "taxPaid": 10.00
      },
      {
       "assetType": otherProperty,
       "gainsReported": 35.00,             
       "lossesReported": 35.00,            
       "taxPaid": 10.00
      },         
      {
       "assetType": otherAsset,                       
       "gainsReported": 35.00,             
       "lossesReported": 35.00,            
       "taxPaid": 10.00                    
      }
    ],
  "carriedInterest": {
    "gain": 1000.00                                   //total for the year. Applicable for hedge fund manangers etc. They will calculate the gain. 
  },
  "losses": {
    "broughtForwardLossesUsedInCurrentYear": 10.00,   // [CF Type: Type: Monetary, non negative]
    "setAgainstInYearGains": 10.00,                   // [CF Type: Monetary, non negative]
    "setAgainstInYearGeneralIncome": 10.00,           // [CF Type: Monetary, non negative]
    "setAgainstEarlierYear": 10.00                    // N.B. Carried Fwd amount to be derived  [CF Type: Monetary, non negative]
  },
  "adjustments": {
   // TBC 
  }
}  
```

// success codes
204
// error codes
400 (4006, 4007) 
401
422
502

// GET 
../disposals/{taxableEntityId}/{taxYear}


###### 3.1.6.2 Basic Gains Plus Optional Fields Submission

```json
{
  "assets": [
    {
      "assetType" : "shares",
      "disposalProceeds": 100.00,
      "allowableCosts": 100.00,
      "claimOrElectionCode":"PRR"
      "gain": 100.00,
    }
  ]
}
```

###### 3.1.6.3 Gains With RTT Submission

```Json
{
  "assets": [
    {
      "assetType" : "shares",
      "disposalProceeds": 100.00,
      "allowableCosts": 100.00,
      "claimOrElectionCode":"PRR",
      "gain": 100.00,
      "realTimeTransactionReturnAmount": 199.99 //compliance, not used in calc. True|False
    }
  ]
}
```

###### 3.1.6.4 Gains With RTT and Tax Paid Submission

```json
{
  "assets": [
    {
      "dateOfDisposal": "2020-06-01",
      "assetType" : "shares",
      "disposalProceeds": 100.00,
      "allowableCosts": 100.00,
      "claimOrElectionCode":"PRR",
      "gain": 100.00,
      "realTimeTransactionReturnAmount": 199.99,//compliance, not used in calc. True|False
      "realTimeTransactionReturnAmountTaxPaid": 100.00 
    }
  ]
}
```

###### 3.1.6.5 Basic Loss Submission

```json
{
  "assets": [
    {
      "dateOfDisposal": "2020-06-01",
      "assetType" : "shares",
      "loss": -100.00
    }
  ]
}
```

###### 3.1.6.6 Basic Loss Plus Optional Fields Submission

```json
{
  "assets": [
    {
      "dateOfDisposal": "2020-06-01",
      "assetType" : "shares",
      "disposalProceeds": 100.00,
      "allowableCosts": 100.00,
      "claimOrElectionCode":"PRR",
      "loss": -100.00
    }
  ]
}
```

###### 3.1.6.7 Loss With RTT Submission

```Json
{
  "assets": [
    {
      "dateOfDisposal": "2020-06-01",
      "assetType" : "shares",
      "disposalProceeds": 100.00,
      "allowableCosts": 100.00,
      "claimOrElectionCode":"PRR",
      "loss": -100.00,
      "realTimeTransactionReturnAmount": 199.99 //compliance, not used in calc. True|False
    }
  ]
}
```

###### 3.1.6.8 Loss With RTT and Tax Paid Submission

```json
{
  "assets": [
    {
      "dateOfDisposal": "2020-06-01",
      "assetType" : "shares",
      "disposalProceeds": 100.00,
      "allowableCosts": 100.00,
      "claimOrElectionCode":"PRR",
      "loss": -100.00,
      "realTimeTransactionReturnAmount": 199.99, //compliance - imply from below or True
      "realTimeTransactionReturnAmountTaxPaid": 100.00
    }
  ]
}
```

###### 3.1.6.x Working Example

```json
{
  "asset": [
    {
      "dateOfDisposal": "01/06/2020", //Mandatory
      "assetType": "shares", //Mandatory
      "customerRef": "tesco", //Optional
    	"typeOfAsset": "residential property | shares | other property | other asset | carried interest", //Mandatory
    	"disposalProceeds": 1000.00, //(Sale Cost) //Optional
    	"allowableCosts(IncludingPurchasePrice)": 100.00, //(Original purchase price plus any expenses / allowable deductions) Optional
      "gain": 900.00,//assume this is a mutually exclusive with loss? //Mandatory
    	"loss": 0.00, //assume this is a mutually exclusive with gains? 
    	"claimOrElectionCode": "PRR | LET | GHO | ROR | ESH | ERL | NVC | SIR | OTH | MUL | INV | PRO | BADR ", //BVR will assure against asset type. Optional
      "realTimeTransactionReturnAmount": 250.00, //The value relates to this specific asset rather than the sum total. (can be a loss) optional
      "realTimeTransactionReturnAmountTaxPaid": 250.00  //optional but cannot exist if realTimeTransactionReturnAmount is not present.
    }
  ],
  "unlistedSharesAndSecurities": [ 
    {
      "dateOfDisposal": "01/06/2020", //Mandatory
      "assetType": "shares", //Mandatory
      "customerRef": "tesco", //Optional
    	"typeOfAsset": "residential property | shares | other property | other asset | carried interest", //Mandatory
    	"disposalProceeds": 1000.00, //(Sale Cost) //Optional
    	"allowableCosts(IncludingPurchasePrice)": 100.00, //(Original purchase price plus any expenses / allowable deductions) Optional
      "gain": 900.00,//assume this is a mutually exclusive with loss? //Mandatory
    	"loss": 0.00, //assume this is a mutually exclusive with gains? 
    	"claimOrElectionCode": "PRR | LET | GHO | ROR | ESH | ERL | NVC | SIR | OTH | MUL | INV | PRO | BADR ", //BVR will assure against asset type. Optional
      "realTimeTransactionReturnAmount": 250.00, //The value relates to this specific asset rather than the sum total. (can be a loss) optional
      "realTimeTransactionReturnAmountTaxPaid": 250.00,  //optional but cannot exist if realTimeTransactionReturnAmount is not present.
      "gainExceedsTheLifetimeLimitForEmployerShareholderStatusShares": 100.00, //Optional this is the amount of gain over the lifetime threshold generated by this diposal not the total gain that exceeded the lifetime limit. 
      "gainInvestedUnderSeedEnterpriseInvestmentSchemeandQualifyingForRelief": 10.00 //Optional individual disposal gain 
    },
     {
      "dateOfDisposal": "02/06/2020", //Mandatory
      "assetType": "shares", //Mandatory
      "customerRef": "tesco", //Optional- could replace nameOfCompanySharesHaveBeenDisposedIn? Mandatory?
    	"typeOfAsset": "residential property | shares | other property | other asset | carried interest", //Mandatory
    	"disposalProceeds": 500.00, //(Sale Cost) //Optional
    	"allowableCosts(IncludingPurchasePrice)": 500.00, 
      "gain": 900.00,//assume this is a mutually exclusive with loss? //Mandatory
    	"loss": 0.00, //assume this is a mutually exclusive with gains? 
    	"claimOrElectionCode": "PRR | LET | GHO | ROR | ESH | ERL | NVC | SIR | OTH | MUL | INV | PRO | BADR ", //BVR will assure against asset type. Optional
      "realTimeTransactionReturnAmount": 250.00, 
      "realTimeTransactionReturnAmountTaxPaid": 250.00,  
      "gainExceedsTheLifetimeLimitForEmployerShareholderStatusShares": 100.00, // optional - required if over lifetime allowance (see helpsheet 287)
      "gainInvestedUnderSeedEnterpriseInvestmentSchemeandQualifyingForRelief": 10.00 //optional
      "lossesUsedAgainstIncome": 50.00 //optional
      "amountOfLossUsedAgainstIncomeInCurrentTaxYearToWhichEiSOrSeedEnterprise...IsAttributable": 50.00
      "lossesUsedAgainstIncomePreviousYear": 50.00 //optional

    }
  ],
  ""
}
```



##### 3.1.7 Response Status Code

##### 3.1.8 Response Schema

```json

```



##### 3.1.9 Response Examples

```json

```



##### 3.1.10 Response Headers

##### 3.1.11 ITSD Components Impacted

#### 3.2 Update Capital Gain

##### 3.2.1 URI

**PUT**

##### 3.2.2 Path Parameters

##### 3.2.3 Query Parameters

##### 3.2.4 Request Headers

##### 3.2.5 Request Schema

```json

```



##### 3.2.6 Request Example

```json

```



##### 3.2.7 Response Status Code

##### 3.2.8 Response Schema

##### 3.2.9 Response Examples

##### 3.2.10 Response Headers

##### 3.2.11 ITSD Components Impacted

#### 3.2 Delete Capital Gain

##### 3.2.1 URI

**DELETE**

##### 3.2.2 Path Parameters

##### 3.2.3 Query Parameters

##### 3.2.4 Request Headers

##### 3.2.5 Request Schema

```json

```



##### 3.2.6 Request Example

```json

```



##### 3.2.7 Response Status Code

##### 3.2.8 Response Schema

```json

```



##### 3.2.9 Response Examples

```json

```



##### 3.2.10 Response Headers

##### 3.2.11 ITSD Components Impacted

