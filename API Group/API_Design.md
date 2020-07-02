# Release 4 API Design

This document describes the general API principles that apply to MTD ITSA and the data groupings driven out of the SA schedules included within Release 4.

## Change Log:

| Version | Description                                                 | Date       |
|:--------|:------------------------------------------------------------|:-----------|
| 0.1     | Initial Draft                                               | 06/04/2020 |
| 0.2     | Updated following review comments                           | 06/04/2020 |
| 0.3     | Restructured Document and included all considered schedules | 08/04/2020 |
| 0.4     | Updated following review comments                           | 09/04/2020 |


\newpage


## Submission Types

### Periodic Submissions

| Operation | Usage                                                                                                                       |
|:----------|:----------------------------------------------------------------------------------------------------------------------------|
| POST      | Used to create a resource for a customer defined time period, responds with an ID that uniquely represents the new resource.|
| PUT       | Used to update a previously created resource identified by ID.                                                              |
| GET       | Used to either list previously created resources, or retrieve a specific resource by the its ID                             |


\newpage

#### POST Operation Standard Behaviour

##### Request Headers

| Header        | Description                                                                                            |
|:--------------|:-------------------------------------------------------------------------------------------------------|
| CorrelationId | Unique transaction reference, supplied by the external consumer, included in all request and responses.|

##### Path Parameters

| Parameter         | Description                                                             |
|:------------------|:------------------------------------------------------------------------|
| Taxable Entity Id | Unique identifier of the taxable entity to which the resource   belongs |
| Income Sourice Id | Unique identifier of the income source.                                 |

##### Query Parameters

N/A

##### Responses

| Status Code | Usage                                                                                                                       |
|:------------|:----------------------------------------------------------------------------------------------------------------------------|
| 201         | Success response, will return a location header for the created resource                                                    |
| 400         | Returned when the request body or parameters contain errors                                                                 |
| 401         | Returned when the request cannot be authorised.                                                                             |
| 409         | Returned when the a resource for the supplied period already exists                                                         |
| 422         | Returned when the operation fails due to validation / business rule failures                                                |
| 502         | Returned when the service has an internal failure                                                                           |

\newpage

#### PUT Operation Standard Behaviour

##### Headers

| Header        | Description                                                                                            |
|:--------------|:-------------------------------------------------------------------------------------------------------|
| CorrelationId | Unique transaction reference, supplied by the external consumer, included in all request and responses |

##### Path Parameters

| Parameter         | Description                                                             |
|:------------------|:------------------------------------------------------------------------|
| Taxable Entity Id | Unique identifier of the taxable entity to which the resource   belongs |
| Income Sourice Id | Unique identifier of the income source                                  |
| Id                | The unique identifier of the resource                                   |

##### Query Parameters

N/A

##### Response Status Codes

| Status Code | Usage                                                                                                                       |
|:------------|:----------------------------------------------------------------------------------------------------------------------------|
| 204         | Success response                                                                                                            |
| 400         | Returned when the request body or parameters contain errors                                                                 |
| 401         | Returned when the request cannot be authorised.                                                                             |
| 404         | Returned when the submission is not found                                                                                   |
| 422         | Returned when the operation fails due to validation / business rule failures                                                |
| 502         | Returned when the service has an internal failure                                                                           |

\newpage

#### GET Operation Standard Behaviour

#### Headers

| Header        | Description                                                                                            |
|:--------------|:-------------------------------------------------------------------------------------------------------|
| CorrelationId | Unique transaction reference, supplied by the external consumer, included in all request and responses |


##### Path Parameters

| Parameter         | Description                                                             |
|:------------------|:------------------------------------------------------------------------|
| Taxable Entity Id | Unique identifier of the taxable entity to which the resource   belongs |
| Income Sourice Id | Unique identifier of the income source                                  |
| Id                | The unique identifier of the resource, this parameter is optional       |

##### Query Parameters

| Parameter         | Description                                                                                                                |
|:------------------|:---------------------------------------------------------------------------------------------------------------------------|
| Internal          |Flag (defaulted to false) which allows internal consumers to request a view that includes historic versions of the resource |

##### Response Status Codes

| Status Code | Usage                                                                                                                       |
|:------------|:----------------------------------------------------------------------------------------------------------------------------|
| 200         | Success response                                                                                                            |
| 400         | Returned when the request body or parameters contain errors                                                                 |
| 401         | Returned when the request cannot be authorised.                                                                             |
| 404         | Returned when the submission is not found                                                                                   |
| 502         | Returned when the service has an internal failure                                                                           |

\newpage

### Annual Submissions

| Operation | Usage                                            |
|:----------|:-------------------------------------------------|
| PUT       | Create or replace the resource by tax year       |
| GET       | Used to retrieve a specific resource by tax year |
| DELETE    | Used to delete a resource by tax year            |

\newpage

#### PUT Operation Standard Behaviour

##### Headers

| Header        | Description                                                                                            |
|:--------------|:-------------------------------------------------------------------------------------------------------|
| CorrelationId | Unique transaction reference, supplied by the external consumer, included in all request and responses |

##### Path Parameters

| Parameter         | Description                                                             |
|:------------------|:------------------------------------------------------------------------|
| Taxable Entity Id | Unique identifier of the taxable entity to which the resource   belongs |
| Tax Year          | The tax year to which the resource relates                              |

##### Query Parameters

N/A

##### Response Status Codes

| Status Code | Usage                                                                                                                       |
|:------------|:----------------------------------------------------------------------------------------------------------------------------|
| 204         | Success response                                                                                                            |
| 400         | Returned when the request body or parameters contain errors                                                                 |
| 401         | Returned when the request cannot be authorised.                                                                             |
| 422         | Returned when the operation fails due to validation / business rule failures                                                |
| 502         | Returned when the service has an internal failure                                                                           |

\newpage

#### GET Operation Standard Behaviour

#### Headers

| Header        | Description                                                                                            |
|:--------------|:-------------------------------------------------------------------------------------------------------|
| CorrelationId | Unique transaction reference, supplied by the external consumer, included in all request and responses |

##### Path Parameters

| Parameter         | Description                                                             |
|:------------------|:------------------------------------------------------------------------|
| Taxable Entity Id | Unique identifier of the taxable entity to which the resource   belongs |
| Tax Year          | The tax year to which the resource relates                              |

##### Query Parameters

| Parameter         | Description                                                                                                                |
|:------------------|:---------------------------------------------------------------------------------------------------------------------------|
| Internal          |Flag (defaulted to false) which allows internal consumers to requesprott a view that includes historic versions of the resource |

##### Response Status Codes

| Status Code | Usage                                                                                                                       |
|:------------|:----------------------------------------------------------------------------------------------------------------------------|
| 200         | Success response                                                                                                            |
| 400         | Returned when the request body or parameters contain errors                                                                 |
| 401         | Returned when the request cannot be authorised.                                                                             |
| 404         | Returned when the resource cannot be found                                                                                  |
| 502         | Returned when the service has an internal failure                                                                           |

\newpage

#### DELETE Operation Standard Behaviour

##### Headers

| Header        | Description                                                                                            |
|:--------------|:-------------------------------------------------------------------------------------------------------|
| CorrelationId | Unique transaction reference, supplied by the external consumer, included in all request and responses |

##### Path Parameters

| Parameter         | Description                                                             |
|:------------------|:------------------------------------------------------------------------|
| Taxable Entity Id | Unique identifier of the taxable entity to which the resource   belongs |
| Tax Year          | The tax year to which the resource relates                              |

##### Query Parameters

N/A

##### Response Status Codes

| Status Code | Usage                                                                                                                       |
|:------------|:----------------------------------------------------------------------------------------------------------------------------|
| 204         | Success response                                                                                                            |
| 400         | Returned when the request body or parameters contain errors                                                                 |
| 401         | Returned when the request cannot be authorised.                                                                             |
| 404         | Returned when the resource cannot be found                                                                                  |
| 502         | Returned when the service has an internal failure                                                                           |

\newpage

## Periodic Data

### Income

#### Property

##### URIs

| URI                                                               | Operations Supported     |
|:------------------------------------------------------------------|:-------------------------|
|/income/property/{taxableEntityId}/{incomeSourceId}                | POST, GET                |
|/income/property/{taxableEntityId}/{incomeSourceId}/{submissionId} | PUT, GET                 |

##### Product Types

| Product Type    | Source |
|:----------------|:-------|
| UK FHL          | SA105  |
| UK NON-FHL      | SA105  |
| Foreign FHL-EEA | SA106  |
| Foreign Property| SA106  |

###### Example Request/Response Body (POST)

```json
{
  "startDate": "06-04-2019",
  "endDate"  : "06-07-2019", 
  "type" : "FOREIGN FHL EEA",
  "countries": [
  {
    "countryCode": "GER", 
    "income": {
        "rentAmount" : 200.22,
        "taxDeducted": 22.22
    },
    "expenses": {
      "premisesRunningCostsAmount": 100.25,
      "repairsAndMaintenanceAmount": 100.25 ,
      "financialCostsAmount": 100.25 ,
      "professionalFeesAmount": 100.25 ,
      "costOfServicesAmount": 100.25 ,
      "travelCostsAmount": 100.25 ,
      "otherAmount": 100.25 ,
      "consolidatedExpenseAmount": 100.25 //optional replaces all other expenses 
    }
  }
  ]
}
```

```json
{
  "startDate": "06-04-2019",
  "endDate"  : "06-07-2019", 
  "type" : "FOREIGN PROPERTY",
  "countries" : [
    {
      "countryCode": "GER", 
      "income": {
        "rentIncome": {
          "rentAmount": 100.25,
          "taxDeducted": 100.25,
          "foreignTaxCreditRelief": 122.22
        },
        "premiumsOfLeaseGrantAmount": 100.25,
        "otherPropertyIncomeAmount": 100.25 ,
      },
      "expenses": {
       "premisesRunningCostsAmount": 100.25,
       "repairsAndMaintenanceAmount": 100.25 ,
        "financialCostsAmount": 200.25,
        "professionalFeesAmount": 100.25,
        "travelCostsAmount": 100.25,
        "costOfServicesAmount": 100.25,
        "residentialFinancialCostAmount": 200.25,
        "broughtFwdResidentialFinancialCostAmount": 100.25,
        "otherAmount": 100.25,
        "consolidatedExpenseAmount": 100.25 //optional replaces all other expenses 
     }
    }
  ]
}
```

\newpage

###### Example Request/Response Body (PUT)

```json
[
  {
    "countryCode": "BRA", 
    "income": {
        "rentAmount" : 200.22,
        "taxDeducted": 22.22
    },
    "expenses": {
      "premisesRunningCostsAmount": 100.25,
      "repairsAndMaintenanceAmount": 100.25 ,
      "financialCostsAmount": 100.25 ,
      "professionalFeesAmount": 100.25 ,
      "costOfServicesAmount": 100.25 ,
      "travelCostsAmount": 100.25 ,
      "otherAmount": 100.25 ,
      "consolidatedExpenseAmount": 100.25 //optional replaces all other expenses 
    }
  }
]
```

```json
[
    {
      "countryCode": "FRA", 
      "income": {
        "rentIncome": {
          "rentAmount": 100.25,
          "taxDeducted": 100.25,
          "foreignTaxCreditRelief": 122.22
        },
        "premiumsOfLeaseGrantAmount": 100.25,
        "otherPropertyIncomeAmount": 100.25 ,
      },
      "expenses": {
       "premisesRunningCostsAmount": 100.25,
       "repairsAndMaintenanceAmount": 100.25 ,
        "financialCostsAmount": 200.25,
        "professionalFeesAmount": 100.25,
        "travelCostsAmount": 100.25,
        "costOfServicesAmount": 100.25,
        "residentialFinancialCostAmount": 200.25,
        "broughtFwdResidentialFinancialCostAmount": 100.25,
        "otherAmount": 100.25,
        "consolidatedExpenseAmount": 100.25 //optional replaces all other expenses 
     }
    }
  ]
```

\newpage

###### Example Request/Response Body (GET without ID)

```json
[
  {
    "id":"12",
    "type": "FOREIGN PROPERTY",
    "startDate": "2019-06-04",
    "endDate": "2019-05-07"
  },
  {
    "id":"13",
    "type": "FOREIGN FHL EEA",
    "startDate": "2019-06-07",
    "endDate": "2019-05-10"
  }    
]
```

\newpage


###### Example Request/Response Body (GET With ID)

```json
{
  "startDate": "06-04-2019",
  "endDate"  : "06-07-2019", 
  "type" : "FOREIGN FHL EEA",
  "countries": [
    {
      "countryCode": "GER", 
      "income": {
          "rentAmount" : 200.22,
          "taxDeducted": 22.22
      },
      "expenses": {
        "premisesRunningCostsAmount": 100.25,
        "repairsAndMaintenanceAmount": 100.25 ,
        "financialCostsAmount": 100.25 ,
        "professionalFeesAmount": 100.25 ,
        "costOfServicesAmount": 100.25 ,
        "travelCostsAmount": 100.25 ,
        "otherAmount": 100.25 ,
        "consolidatedExpenseAmount": 100.25 //optional replaces all other expenses 
      }
    }
  ]
}
```

```json
{
  "startDate": "06-04-2019",
  "endDate"  : "06-07-2019", 
  "type" : "FOREIGN PROPERTY",
  "countries" : [
    {
      "countryCode": "GER", 
      "income": {
        "rentIncome": {
          "rentAmount": 100.25,
          "taxDeducted": 100.25,
          "foreignTaxCreditRelief": 122.22
        },
        "premiumsOfLeaseGrantAmount": 100.25,
        "otherPropertyIncomeAmount": 100.25 ,
      },
      "expenses": {
       "premisesRunningCostsAmount": 100.25,
       "repairsAndMaintenanceAmount": 100.25 ,
        "financialCostsAmount": 200.25,
        "professionalFeesAmount": 100.25,
        "travelCostsAmount": 100.25,
        "costOfServicesAmount": 100.25,
        "residentialFinancialCostAmount": 200.25,
        "broughtFwdResidentialFinancialCostAmount": 100.25,
        "otherAmount": 100.25,
        "consolidatedExpenseAmount": 100.25 //optional replaces all other expenses 
     }
    }
  ]
}
```

\newpage

###### Example Response Body (GET with ID (including history))

```json
{
  "startDate": "2019-06-04",
  "endDate": "2019-05-07",
  "type" : "FOREIGN FHL EEA",
  "submissions": [
    { 
      "countries": [
        {
          "countryCode": "GER", 
          "income": {
           "rentAmount" : 200.22,
           "taxDeducted": 22.22
          },
          "expenses": {
            "premisesRunningCostsAmount": 100.25,
            "repairsAndMaintenanceAmount": 100.25 ,
            "financialCostsAmount": 100.25 ,
            "professionalFeesAmount": 100.25 ,
            "costOfServicesAmount": 100.25 ,
            "travelCostsAmount": 100.25 ,
            "otherAmount": 100.25 ,
            "consolidatedExpenseAmount": 100.25 //optional replaces all other expenses 
          }
        }
      ],    
      "submissionDate": "2019-05-07T11:00:00.000"
    },
    { 
      "countries": [
        {
          "countryCode": "FRA", 
          "income": {
           "rentAmount" : 200.22,
           "taxDeducted": 22.22
          },
          "expenses": {
            "premisesRunningCostsAmount": 100.25,
            "repairsAndMaintenanceAmount": 100.25 ,
            "financialCostsAmount": 100.25 ,
            "professionalFeesAmount": 100.25 ,
            "costOfServicesAmount": 100.25 ,
            "travelCostsAmount": 100.25 ,
            "otherAmount": 100.25 ,
            "consolidatedExpenseAmount": 100.25 //optional replaces all other expenses 
          }
        }
      ],    
      "submissionDate": "2019-04-07T11:00:00.000"
    }                        
  ]
}               
```



\newpage

### Expenses

### Deductions

### Allowances

\newpage

## Annual Data

### Income

#### Insurance Policies

##### URI

/income/insurance-policies/{taxableEntityId}/{taxYear}

##### Product Types

 | Product Type                | Source | Boxes               |
 |:----------------------------|:-------|:--------------------|
 | Life Insurance Policies     | SA101  | AOI boxes 4-7, 11   |
 | Life Annuity Contracts      | SA101  | AOI boxes 4-7, 11   |
 | Capital Redemption Policies | SA101  | AOI boxes 4-7, 11   |
 | Voided ISAs                 | SA101  | AOI boxes 8 - 11    |
 | Foreign Policies            | SA106  | boxes 43 - 45       |


##### Example Request / Response Body

```json
[
  {
    "type": "LIFE INSURANCE",
    "event": "Death of spouse",
    "customerReference":"wibble",
    "gainAmount": 15422.00,
    "taxPaid": 1542.00,
    "yearsHeld": 14,
    "yearsHeldSinceLastGain": 3,
    "deficiencyRelief": null
  },
  {
    "type": "CAPITAL REDEMPTION",
    "event": "Chips Cashed In",
    "customerReference":"wobble",
    "gainAmount": 15422.00,
    "yearsHeld": 14,
    "yearsHeldSinceLastGain": 3
  },
  {
    "type": "LIFE ANNUITY",      
    "event": null,
    "customerReference":"wobble",      
    "gainAmount": 532.00,
    "taxPaid": null,
    "yearsHeld": 14,
    "yearsHeldSinceLastGain": 3,
    "deficiencyRelief": null
  },
  {
    "type": "VOIDED ISAS",
    "customerReference":"wobble",  
    "event": null,
    "gainAmount": 532.00,
    "taxPaid": null,
    "yearsHeld": 14,
    "yearsHeldSinceLastGain": 3,
    "deficiencyRelief": null
  },
  {
    "type": "FOREIGN POLICIES",
    "customerReference":"wobble",  
    "gainAmount": 532.00,
    "taxPaid": null,
    "yearsHeld": 14
  }
]
```

\newpage

#### Savings

##### URI

/income/savings/{taxableEntityId}/{taxYear}

##### Product Types

 | Product Type                | Source | Boxes                   |
 |:----------------------------|:-------|:------------------------|
 | BBSI                        | SA100  |                         |
 | Securities                  | SA101  | AOI boxes 1-3           |
 | Foreign Interest            | SA106  | A- F Interest / savings |


##### Example Request / Response Body

```json
[
 {
    "type": "SECURITIES",
    "taxTakenOff": 100.0,
    "grossAmount": 1455.0
  },
  {
    "type": "FOREIGN INTEREST",
    "countryCode": "GER",
    "amountBeforeTax": 1232.22,
    "taxTakenOff": 22.22,
    "specialWitholdingTax": 22.22,
    "fctr": true,
    "taxableAmount": 2321.22
  }
]
```

\newpage

#### Other Employment Income

##### URI

/income/employment/other/{taxableEntityId}/{taxYear}

##### Product Types

 | Product Type                    | Source | Boxes      |  
 |:--------------------------------|:-------|:-----------|
 | Share Options                   | SA101  | ASE Box 1  |
 | Shares Awarded or Received      | SA101  | ASE Box 1  |
 | Disability                      | SA101  | ASE Box 10 |
 | Foreign Service                 | SA101  | ASE box 10 |



##### Example Request / Response Body

```json
[
  {
    "type": "SHARE OPTIONS",
    "employerName": "wibble",
    "payeRef" : "AB1321/123",
    "schemePlanType": "Wibble",
    "dateOfOptionGrant": "20-11-2019",
    "dateOfEvent": "20-11-2019",
    "optionNotExercisedButConsiderationReceived": "??",
    "amountOfConsiderationReceived": 23122.22,
    "noOfSharesAcquired": 1,
    "classOfSharesAcquired": "FIRST",
    "exercisePrice": 12.22,
    "amountPaidForOption": 123.22,
    "marketValueOfSharesOnExcise": 1232.22,
    "profitOnOptionExercised": 1232.33,
    "employersNicPaid": 2312.22,
    "taxableAmount" : 2132.22
  },
  {
    "type": "SHARES AWARDED OR RECEIVED",
    "employerName": "Wibble",
    "payeRef" : "AB1321/123",
    "schemePlanType": "Wibble",
    "dateSharesCeasedToBeSubjectToPlan": "10-11-2019",
    "noOfShareSecuritiesAwarded": 11,
    "classOfShareAwarded": "FIRST",
    "dateSharesAwarded" : "20-11-2019",
    "sharesSubjectToRestrictions": true,
    "electionEnteredIgnoreRestrictions": true,
    "actualMarketValueOfSharesOnAward": 2123.22,
    "unrestrictedMarketValueOfSharesOnAward": 123.22,
    "amountPaidForSharesOnAward": 123.22,
    "marketValueAfterRestrictionsLifted": 1232.22,
    "taxableAmount": 12321.22    
  },
  {
    "type": "DISABILITY",
    "customerReference": "wibble",
    "amountDeducted": 1223.22
  },  
  {
    "type": "FOREIGN SERVICE",
    "customerReference": "wibble",
    "amountDeducted": 1223.22
  }  

]
```

\newpage

#### Foreign Income

##### URI

/income/foreign/{taxableEntityId}/{taxYear}

##### Product Types

 | Product Type                    | Source | Boxes      |
 |:--------------------------------|:-------|:-----------|
 | Foreign Earnings                | SA101  | ASE Box 12 |
 | Unremittable Foreign Income     | SA106  | box 1      |

##### Example Request / Response Body

```json
[
  {
    "type": "FOREIGN EARNINGS",
    "customerReference" : "wibble",
    "earningsNotTaxableUK": 15455.00,

  },
  {
    "type": "UNREMITTABLE FOREIGN INCOME",
    "countryCode": "GER",
    "amountInForeignCurrency":213.22,
    "amountTaxPaid": 232.22
  }
]
```
\newpage

#### Dividends

##### URI

/income/dividends/{taxableEntityId}/{taxYear}

##### Product Types

 | Product Type                             | Source | Boxes           |
 |:-----------------------------------------|:-------|:----------------|
 | UK Dividends                             | SA100  |                 |
 | Foreign Dividends                        | SA106  | A - F Dividends |
 | Dividend Income Received Whilst Abroad   | SA106  | A - F Dividends |
 | Stock Dividends                          | SA101  | AOI Box 12      |
 | Bonus Issue of Securities                | SA101  | AOI Box 13      |
 | Redeemable Shares                        | SA101  | AOI Box 13      |
 | Close Company Loans Written Off          | SA101  | AOI Boxy 13.1   |

##### Example Request / Response Body

```json

[
  {   
    "type": "UK DIVIDEND",
    "customerReference": "wibble",
    "amount": 1232.23
  },
  {
    "type": "FOREIGN DIVIDEND",
    "countryCode": "GER",
    "amountBeforeTax": 1232.22,
    "taxTakenOff": 22.22,
    "specialWitholdingTax": 22.22,
    "foreignTaxCreditRelief": true,
    "taxableAmount": 2321.22        
  },
  {
    "type": "DIVIDEND INCOME RECEIVED WHILST ABROAD",
    "countryCode": "GER",
    "amountBeforeTax": 1232.22,
    "taxTakenOff": 22.22,
    "specialWitholdingTax": 22.22,
    "foreignTaxCreditRelief": true,
    "taxableAmount": 2321.22        
  },  
  {
    "type": "STOCK DIVIDEND",
    "grossAmount": 12321.22,
    "customerReference": "wibble01"
  },
  {
    "type": "REDEEMABLE SHARES",
    "grossAmount": 12321.22,
    "customerReference": "wibble02"
  },
  {
    "type": "BONUS ISSUES OF SECURITIES",
    "grossAmount": 12321.22,
    "customerReference": "wibble03"
  },
  {
    "type": "CLOSE COMPANY LOANS WRITTEN OFF",
    "grossAmount": 12321.22,
    "customerReference": "wibble04"
  }
]
```

\newpage

#### Pensions

##### URI

/income/pensions/{taxableEntityId}/{taxYear}

##### Product Types

 | Product Type                    | Source | Boxes          |
 |:--------------------------------|:-------|:---------------|
 | Foreign Pensions                | SA106  | A - F Pensions |
 | Overseas Pension Contributions  | SA101  | ASE box 14     |

##### Example Request / Response Body

```json
[
  {
    "type": "FOREIGN PENSIONS",
    "countryCode": "GER",
    "amountBeforeTax": 1232.22,
    "taxTakenOff": 22.22,
    "specialWitholdingTax": 22.22,
    "foreignTaxCreditRelief": true,
    "taxableAmount": 2321.22        
  },
  {
    "type": "OVERSEAS PENSION CONTRIBUTIONS",
    "customerReference" : "wibble",
    "exemptEmployersPensionContribs": 689.00,
    "migrantMemReliefQopsRefNo": "ER3223423",
    "dblTaxationRelief": 4232.00,
    "dblTaxationCountry": "GER",
    "dblTaxationArticle": "3211-1",
    "dblTaxationTreaty": "Munich"
  },
]
```

\newpage

#### Other

/income/other/{taxableEntityId}/{taxYear}

##### Product Types

 | Product Type                            | Source | Boxes              |
 |:----------------------------------------|:-------|:-------------------|
 | Business Receipts                       | SA101  | AOI Box 14 - 15    |
 | All Other Income Received Whilst Abroad | SA106  | A - F Other Income |
 | Overseas Income and Gains               | SA106  | Box 41             |
 | Chargeable Foreign Benefits and Gifts   | SA106  | Box 42             |

##### Example Request / Response Body
```json
[
  {
    "type": "BUSINESS RECEIPTS",
    "grossAmount": 12321.22,
    "taxYear": "2017-18"
  },
  {
    "type": "ALL OTHER INCOME RECEIVED WHILST ABROAD",
    "countryCode": "GER",
    "amountBeforeTax": 1232.22,
    "taxTakenOff": 22.22,
    "specialWitholdingTax": 22.22,
    "foreignTaxCreditRelief": true,
    "taxableAmount": 2321.22,
    "residentialFinancialCostAmount": 200.25,
    "broughtFwdResidentialFinancialCostAmount": 100.25
  },
  {
    "type": "OVERSEAS INCOME AND GAINS",
    "gainAmount" : 1232.22
  },
  {
    "type": "CHARGEABLE FOREIGN BENEFITS AND GIFTS",
    "transactionBenefit": 100.22,
    "protectedForeignIncomeSourceBenefit": 111.22,
    "protectedForeignIncomeOnwardGift": 111.23,
    "benefitReceivedAsASettler": 111.22,
    "onwardGiftReceivedAsASettler": 111.22
  }

]
```

\newpage

### Property

/income/property/{taxableEntityId}/{taxYear}

##### Product Types

 | Product Type                    | Source | Boxes           |
 |:--------------------------------|:-------|:----------------|
 | UK FHL                          |        |                 |
 | UK NON FHL                      |        |                 |
 | FOREIGN FHL EEA                 |        |                 |
 | FOREIGN PROPERTY                |        |                 |

##### Example Request / Response Body
```json
{
  "type": "FOREIGN FHL EEA",
  "adjustments": {
    "privateUseAdjustment": 100.25,
    "balancingCharge": 100.25,
    "periodOfGraceAdjustment": true
  },
  "allowances": {
    "annualInvestmentAllowance": 100.25,
    "otherCapitalAllowance": 100.25,
    "propertyAllowance": 100.25,
    "electricChargePointAllowance": 100.25
  },
  "other": {
    "nonResidentLandlord": false
  }  

}
```
```json
{
  "type": "FOREIGN PROPERTY",
  "adjustments": {
    "privateUseAdjustment": 100.25,
    "balancingCharge": 100.25
  },
  "allowances": {
    "annualInvestmentAllowance": 100.25,
    "costOfReplacingDomesticItems": 100.25,
    "zeroEmissionsGoodsVehicleAllowance": 100.25,
    "propertyAllowance": 100.25,
    "otherCapitalAllowance": 100.25,
    "structureAndBuildingAllowance": 100.25
  },
  "other": {
    "nonResidentLandlord": false
  }  
  
}
```

### Expenses

#### Other Expenses

##### URI

/expenses/other/{taxableEntityId}/{taxYear}

##### Product Types

 | Product Type                                | Source | Boxes      |
 |:--------------------------------------------|:-------|:-----------|
 | Payments to Trade Unions for Death Benefits | SA101  | AOR Box 8  |
 | Patent Royalties                            | SA101  | ASE Box 15 |


##### Example Request / Response Body

```json
[
  {
    "type": "PAYMENTS TO TRADE UNIONS FOR DEATH BENEFITS",
    "customerReference": "wibble",
    "expenseAmount": 1223.22
  },
   {
    "type": "PATENT ROYALTIES PAYMENTS",
    "customerReference": "wibble",
    "expenseAmount": 1223.22
  }
]
```

\newpage

### Deductions

#### Other Deductions

##### URI

/deductions/other/{taxableEntityId}/{taxYear}

##### Product Types

 | Product Type                    | Source | Boxes |
 |:--------------------------------|:-------|:-----------|
 | SeaFarers                       | SA101  | ASE box 11|

##### Example Request / Response Body

```json
[
  {
    "type": "SEAFARERS",
    "customerReference": "wobble",
    "amountDeducted": 2342.22,
    "nameOfShip": "Boaty McBoatface",
    "dateFrom": "2018-08-17",
    "dateTo":"2018-10-02"
  }
]
```

\newpage

### Allowances

\newpage

### Reliefs

#### Investment Reliefs

##### URI

/reliefs/investment/{taxableEntityId}/{taxYear}

##### Product Types

 | Product Type                 | Source | Boxes        |
 |:-----------------------------|:-------|:-------------|
 | VCT Subscriptions            | SA101  | AOR Box 1    |
 | EIS Subscriptions            | SA101  | AOR Box 2    |
 | Community Investment         | SA101  | AOR Box 3    |
 | Seed Enterprise Investment   | SA101  | AOR Box 10   |
 | Social Enterprise Investment | SA101  | AOR Box 11   |

##### Example Request / Response Body

```json
[
  {
    "type": "VCT SUBCRIPTIONS",
    "customerReference": "Wibble",
    "name": "VCT Fund X",
    "knowledgeIntensive": null,
    "uniqueInvestmentRef": null,
    "dateOfInvestment": "2018-04-16",
    "amountInvested": 23312.00,
    "reliefClaimed": 1334.00
  },
  {
    "type": "EIS SUBCRIPTIONS",
    "customerReference": "Wibble",
    "name": "EIS Fund X",
    "knowledgeIntensive": true,
    "uniqueInvestmentRef": "XTAL",
    "dateOfInvestment": "2020-12-12",
    "amountInvested": 23312.00,
    "reliefClaimed": 43432.00
  },
  {
    "type": "COMMUNITY INVESTMENT",
    "customerReference": "Wibble",
    "name": "CI X",
    "knowledgeIntensive": null,
    "uniqueInvestmentRef": null,
    "dateOfInvestment": "2020-12-12",
    "amountInvested": 6442.00,
    "reliefClaimed": 2344.00
  },    
  {
    "TYPE": "SEED ENTERPRISE INVESTMENT",
    "customerReference": "Wibble",
    "companyName": "Wibble Inc",
    "uniqueInvestmentRef": "123412/1A",
    "dateOfInvestment": "2020-12-12",
    "amountInvested": 123123.22
  },
  {
    "type": "SOCIAL ENTERPRISE INVESTMENT",
    "socialEnterpriseName": "Wibble Inc",
    "customerReference": "Wibble",    
    "uniqueInvestmentRef": "123412/1A",
    "dateOfInvestment": "2020-12-12",
    "amountInvested": 123123.22
  }  
]
```

\newpage

#### Other Reliefs

##### URI

/reliefs/other/{taxableEntityId}/{taxYear}

##### Product Types

 | Product Type                                                | Source | Boxes                   |
 |:------------------------------------------------------------|:-------|:------------------------|
 | Non Deductable Loan Interest                                | SA101  | AOR Box 12              |
 | Payroll Giving                                              | SA101  | Other Information box 6 |
 | Qualifying Distribution Redemption Of Shares and Securities | SA101  | AOR box 9               |
 | Post Cessation Trade Relief and Certain Other Losses        | SA101  | AOR box 6               |
 | Maintenance Payments                                        | SA101  | AOR box 7               |
 | Annual Payments Made                                        | SA101  |                         |
 | Qualifying Loan Interest Payments                           | SA101  |                         |


##### Example Request / Response Body

```json
[
  {
    "type": "NON DEDUCTABLE LOAN INTEREST",
    "customerReference": "Wibble",
    "reliefClaimed": 763.00
  },
  {
    "type": "PAYROLL GIVING",
    "customerReference": "Wibble",
    "reliefClaimed": 154.00
  },
  {
    "type":"QUALIFYING DISTRIBUTION REDEMPTION OF SHARES AND SECURITIES",
    "customerReference": "Wibble",
    "amount": 222.22
  },
  {
    "type":"MAINTENANCE PAYMENTS",
    "customerReference": "Wibble",
    "exSpouseName" : "Hilda",
    "exSpouseDateOfBirth": "2000-01-01",
    "amount": 222.22
  },  
  {
    "type":"POST CESSATION TRADE RELIEF AND CERTAIN OTHER LOSSES",
    "customerReference": "Wibble",
    "businessName": "Wibble Inc",
    "dateBusinessCeased": "2019-08-10",
    "natureOfTrade": "Wibble Manufacturer",
    "incomeSource": "AB12412/A12",
    "amount": 222.22
  },
  {
    "type": "ANNUAL PAYMENTS MADE",
    "customerReference": "Wibble",
    "reliefClaimed": 763.00
  },
  {
    "type": "QUALIFYING LOAN INTEREST PAYMENTS",
    "customerReference": "Wibble",
    "lenderName": "Maurice",
    "reliefClaimed": 763.00
  }

]
```

\newpage


#### Foreign

##### URI

/reliefs/foreign/{taxableEntityId}/{taxYear}

##### Product Typed


 | Product Type                    | Source | Boxes  |
 |:--------------------------------|:-------|:-------|
 | Foreign Tax Credit Relief       | SA106  | Box 2  |

##### Example Request Response Body

```json
[
  {
    "type": "FOREIGN TAX CREDIT RELIEF",
    "amount" : 123.22
  }
]
```

\newpage

### Disclosures

#### URI

/disclosures/{taxableEntityId}/{taxYear}

#### Product Types

 | Product Type                    | Source | Boxes                     |
 |:--------------------------------|:-------|:--------------------------|
 | Tax Avoidance                   | SA101  | Tax Avoidance Box 19 - 20 |

#### Example Request / Response Body

```json
[
  {
    "type": "TAX AVOIDANCE",
    "SRN": "14213/1123",
    "taxYear": "2019-20"
  }
]
```
