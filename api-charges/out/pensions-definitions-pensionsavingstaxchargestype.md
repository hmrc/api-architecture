# Untitled object in Get Pension Charges Schema

```txt
https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSavingsTaxChargesType
```




| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                            |
| :------------------ | ---------- | -------------- | ------------ | :---------------- | --------------------- | ------------------- | --------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Forbidden             | none                | [pensions.schema.json\*](pensions.schema.json "open original schema") |

## pensionSavingsTaxChargesType Type

`object` ([Details](pensions-definitions-pensionsavingstaxchargestype.md))

one (and only one) of

-   not

    -   [Untitled undefined type in Get Pension Charges](pensions-definitions-pensionsavingstaxchargestype-oneof-0-not.md "check type definition")
-   not

    -   [Untitled undefined type in Get Pension Charges](pensions-definitions-pensionsavingstaxchargestype-oneof-1-not.md "check type definition")
-   [Untitled undefined type in Get Pension Charges](pensions-definitions-pensionsavingstaxchargestype-oneof-2.md "check type definition")

# undefined Properties

| Property                                                                                          | Type     | Required | Nullable       | Defined by                                                                                                                                                                                                                                                                                                                                      |
| :------------------------------------------------------------------------------------------------ | -------- | -------- | -------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [pensionSchemeTaxReference](#pensionSchemeTaxReference)                                           | `array`  | Optional | cannot be null | [Get Pension Charges](pensions-definitions-pensionschemetaxreference.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSavingsTaxChargesType/properties/pensionSchemeTaxReference")                                                                                   |
| [lumpSumBenefitTakenInExcessOfLifetimeAllowance](#lumpSumBenefitTakenInExcessOfLifetimeAllowance) | `object` | Optional | cannot be null | [Get Pension Charges](pensions-definitions-pensionsavingstaxchargestype-properties-lumpsumbenefittakeninexcessoflifetimeallowance.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSavingsTaxChargesType/properties/lumpSumBenefitTakenInExcessOfLifetimeAllowance") |
| [benefitInExcessOfLifetimeAllowance](#benefitInExcessOfLifetimeAllowance)                         | `object` | Optional | cannot be null | [Get Pension Charges](pensions-definitions-pensionsavingstaxchargestype-properties-benefitinexcessoflifetimeallowance.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSavingsTaxChargesType/properties/benefitInExcessOfLifetimeAllowance")                         |

## pensionSchemeTaxReference




`pensionSchemeTaxReference`

-   is optional
-   Type: `string[]`
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-pensionschemetaxreference.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSavingsTaxChargesType/properties/pensionSchemeTaxReference")

### pensionSchemeTaxReference Type

`string[]`

### pensionSchemeTaxReference Constraints

**minimum number of items**: the minimum number of items for this array is: `1`

## lumpSumBenefitTakenInExcessOfLifetimeAllowance




`lumpSumBenefitTakenInExcessOfLifetimeAllowance`

-   is optional
-   Type: `object` ([Details](pensions-definitions-pensionsavingstaxchargestype-properties-lumpsumbenefittakeninexcessoflifetimeallowance.md))
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-pensionsavingstaxchargestype-properties-lumpsumbenefittakeninexcessoflifetimeallowance.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSavingsTaxChargesType/properties/lumpSumBenefitTakenInExcessOfLifetimeAllowance")

### lumpSumBenefitTakenInExcessOfLifetimeAllowance Type

`object` ([Details](pensions-definitions-pensionsavingstaxchargestype-properties-lumpsumbenefittakeninexcessoflifetimeallowance.md))

## benefitInExcessOfLifetimeAllowance




`benefitInExcessOfLifetimeAllowance`

-   is optional
-   Type: `object` ([Details](pensions-definitions-pensionsavingstaxchargestype-properties-benefitinexcessoflifetimeallowance.md))
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-pensionsavingstaxchargestype-properties-benefitinexcessoflifetimeallowance.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSavingsTaxChargesType/properties/benefitInExcessOfLifetimeAllowance")

### benefitInExcessOfLifetimeAllowance Type

`object` ([Details](pensions-definitions-pensionsavingstaxchargestype-properties-benefitinexcessoflifetimeallowance.md))
