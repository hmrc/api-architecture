# Untitled string in Get Pension Charges Schema

```txt
https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSchemeTaxReference/items
```




| Abstract            | Extensible | Status         | Identifiable            | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                            |
| :------------------ | ---------- | -------------- | ----------------------- | :---------------- | --------------------- | ------------------- | --------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | Unknown identifiability | Forbidden         | Allowed               | none                | [pensions.schema.json\*](pensions.schema.json "open original schema") |

## items Type

`string`

## items Constraints

**pattern**: the string must match the following regular expression: 

```regexp
^[0-9]{8}[A-Z]{2}$
```

[try pattern](https://regexr.com/?expression=%5E%5B0-9%5D%7B8%7D%5BA-Z%5D%7B2%7D%24 "try regular expression with regexr.com")
