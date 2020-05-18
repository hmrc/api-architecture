# Requirement Specification: Amend savings income

## References

| # |  Reference |
|---|:-----------|
| 1  | [Follow link to Additional information work package](https://drive.google.com/drive/folders/1pdOum0Oqh-hMckdh0bYcTy6xcjmQKdYb)   |
| 2  | [3rd Party HTTP Error Response Standards](https://confluence.tools.tax.service.gov.uk/display/MTE/3rd+Party+HTTP+Error+Response+Standards)    |


## API Summary

|   |   |
|---|---|
|Endpoint     |  Amend savings income |
|Method       |  PUT  |
|URI          |  /income/savings/{nino}/{taxYear} |
|Description  |  This endpoint allows a developer to provide or amend savings income for securities or foreign interest. A National Insurance number and tax year must be provided. |


## Business Requirements

### Request Details

#### (Vendor Supplied) Request Path / Query Parameters


| #	| Type       	| Parameter Name	| Description	| Type |	Format	| M/O	| Min | Max	| Validation	|Comments |
|---|---------------|---|---|---|---|---|---|---|---|---|
| I1 |Path Parameter	| Nino	    | National Insurance number, in the format AA999999A. For example: TC663795B	| String |	\^((?!(BG\|GB\|KN\|NK\|NT\|TN\|ZZ)\|(D\|F\|I\|Q\|U\|V)\[A-Z\]\|\[A-Z\](D\|F\|I\|O\|Q\|U\|V))\[A-Z\]{2})\[0-9\]{6}\[A-D\] | M	| 	|   |  	| See BVRs E1	|  |
| I2| Path Parameter    | Tax Year  |The tax year the submission relates to (YYYY-YY for example 2019-20 for the 19/20 tax year). For example: 2017-18 | Date in the format YYYY-YY |\^[0-9]{4}-[0-9]{2}$|M|---|---|---|---|
		


#### (Vendor Supplied) Request Body
| #    | Field Name        | Description         | Type | Format | M/O | Min | Max | Validation | Comments | 
|----- |:------------------|:--------------------|:-----|--------|-----|-----|-----|:-----------|----------|
|I3    | securitiesItems   | The container that holds the key value for securities |	Object | | | | | | | 	
|I3.1  | taxTakenOff       | The amount of tax deducted from Gilt Edge interest. The value must be between 0 and 99999999999.99 up to 2 decimal places. For example: 5000.99|	Number | (2dp) >=0.00 | O | 0.00 | 99999999999.99 | FORMAT_VALUE| |
|I3.2  | grossAmount       |The gross amount of Gilt Edge interest including tax deducted. The value must be between 0 and 99999999999.99 up to 2 decimal places.For example: 5000.99|Number|(2dp) >= 0.00| O | 0.00 | 99999999999.99 |FORMAT_VALUE | if there is an entry in  "taxTakenOf" then "grossAmount" is mandatory If the interest did not have tax taken off, put this amount in "grossAmount". Do not fill in boxes "taxTakenOff" |
|I3.3  | netAmount         |The amount of Gilt Edge interest after tax has been deducted. The value must be between 0 and 99999999999.99 up to 2 decimal places. For example: 5000.99 |Number|	(2dp) >= 0.00 |O |	0.00| 9999999999.99	FORMAT_VALUE | |
|I4	   | foreignInterestItems	|Financial details about foreign interest income| Array |  | | | | | | |
|I4.1  | foreignInterest   | he container that holds the key value for foreign interest	| Object |O | | | | | | 	
|I4.2  | amountBeforeTax   | The total amount of income, in UK pounds, before any foreign tax has been deducted. The value must be between 0 and 99999999999.99 up to 2 decimal places. For example: 5000.99|Number|(2dp) >= 0.00|O	|0.00|	99999999999.99|	FORMAT_VALUE||	
|I4.3  | countryCode       | A three-letter code that represents a country name. The value must in a ISO 3166-1 Alpha-3 format. For example: FRA | String|	ISO 3166-1 alpha-3| M | \^\[A-Z\]{3}$	| FORMAT_COUNTRY_CODE||	
|I4.4  | taxTakenOff       | The total amount of foreign tax taken off your income. The value must be greater than 0 and up to 99999999999.99. For example: 5000.99 | Number | (2dp) > 0.00 | O	|1	| 99999999999.99| 	FORMAT_VALUE||	
|I4.5  | specialWithholdingTax	| The total amount of income (in UK pounds) before deducting any Special Withholding Tax (SWT). The value must be between 1 and 99999999999.99 up to 2 decimal places. For example: 5000.99 | Number | (2dp) > 0.00 |O	|1	|99999999999.99	|FORMAT_VALUE |Casey Price the below probably can go in the service guide - its more explanatory. I think the description works as it is? Reword this information Special Withholding Tax Where SWT is deducted you're treated as having paid, in the year of deduction, an equivalent amount of Income Tax in the UK. This can be set against your UK tax liability of that year, including the remittance basis charge, or repaid to you if the amount exceeds that liability.6 Apr 2020|
|I4.6  | taxableAmount 	| The total taxable amount on dividends. The value must be between 0 and 99999999999.99 up to 2 decimal places. For example: 5000.99 | Number | (2dp) >= 0.00 | O	| 0.00	| 99999999999.99| 	FORMAT_VALUE | 
|I4.7  | foreignTaxCreditRelief | A boolean indicating whether foreign tax credit relief has been claimed. The value must be true or false For example: false | Boolean	| true \| false	| O | Covered by the RULE_INCORRECT_OR_EMPTY_BODY_SUBMITTED scenario.  Should only be thrown when a .format is called against the body |

#### (Returned to Vendor) Response Body
N/A

#### (Returned to Vendor) Response HATEOAS Links

|#	|Endpoints that should be linked to	| Rules for the Links being present |
|---|:----------------------------------|:----------------------------------| 
|L1 |See <insert_link> | The links should be present for successful response |


#### (Returned to Vendor) Response Headers
|#  | Header Name | Description | Type |Format | Required | Comments               |
|---|:------------|:------------|:-----|-------|----------|------------------------|
|H1 | X-CorrelationId | Unique ID for operation tracking String, 36 characters. Format: \^\[A-Za-z0-9\-\]{36}$ For example: a1e8057e-fbbc-47a8-a8b4-78d9f015c253 | String	| \^\[A-Za-z0-9\-\]{36}$	| Yes |	

#### Error Details

| #  | HTTP Status Code | Error Code       | Documentation Scenario                             |  Error Message | Paths | Frontend | Backend |
|----|:-----------------|:-----------------|:---------------------------------------------------|----------------|-------|:----------:|:---------:|
| E1 | 400 (Bad Request) | FORMAT_NINO     | The format of the supplied NINO field is not valid | The provided NINO is invalid | | Y | Y |  
| E2 | 400 (Bad Request) | FORMAT_TAX_YEAR | The tax year is not a valid date	                | The format of the supplied tax year is not valid| | Y | Y | 
| E3 | 400 (Bad Request) | RULE_ TAX_YEAR_NOT_SUPPORTED | The supplied tax year could not be found | The provided tax year is invalid |  | Y | Y |
| E4 | 400 (Bad Request) | FORMAT_VALUE	   | One or more values have been added with the incorrect format | | include paths to failing fields (see example below) | Y | Y |
| E5 | 400 (Bad Request) | FORMAT_COUNTRY_CODE | The provided country code is not valid | The provided country code is not valid | | Y | Y |
| E6 | 400 (Bad Request) | RULE_INCORRECT_OR_EMPTY_BODY_SUBMITTED | An empty or non-matching body was submitted	| An empty or non-matching body was submitted | 	
| E7 | 404 (Not Found)   | MATCHING_RESOURCE_NOT_FOUND | The supplied income source could not be found	Matching resource not found | | Y | Y |
| E8 | 403 (Forbidden)   | CLIENT_OR_AGENT_NOT_AUTHORISED | The client or agent is not authorised. This because: the client is not subscribed to MTD, the agent is not subscribed to Agent Services, or the client has not authorised the agent to act on their behalf |	The client or agent is not authorised | | Y | Y |
	

[Common technical errors (Error Scenarios)](https://confluence.tools.tax.service.gov.uk/pages/viewpage.action?pageId=101667731) applied across all 3rd party APIs.

**Example multi-field validation error**

```
{
  "code": "INVALID_REQUEST",
  "message": "Invalid request",
  "errors": [
    {
     "code": "FORMAT_VALUE",
     "message": "The field should be a positive value greater than 0 and no greater than 99999999999.99",
     "paths": ["securities/grossAmount", "securities/taxAmount"]
    },
    {
     "code": "FORMAT_VALUE",
     "message": "The field should be between 0 and 99999999999.99",
     "paths": ["securitiesItems/0/amountBeforeTax", "securitiesItems/1/amountBeforeTax"]
     },
  ]}
```
