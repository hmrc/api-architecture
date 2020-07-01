# Untitled object in Get Pension Charges Schema

```txt
https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSchemeUnauthorisedPaymentsType
```




| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                            |
| :------------------ | ---------- | -------------- | ------------ | :---------------- | --------------------- | ------------------- | --------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Forbidden             | none                | [pensions.schema.json\*](pensions.schema.json "open original schema") |

## pensionSchemeUnauthorisedPaymentsType Type

`object` ([Details](pensions-definitions-pensionschemeunauthorisedpaymentstype.md))

one (and only one) of

-   not

    -   [Untitled undefined type in Get Pension Charges](pensions-definitions-pensionschemeunauthorisedpaymentstype-oneof-0-not.md "check type definition")
-   not

    -   [Untitled undefined type in Get Pension Charges](pensions-definitions-pensionschemeunauthorisedpaymentstype-oneof-1-not.md "check type definition")
-   [Untitled undefined type in Get Pension Charges](pensions-definitions-pensionschemeunauthorisedpaymentstype-oneof-2.md "check type definition")

# undefined Properties

| Property                                                | Type     | Required | Nullable       | Defined by                                                                                                                                                                                                                                                                                  |
| :------------------------------------------------------ | -------- | -------- | -------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [pensionSchemeTaxReference](#pensionSchemeTaxReference) | `array`  | Optional | cannot be null | [Get Pension Charges](pensions-definitions-pensionschemetaxreference.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSchemeUnauthorisedPaymentsType/properties/pensionSchemeTaxReference")                      |
| [surcharge](#surcharge)                                 | `object` | Optional | cannot be null | [Get Pension Charges](pensions-definitions-pensionschemeunauthorisedpaymentstype-properties-surcharge.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSchemeUnauthorisedPaymentsType/properties/surcharge")     |
| [noSurcharge](#noSurcharge)                             | `object` | Optional | cannot be null | [Get Pension Charges](pensions-definitions-pensionschemeunauthorisedpaymentstype-properties-nosurcharge.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSchemeUnauthorisedPaymentsType/properties/noSurcharge") |

## pensionSchemeTaxReference




`pensionSchemeTaxReference`

-   is optional
-   Type: `string[]`
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-pensionschemetaxreference.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSchemeUnauthorisedPaymentsType/properties/pensionSchemeTaxReference")

### pensionSchemeTaxReference Type

`string[]`

### pensionSchemeTaxReference Constraints

**minimum number of items**: the minimum number of items for this array is: `1`

## surcharge




`surcharge`

-   is optional
-   Type: `object` ([Details](pensions-definitions-pensionschemeunauthorisedpaymentstype-properties-surcharge.md))
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-pensionschemeunauthorisedpaymentstype-properties-surcharge.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSchemeUnauthorisedPaymentsType/properties/surcharge")

### surcharge Type

`object` ([Details](pensions-definitions-pensionschemeunauthorisedpaymentstype-properties-surcharge.md))

## noSurcharge




`noSurcharge`

-   is optional
-   Type: `object` ([Details](pensions-definitions-pensionschemeunauthorisedpaymentstype-properties-nosurcharge.md))
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-pensionschemeunauthorisedpaymentstype-properties-nosurcharge.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/pensionSchemeUnauthorisedPaymentsType/properties/noSurcharge")

### noSurcharge Type

`object` ([Details](pensions-definitions-pensionschemeunauthorisedpaymentstype-properties-nosurcharge.md))
