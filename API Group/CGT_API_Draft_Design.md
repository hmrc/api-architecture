### 2 Oct 2020

// DELETE
../disposals/{taxableEntityId}/{taxYear}

// success codes
204
// error codes

// PUT 
../disposals/{taxableEntityId}/{taxYear}


#### OPTION 1 - Arrays of asset type objects

CF Type = Core Filing Data type

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
      "lossAfterRelief": 45.00          
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
      "lossAfterRelief": 45.00          
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
      "lossAfterRelief": 45.00          
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
      "lossAfterRelief": 45.00           // supply either gain or loss (customer supplies working out in attachments) // [CF Type: Monetary, non negative]
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
   // TBC 
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