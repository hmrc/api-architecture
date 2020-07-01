# Untitled object in Get Pension Charges Schema

```txt
https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSchemeOverseasTransfersType
```




| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                            |
| :------------------ | ---------- | -------------- | ------------ | :---------------- | --------------------- | ------------------- | --------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Forbidden             | none                | [pensions.schema.json\*](pensions.schema.json "open original schema") |

## pensionSchemeOverseasTransfersType Type

`object` ([Details](pensions-definitions-pensionschemeoverseastransferstype.md))

# undefined Properties

| Property                                          | Type     | Required | Nullable       | Defined by                                                                                                                                                                                                                                                    |
| :------------------------------------------------ | -------- | -------- | -------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [overseasSchemeProvider](#overseasSchemeProvider) | `array`  | Required | cannot be null | [Get Pension Charges](pensions-definitions-overseasschemeprovider.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSchemeOverseasTransfersType/properties/overseasSchemeProvider") |
| [transferCharge](#transferCharge)                 | `number` | Required | cannot be null | [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/pensionSchemeOverseasTransfersType/properties/transferCharge")                                                                                                      |
| [transferChargeTaxPaid](#transferChargeTaxPaid)   | `number` | Optional | cannot be null | [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/pensionSchemeOverseasTransfersType/properties/transferChargeTaxPaid")                                                                                               |

## overseasSchemeProvider




`overseasSchemeProvider`

-   is required
-   Type: `object[]` ([Details](pensions-definitions-schemeprovider.md))
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-overseasschemeprovider.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSchemeOverseasTransfersType/properties/overseasSchemeProvider")

### overseasSchemeProvider Type

`object[]` ([Details](pensions-definitions-schemeprovider.md))

### overseasSchemeProvider Constraints

**minimum number of items**: the minimum number of items for this array is: `1`

## transferCharge




`transferCharge`

-   is required
-   Type: `number`
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/pensionSchemeOverseasTransfersType/properties/transferCharge")

### transferCharge Type

`number`

### transferCharge Constraints

**multiple of**: the value of this number must be a multiple of: `0.01`

**maximum**: the value of this number must smaller than or equal to: `99999999999.99`

**minimum**: the value of this number must greater than or equal to: `0`

## transferChargeTaxPaid




`transferChargeTaxPaid`

-   is optional
-   Type: `number`
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/pensionSchemeOverseasTransfersType/properties/transferChargeTaxPaid")

### transferChargeTaxPaid Type

`number`

### transferChargeTaxPaid Constraints

**multiple of**: the value of this number must be a multiple of: `0.01`

**maximum**: the value of this number must smaller than or equal to: `99999999999.99`

**minimum**: the value of this number must greater than or equal to: `0`
