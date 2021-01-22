# Untitled object in Get Pension Charges Schema

```txt
https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSavingsTaxChargesType/properties/lumpSumBenefitTakenInExcessOfLifetimeAllowance
```




| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                            |
| :------------------ | ---------- | -------------- | ------------ | :---------------- | --------------------- | ------------------- | --------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Forbidden             | none                | [pensions.schema.json\*](pensions.schema.json "open original schema") |

## lumpSumBenefitTakenInExcessOfLifetimeAllowance Type

`object` ([Details](pensions-definitions-pensionsavingstaxchargestype-properties-lumpsumbenefittakeninexcessoflifetimeallowance.md))

# undefined Properties

| Property            | Type     | Required | Nullable       | Defined by                                                                                                                                                                                            |
| :------------------ | -------- | -------- | -------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [amount](#amount)   | `number` | Required | cannot be null | [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/pensionSavingsTaxChargesType/properties/lumpSumBenefitTakenInExcessOfLifetimeAllowance/properties/amount")  |
| [taxPaid](#taxPaid) | `number` | Optional | cannot be null | [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/pensionSavingsTaxChargesType/properties/lumpSumBenefitTakenInExcessOfLifetimeAllowance/properties/taxPaid") |

## amount




`amount`

-   is required
-   Type: `number`
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/pensionSavingsTaxChargesType/properties/lumpSumBenefitTakenInExcessOfLifetimeAllowance/properties/amount")

### amount Type

`number`

### amount Constraints

**multiple of**: the value of this number must be a multiple of: `0.01`

**maximum**: the value of this number must smaller than or equal to: `99999999999.99`

**minimum**: the value of this number must greater than or equal to: `0`

## taxPaid




`taxPaid`

-   is optional
-   Type: `number`
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-moneypositive.md "\#moneyPositive#/definitions/pensionSavingsTaxChargesType/properties/lumpSumBenefitTakenInExcessOfLifetimeAllowance/properties/taxPaid")

### taxPaid Type

`number`

### taxPaid Constraints

**multiple of**: the value of this number must be a multiple of: `0.01`

**maximum**: the value of this number must smaller than or equal to: `99999999999.99`

**minimum**: the value of this number must greater than or equal to: `0`
