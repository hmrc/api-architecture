# Self Assessment Monolith API Migration Plan

Author: Toby Porter

Date: 29 Jul 2020

![](RackMultipart20200730-4-l9psn5_html_7e0e1a12e13923d0.png)

## High Level Migration Plan Summary

Monolith basepath: self-assessment/ni/{nino}

| **Domain** | **Source Path(s)** | **Status** | **Transformation(s)** | **Destination Path(s)** |
| --- | --- | --- | --- | --- |
| 1. Dividends | ●dividends/{taxYear} | P | Add 1 KVP to request body

DES to add to API#000 | ●/individuals/income-received/dividends/{nino}/{taxYear} |
| 2. Savings | ●savings-accounts/{savingsAccountId}/{taxYear} | P | #TODO | ●/individuals/income-received/savings/{nino}/{taxYear} |
| 3. Property (UK Annual) | ●uk-properties/other/{taxYear}
 ●uk-properties/furnished-holiday-lettings/{taxYear}

 | P | Add objects for Other UK property &amp; FHL to request body | ●/individuals/business/property/{nino}/{businessId}/annual/{taxYear} |
| Property (UK Periodic) | ●uk-properties/other/periods
 ●uk-properties/furnished-holiday-lettings/periods
 | P | Add objects for Other UK property &amp; FHL to request body | ●/individuals/business/property/{nino}/{businessId}/period/ |
| 4. Calculations | ●calculations | L | N/A - already live.
3PVs advised to use new APIs | ●/individuals/calculations/{nino}/self-employment |
| 5. Crystalisation | ●{taxYear}/intent-to-crystalise
●{taxYear}/crystalisation | P | Relocate published service to new endpoints in Calculations microservice.
No impact on downstream systems | ●/individuals/calculations/crystalisation/{nino}/{taxYear}/intent-to-crystalise
●/individuals/calculations/crystalisation/{nino}/{taxYear}/crystalisation
 |
| 6. Income Summary | ●self-employments/{selfEmploymentId}/{taxYear}/income-summary

●uk-properties/{selfEmploymentId}/{taxYear}/income-summary | L | N/A - already live
3PVs advised to use new APIs | ●/individuals/self-assessment/income-summary/{nino}/self-employment
●/individuals/self-assessment/income-summary/{nino}/uk-property |
| 7. Income (Annual) | ●self-employments/{taxYear} | P | Relocate published service to new endpoints in Business microservice.
No impact on downstream systems | ●individuals/business/self-employment/{nino}/{businessId}/annual/{taxYear} |
| 8. Income (Periodic) | ●self-employments/periods | P | Relocate published service to new endpoints in Business microservice.
No impact on downstream systems | ●individuals/business/self-employment/{nino}/{businessId}/period/ |
| 9. EOPs | ●self-employments/end-of-period-statements
●uk-properties/end-of-period-statements | P | Consolidate 2 legacy endpoints into 1 new endpoint in Business microservice.
No impact on downstream systems | ●/individuals/business/end-of-period-statement/{nino}/{businessId} |
| 10. Obligations | ●crystalisation/obligations
●self-employments/{selfEmploymentId}/end-of-period-statements/obligations
●self-employments/obligations

●uk-properties/end-of-period-statements/obligations | D | Consolidate 4 legacy endpoints into 1 new Obligations microservice.

 | ●/obligations/{nino}/income-tax |
| 11. Charitable Giving | charitable-giving/{taxYear} | P | Add 1 object for Charitable Giving to request body | ●/individuals/reliefs/other/{nino}/{taxYear} |

KVP = Key Value Pair | 3PV = Third Party Vendor | Status: P = Proposed; L = Live; D = In development

1.
### Dividends

**Endpoints**

| **Source Path(s)**
/self-assessment/ni/{nino} | **Src. Method** | **Destination Path(s)** | **Dest. Method** |
| --- | --- | --- | --- |
| /dividends/{taxYear} | GET | /individuals/income-received/dividends/{nino}/{taxYear} | GET |
| /dividends/{taxYear} | PUT | /individuals/income-received/dividends/{nino}/{taxYear} | PUT |
|
 |
 | /individuals/income-received/dividends/{nino}/{taxYear} | DELETE |

**Request/Response**

| **Source Request** | **Destination Request** |
| --- | --- |
| {&quot;ukDividends&quot;: 1000.50,&quot;otherUkDividends&quot;: 2000.35}

 | {&quot;foreignDividend&quot;: [{&quot;countryCode&quot;: &quot;GER&quot;,&quot;amountBeforeTax&quot;: 1232.22,&quot;taxTakenOff&quot;: 22.22,&quot;specialWitholdingTax&quot;: 22.22,&quot;foreignTaxCreditRelief&quot;: true,&quot;taxableAmount&quot;: 2321.22}],&quot;dividendIncomeReceivedWhilstAbroad&quot;: [{&quot;countryCode&quot;: &quot;GER&quot;,&quot;amountBeforeTax&quot;: 1232.22,&quot;taxTakenOff&quot;: 22.22,&quot;specialWitholdingTax&quot;: 22.22,&quot;foreignTaxCreditRelief&quot;: true,&quot;taxableAmount&quot;: 2321.22}],&quot;stockDividend&quot;: {&quot;customerReference&quot;: &quot;my divs&quot;,&quot;grossAmount&quot;: 12321.22},&quot;redeemableShares&quot;: {&quot;customerReference&quot;: &quot;my shares&quot;,&quot;grossAmount&quot;: 12321.22},&quot;bonusIssuesOfSecurities&quot;: {&quot;customerReference&quot;: &quot;my secs&quot;,&quot;grossAmount&quot;: 12321.22},&quot;closeCompanyLoansWrittenOff&quot;: {&quot;customerReference&quot;: &quot;write off&quot;,&quot;grossAmount&quot;: 12321.22},&quot;ukDividends&quot;: {&quot;grossAmount&quot;: 1000.50},&quot;otherUkDividends&quot; {&quot;grossAmount&quot;: 2000.35}}
 |

**End to End**

**DES**

**ITSD**

**ETMP**

**IBD**

1.
### Savings

**Endpoints**

| **Source Path(s)**
/self-assessment/ni/{nino} | **Src. Method** | **Destination Path(s)** | **Dest. Method** |
| --- | --- | --- | --- |
| /savings-accounts
 | POST | /individuals/income-received/savings/{nino}/{taxYear} | GET |
| /savings-accounts
 | GET | /individuals/income-received/savings/{nino}/{taxYear} |
 |
| /savings-accounts/{savingsAccountId}
 | GET | /individuals/income-received/savings/{nino}/{taxYear} | PUT |
| /savings-accounts/{savingsAccountId}/{taxYear} |
 | /individuals/income-received/savings/{nino}/{taxYear} | DELETE |

**Request/Response**

| **Source Request(s)** | **Destination Request(s)** |
| --- | --- |
| {&quot;savingsAccounts&quot;: [{&quot;id&quot;: &quot;SAVKB2UVwUTBQGJ&quot;,&quot;accountName&quot;: &quot;Main account name&quot;},{&quot;id&quot;: &quot;SAVKB2UVwUTBQGK&quot;,&quot;accountName&quot;: &quot;Shares savings account&quot;}]}


{&quot;taxedUkInterest&quot;: 1230.55,&quot;untaxedUkInterest&quot;: 500.5}
 | {&quot;securities&quot;:{&quot;taxTakenOff&quot;: 100.0,&quot;grossAmount&quot;: 1455.0,&quot;netAmount&quot;: 123.22},&quot;foreignInterest&quot;: [{&quot;amountBeforeTax&quot;: 1232.22,&quot;countryCode&quot;: &quot;GER&quot;,&quot;taxTakenOff&quot;: 22.22,&quot;specialWitholdingTax&quot;: 22.22,&quot;taxableAmount&quot;: 2321.22,&quot;foreignTaxCreditRelief&quot;: true}],&quot;savingsAccounts&quot;:{&quot;taxTakenOff&quot;: 100.0,&quot;grossAmount&quot;: 1455.0,&quot;netAmount&quot;: 123.22},}


{&quot;taxedUkInterest&quot;: 1230.55,&quot;untaxedUkInterest&quot;: 500.5}


 |
|
 |
 |

**End to End**

**DES**

**ITSD**

**ETMP**

**IBD**

1.
### Property (UK Annual)

1.
### Property (UK Periodic)

1.
### Calculations

1.
### Crystalisation

1.
### Income Summary

1.
### Income (Annual)

1.
### Income (Periodic)

1.
### EOPs

1.
### Obligations

1.
### Charitable Giving

## Issues

- No EOPs for foreign property
- Business ID not currently mandatory for UK property8
- TXM Implications