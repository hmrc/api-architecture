# Untitled object in Get Pension Charges Schema

```txt
https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/overseasSchemeProvider/items
```




| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                            |
| :------------------ | ---------- | -------------- | ------------ | :---------------- | --------------------- | ------------------- | --------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Forbidden             | none                | [pensions.schema.json\*](pensions.schema.json "open original schema") |

## items Type

`object` ([Details](pensions-definitions-schemeprovider.md))

# undefined Properties

| Property                                    | Type     | Required | Nullable       | Defined by                                                                                                                                                                                                                                            |
| :------------------------------------------ | -------- | -------- | -------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [providerName](#providerName)               | `string` | Required | cannot be null | [Get Pension Charges](pensions-definitions-schemeprovider-properties-providername.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/schemeProvider/properties/providerName")       |
| [providerAddress](#providerAddress)         | `string` | Required | cannot be null | [Get Pension Charges](pensions-definitions-schemeprovider-properties-provideraddress.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/schemeProvider/properties/providerAddress") |
| [providerCountryCode](#providerCountryCode) | `string` | Required | cannot be null | [Get Pension Charges](pensions-definitions-countrycodes.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/schemeProvider/properties/providerCountryCode")                          |

## providerName




`providerName`

-   is required
-   Type: `string`
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-schemeprovider-properties-providername.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/schemeProvider/properties/providerName")

### providerName Type

`string`

### providerName Constraints

**maximum length**: the maximum number of characters for this string is: `105`

**minimum length**: the minimum number of characters for this string is: `1`

## providerAddress




`providerAddress`

-   is required
-   Type: `string`
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-schemeprovider-properties-provideraddress.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/schemeProvider/properties/providerAddress")

### providerAddress Type

`string`

### providerAddress Constraints

**maximum length**: the maximum number of characters for this string is: `250`

**minimum length**: the minimum number of characters for this string is: `1`

## providerCountryCode




`providerCountryCode`

-   is required
-   Type: `string`
-   cannot be null
-   defined in: [Get Pension Charges](pensions-definitions-countrycodes.md "https&#x3A;//www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges#/definitions/schemeProvider/properties/providerCountryCode")

### providerCountryCode Type

`string`

### providerCountryCode Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value   | Explanation |
| :------ | ----------- |
| `"ABW"` |             |
| `"AFG"` |             |
| `"AGO"` |             |
| `"AIA"` |             |
| `"ALA"` |             |
| `"ALB"` |             |
| `"AND"` |             |
| `"ANT"` |             |
| `"ARE"` |             |
| `"ARG"` |             |
| `"ARM"` |             |
| `"ASM"` |             |
| `"ATA"` |             |
| `"ATF"` |             |
| `"ATG"` |             |
| `"AUS"` |             |
| `"AUT"` |             |
| `"AZE"` |             |
| `"BDI"` |             |
| `"BEL"` |             |
| `"BEN"` |             |
| `"BFA"` |             |
| `"BGD"` |             |
| `"BGR"` |             |
| `"BHR"` |             |
| `"BHS"` |             |
| `"BIH"` |             |
| `"BLM"` |             |
| `"BLR"` |             |
| `"BLZ"` |             |
| `"BMU"` |             |
| `"BOL"` |             |
| `"BRA"` |             |
| `"BRB"` |             |
| `"BRN"` |             |
| `"BTN"` |             |
| `"BVT"` |             |
| `"BWA"` |             |
| `"CAF"` |             |
| `"CAN"` |             |
| `"CCK"` |             |
| `"CHE"` |             |
| `"CHL"` |             |
| `"CHN"` |             |
| `"CIV"` |             |
| `"CMR"` |             |
| `"COD"` |             |
| `"COG"` |             |
| `"COK"` |             |
| `"COL"` |             |
| `"COM"` |             |
| `"CPV"` |             |
| `"CRI"` |             |
| `"CUB"` |             |
| `"CXR"` |             |
| `"CYM"` |             |
| `"CYP"` |             |
| `"CZE"` |             |
| `"DEU"` |             |
| `"DJI"` |             |
| `"DMA"` |             |
| `"DNK"` |             |
| `"DOM"` |             |
| `"DZA"` |             |
| `"ECU"` |             |
| `"EGY"` |             |
| `"ERI"` |             |
| `"ESH"` |             |
| `"ESP"` |             |
| `"EST"` |             |
| `"ETH"` |             |
| `"FIN"` |             |
| `"FJI"` |             |
| `"FLK"` |             |
| `"FRA"` |             |
| `"FRO"` |             |
| `"FSM"` |             |
| `"GAB"` |             |
| `"GBR"` |             |
| `"GEO"` |             |
| `"GGY"` |             |
| `"GHA"` |             |
| `"GIB"` |             |
| `"GIN"` |             |
| `"GLP"` |             |
| `"GMB"` |             |
| `"GNB"` |             |
| `"GNQ"` |             |
| `"GRC"` |             |
| `"GRD"` |             |
| `"GRL"` |             |
| `"GTM"` |             |
| `"GUF"` |             |
| `"GUM"` |             |
| `"GUY"` |             |
| `"HKG"` |             |
| `"HMD"` |             |
| `"HND"` |             |
| `"HRV"` |             |
| `"HTI"` |             |
| `"HUN"` |             |
| `"IDN"` |             |
| `"IMN"` |             |
| `"IND"` |             |
| `"IOT"` |             |
| `"IRL"` |             |
| `"IRN"` |             |
| `"IRQ"` |             |
| `"ISL"` |             |
| `"ISR"` |             |
| `"ITA"` |             |
| `"JAM"` |             |
| `"JEY"` |             |
| `"JOR"` |             |
| `"JPN"` |             |
| `"KAZ"` |             |
| `"KEN"` |             |
| `"KGZ"` |             |
| `"KHM"` |             |
| `"KIR"` |             |
| `"KNA"` |             |
| `"KOR"` |             |
| `"KWT"` |             |
| `"LAO"` |             |
| `"LBN"` |             |
| `"LBR"` |             |
| `"LBY"` |             |
| `"LCA"` |             |
| `"LIE"` |             |
| `"LKA"` |             |
| `"LSO"` |             |
| `"LTU"` |             |
| `"LUX"` |             |
| `"LVA"` |             |
| `"MAC"` |             |
| `"MAF"` |             |
| `"MAR"` |             |
| `"MCO"` |             |
| `"MDA"` |             |
| `"MDG"` |             |
| `"MDV"` |             |
| `"MEX"` |             |
| `"MHL"` |             |
| `"MKD"` |             |
| `"MLI"` |             |
| `"MLT"` |             |
| `"MMR"` |             |
| `"MNE"` |             |
| `"MNG"` |             |
| `"MNP"` |             |
| `"MOZ"` |             |
| `"MRT"` |             |
| `"MSR"` |             |
| `"MTQ"` |             |
| `"MUS"` |             |
| `"MWI"` |             |
| `"MYS"` |             |
| `"MYT"` |             |
| `"NAM"` |             |
| `"NCL"` |             |
| `"NER"` |             |
| `"NFK"` |             |
| `"NGA"` |             |
| `"NIC"` |             |
| `"NIU"` |             |
| `"NLD"` |             |
| `"NOR"` |             |
| `"NPL"` |             |
| `"NRU"` |             |
| `"NZL"` |             |
| `"OMN"` |             |
| `"PAK"` |             |
| `"PAN"` |             |
| `"PCN"` |             |
| `"PER"` |             |
| `"PHL"` |             |
| `"PLW"` |             |
| `"PNG"` |             |
| `"POL"` |             |
| `"PRI"` |             |
| `"PRK"` |             |
| `"PRT"` |             |
| `"PRY"` |             |
| `"PSE"` |             |
| `"PYF"` |             |
| `"QAT"` |             |
| `"REU"` |             |
| `"ROU"` |             |
| `"RUS"` |             |
| `"RWA"` |             |
| `"SAU"` |             |
| `"SDN"` |             |
| `"SEN"` |             |
| `"SGP"` |             |
| `"SGS"` |             |
| `"SHN"` |             |
| `"SJM"` |             |
| `"SLB"` |             |
| `"SLE"` |             |
| `"SLV"` |             |
| `"SMR"` |             |
| `"SOM"` |             |
| `"SPM"` |             |
| `"SRB"` |             |
| `"STP"` |             |
| `"SUR"` |             |
| `"SVK"` |             |
| `"SVN"` |             |
| `"SWE"` |             |
| `"SWZ"` |             |
| `"SYC"` |             |
| `"SYR"` |             |
| `"TCA"` |             |
| `"TCD"` |             |
| `"TGO"` |             |
| `"THA"` |             |
| `"TJK"` |             |
| `"TKL"` |             |
| `"TKM"` |             |
| `"TLS"` |             |
| `"TON"` |             |
| `"TTO"` |             |
| `"TUN"` |             |
| `"TUR"` |             |
| `"TUV"` |             |
| `"TWN"` |             |
| `"TZA"` |             |
| `"UGA"` |             |
| `"UKR"` |             |
| `"UMI"` |             |
| `"URY"` |             |
| `"USA"` |             |
| `"UZB"` |             |
| `"VAT"` |             |
| `"VCT"` |             |
| `"VEN"` |             |
| `"VGB"` |             |
| `"VIR"` |             |
| `"VNM"` |             |
| `"VUT"` |             |
| `"WLF"` |             |
| `"WSM"` |             |
| `"YEM"` |             |
| `"ZAF"` |             |
| `"ZMB"` |             |
| `"ZWE"` |             |
