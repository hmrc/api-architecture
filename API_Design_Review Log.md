# API Design Review Log

## Version 0.1 - 06.04.20

| Reference | Comment                                                                                                    | Commentator     | Response             |
|:----------|:-----------------------------------------------------------------------------------------------------------|:----------------|:---------------------|
| 1         | Breaking securities down into their component parts is not currently part of the requirements              | Heidi Griffiths | Collapsed            |
| 2         | Stock Dividends component part breakdown is not currently part of the requirements                         | Heidi Griffiths | Collapsed            |
| 3         | Voided ISA's is missing from the policies section                                                          | Heidi Griffiths | Added in             |
| 4         | Disguised Income is not in scope                                                                           | Heidi Griffiths | Removed              |
| 5         | Married Allowances is part of a separate work package                                                      | Heidi Griffiths | Removed              |
| 6         | Pensions Allowances are also being covered in A4 need to be wary that all the fields are not represented   | Heidi Griffiths | No Action Taken      |
| 7         | Maintenance Payments / Post Cessation receipts are missing                                                 | Heidi Griffiths | Added In             |
| 8         | What format is the tax year                                                                                | Ashleigh Carr   | Confirmed as yyyy-yy |
| 9         | Social Enterprise Investment does not include customer reference                                           | Ashleigh Carr   | Added In             |
| 10        | Can we add _and logically deleted_ to the definition of internal                                           | Ashleigh Carr   | Added                |

\newpage

## Version 0.2 - 06.04.20

| Reference | Comment                                                                                                    | Commentator     | Response  |
|:----------|:-----------------------------------------------------------------------------------------------------------|:----------------|:----------|
| 1         | Patent Royalty Payments should be moved to the other income section                                        | Heidi Griffiths | Moved     |
| 2         | Collapse the /income/other/foreign income section into /income/foreign for consistency                     | Design Group    | Collapsed |
| 3         | Unremittable amount is not in sterling                                                                     | Heidi Griffiths | Noted     |
| 4         | Remove all of Pension Allowances section as this being dealt with in the A4 Group                          | Heidi Griffiths | Removed   |
| 5         | Move Social Enterprise Investments to the /expenses/investments section                                    | Heidi Griffiths | Moved     |
| 6         | Move Seed Enterprise Investments to the /expenses/investments section                                      | Heidi Griffiths | Moved     |

\newpage

## Version 0.3 - 08.04.20

| Reference | Comment                                                                                                    | Commentator     | Response |
|:----------|:-----------------------------------------------------------------------------------------------------------|:----------------|:---------|
| 1         | Update data items with traceability to box numbers                                                         | Heidi Griffiths | Done     |
| 2         | Rename Foreign EEA to Foreign FHL EEA                                                                      | Heidi Griffiths | Done     |
| 3         | Rename Foreign Non - EEA to Foreign Property                                                               | Heidi Griffiths | Done     |
| 4         | Rename Foreign Non - EEA to Foreign Property                                                               | Heidi Griffiths | Done     |
| 5         | Share Scheme - Split into "Share Options" and "Shares Awarded / Received" and updated with fields provided | Heidi Griffiths | Done     |
| 6         | Lump Sum End of Job	- Remove considered as part of the employment package                                  | Heidi Griffiths | Done     |
| 7         | Lump Sum EFRBS	- Remove considered as part of the employment package                                      | Heidi Griffiths | Done     |
| 8         | Lump Sum Redundancy	- Remove considered as part of the employment package                                  | Heidi Griffiths | Done     |
| 9         | Lump Sum Compensation Below 30k	- Remove considered as part of the employment package                      | Heidi Griffiths | Done     |
| 10        | Disability - no impact on calculation move to income/employment/other                                      | Heidi Griffiths | Done     |
| 11        | Foreign Service - no impact on calculation move to income/employment/other                                 | Heidi Griffiths | Done     |
| 12        | Disability - remove field taxIncludedOnEmployment (not on form or in data catalogue)                       | Heidi Griffiths | Done     |
| 13        | Foreign Service - remove field taxIncludedOnEmployment (not on form or in data catalogue)                  | Heidi Griffiths | Done     |
| 14        | Add "Annual Payments Made" type to other Reliefs                                                           | Heidi Griffiths | Done     |
| 15        | Add "Qualifying Loan Interest Payments" type to other reliefs                                              | Heidi Griffiths | Done     |
| 16        | Foreign Tax Credit Relief CGT - Remove the CGT bit please                                                  | Heidi Griffiths | Done     |

\newpage

## Version 0.4 - 17.04.20

| Reference | Comment                                                                                                    | Commentator     | Response |
|:----------|:-----------------------------------------------------------------------------------------------------------|:----------------|:---------|
| 1         | Update the id path parameter to submission id on the Periodic Property API                                 | Toby Porter     | Done     |
| 2         | Normalise Dates in examples to yyyy-mm-dd format.                                                          | Ashleigh Carr   | Done     |
| 3         | Remove slash from Shares Awarded / Received type                                                           | Ashleigh Carr   | Done     |
| 4         | Change PAYERef to camel case                                                                               | Ashleigh Carr   | Done     |
| 5         | Change employersNICPaid to camel case                                                                      | Ashleigh Carr   | Done     |
| 6         | Remove slash from noOfShares/SecuritiesAwarded                                                             | Ashleigh Carr   | Done     |
| 7         | Change Unremittable to unremittable foreign Income                                                         | Ashleigh Carr   | Done     |
| 8         | Rename FCTR to foreignTaxCreditRelief                                                                      | Ashleigh Carr   | Done     |
| 9         | Add missing type from Foreign pensions example                                                             | Ashleigh Carr   | Done     |
| 10        | Change investmentDate to dateOfInvestment                                                                  | Ashleigh Carr   | Done     |
| 11        | Change knowledgeIntensive to false                                                                         | Ashleigh Carr   | Done     |
| 12        | Change amount (reliefInvestment) to amountInvested                                                         | Ashleigh Carr   | Done     |
| 13        | Add spouse details to other reliefs Maintenance payments                                                   | Ashleigh Carr   | Done     |
| 14        | Add lenderName to Qualifying Loan Interest Payments                                                        | Ashleigh Carr   | Done     |
| 15        | Remove CGT from foreign tax credit relief type                                                             | Ashleigh Carr   | Done     |
       
