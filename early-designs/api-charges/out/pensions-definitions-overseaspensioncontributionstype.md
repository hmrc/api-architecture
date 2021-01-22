# Untitled object in Get Pension Charges Schema

```txt
https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/overseasPensionContributionsType
```




| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                            |
| :------------------ | ---------- | -------------- | ------------ | :---------------- | --------------------- | ------------------- | --------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Forbidden             | none                | [pensions.schema.json\*](pensions.schema.json "open original schema") |

## overseasPensionContributionsType Type

`object` ([Details](pensions-definitions-overseaspensioncontributionstype.md))

# undefined Properties

| Property                                                | Type     | Required | Nullable       | Defined by                                                                                                                                                                                                                                                  |
| :------------------------------------------------------ | -------- | -------- | -------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [overseasSchemeProvider](#overseasSchemeProvider)       | `array`  | Required | cannot be null | [Get Pension Charges](pensions-definitions-overseasschemeprovider.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/overseasPensionContributionsType/properties/overseasSchemeProvider") |
| [shortServiceRefund](#shortServiceRefund)               | `number` | Required | cannot be null | [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/overseasPensionContributionsType/properties/shortServiceRefund")                                                                                                  |
| [shortServiceRefundTaxPaid](#shortServiceRefundTaxPaid) | `number` | Optional | cannot be null | [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/overseasPensionContributionsType/properties/shortServiceRefundTaxPaid")                                                                                           |

## overseasSchemeProvider




`overseasSchemeProvider`

-   is required
-   Type: `object[]` ([Details](pensions-definitions-schemeprovider.md))
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-overseasschemeprovider.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/overseasPensionContributionsType/properties/overseasSchemeProvider")

### overseasSchemeProvider Type

`object[]` ([Details](pensions-definitions-schemeprovider.md))

### overseasSchemeProvider Constraints

**minimum number of items**: the minimum number of items for this array is: `1`

## shortServiceRefund




`shortServiceRefund`

-   is required
-   Type: `number`
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/overseasPensionContributionsType/properties/shortServiceRefund")

### shortServiceRefund Type

`number`

### shortServiceRefund Constraints

**multiple of**: the value of this number must be a multiple of: `0.01`

**maximum**: the value of this number must smaller than or equal to: `99999999999.99`

**minimum**: the value of this number must greater than or equal to: `0`

## shortServiceRefundTaxPaid




`shortServiceRefundTaxPaid`

-   is optional
-   Type: `number`
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/overseasPensionContributionsType/properties/shortServiceRefundTaxPaid")

### shortServiceRefundTaxPaid Type

`number`

### shortServiceRefundTaxPaid Constraints

**multiple of**: the value of this number must be a multiple of: `0.01`

**maximum**: the value of this number must smaller than or equal to: `99999999999.99`

**minimum**: the value of this number must greater than or equal to: `0`
