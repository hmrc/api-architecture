# Untitled object in Get Pension Charges Schema

```txt
https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSchemeUnauthorisedPaymentsType/properties/surcharge
```




| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                            |
| :------------------ | ---------- | -------------- | ------------ | :---------------- | --------------------- | ------------------- | --------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Forbidden             | none                | [pensions.schema.json\*](pensions.schema.json "open original schema") |

## surcharge Type

`object` ([Details](pensions-definitions-pensionschemeunauthorisedpaymentstype-properties-surcharge.md))

# undefined Properties

| Property                          | Type     | Required | Nullable       | Defined by                                                                                                                                                                       |
| :-------------------------------- | -------- | -------- | -------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [amount](#amount)                 | `number` | Required | cannot be null | [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/pensionSchemeUnauthorisedPaymentsType/properties/surcharge/properties/amount")         |
| [foreignTaxPaid](#foreignTaxPaid) | `number` | Optional | cannot be null | [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/pensionSchemeUnauthorisedPaymentsType/properties/surcharge/properties/foreignTaxPaid") |

## amount




`amount`

-   is required
-   Type: `number`
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/pensionSchemeUnauthorisedPaymentsType/properties/surcharge/properties/amount")

### amount Type

`number`

### amount Constraints

**multiple of**: the value of this number must be a multiple of: `0.01`

**maximum**: the value of this number must smaller than or equal to: `99999999999.99`

**minimum**: the value of this number must greater than or equal to: `0`

## foreignTaxPaid




`foreignTaxPaid`

-   is optional
-   Type: `number`
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/pensionSchemeUnauthorisedPaymentsType/properties/surcharge/properties/foreignTaxPaid")

### foreignTaxPaid Type

`number`

### foreignTaxPaid Constraints

**multiple of**: the value of this number must be a multiple of: `0.01`

**maximum**: the value of this number must smaller than or equal to: `99999999999.99`

**minimum**: the value of this number must greater than or equal to: `0`
