# Untitled object in Get Pension Charges Schema

```txt
https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionContributionsType
```




| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                            |
| :------------------ | ---------- | -------------- | ------------ | :---------------- | --------------------- | ------------------- | --------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Forbidden             | none                | [pensions.schema.json\*](pensions.schema.json "open original schema") |

## pensionContributionsType Type

`object` ([Details](pensions-definitions-pensioncontributionstype.md))

# undefined Properties

| Property                                                      | Type     | Required | Nullable       | Defined by                                                                                                                                                                                                                                                |
| :------------------------------------------------------------ | -------- | -------- | -------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [pensionSchemeTaxReference](#pensionSchemeTaxReference)       | `array`  | Required | cannot be null | [Get Pension Charges](pensions-definitions-pensionschemetaxreference.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionContributionsType/properties/pensionSchemeTaxReference") |
| [inExcessOfTheAnnualAllowance](#inExcessOfTheAnnualAllowance) | `number` | Required | cannot be null | [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/pensionContributionsType/properties/inExcessOfTheAnnualAllowance")                                                                                              |
| [annualAllowanceTaxPaid](#annualAllowanceTaxPaid)             | `number` | Optional | cannot be null | [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/pensionContributionsType/properties/annualAllowanceTaxPaid")                                                                                                    |

## pensionSchemeTaxReference




`pensionSchemeTaxReference`

-   is required
-   Type: `string[]`
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-pensionschemetaxreference.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionContributionsType/properties/pensionSchemeTaxReference")

### pensionSchemeTaxReference Type

`string[]`

### pensionSchemeTaxReference Constraints

**minimum number of items**: the minimum number of items for this array is: `1`

## inExcessOfTheAnnualAllowance




`inExcessOfTheAnnualAllowance`

-   is required
-   Type: `number`
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/pensionContributionsType/properties/inExcessOfTheAnnualAllowance")

### inExcessOfTheAnnualAllowance Type

`number`

### inExcessOfTheAnnualAllowance Constraints

**multiple of**: the value of this number must be a multiple of: `0.01`

**maximum**: the value of this number must smaller than or equal to: `99999999999.99`

**minimum**: the value of this number must greater than or equal to: `0`

## annualAllowanceTaxPaid




`annualAllowanceTaxPaid`

-   is optional
-   Type: `number`
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/pensionContributionsType/properties/annualAllowanceTaxPaid")

### annualAllowanceTaxPaid Type

`number`

### annualAllowanceTaxPaid Constraints

**multiple of**: the value of this number must be a multiple of: `0.01`

**maximum**: the value of this number must smaller than or equal to: `99999999999.99`

**minimum**: the value of this number must greater than or equal to: `0`
