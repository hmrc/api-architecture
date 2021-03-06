# CGT Draft API Design - WIP


##Assumptions
1. Record each disposal individually

##Issues
1. How to deal with property disposal submissions from PPD service?


##Thoughts
1. Reuse Losses API?
2. Adjustments API?
3. How to minimise breaking changes of items with high volatility?  e.g. specific tax year rules

## URI/Methods

- /income-received/disposals/property/{nino}/{taxYear}  GET | PUT | DELETE
- /income-received/disposals/sharesAndSecurities/{nino}/{taxYear} GET | PUT | DELETE
- /income-received/disposals/other/{nino}/{taxYear} GET | PUT | DELETE



###Categorisations from SA 108

- "residentialProperty"
-  "other"
-  "listedSharesAndSecurities"
-  "unlistedSharesAndSecurities"
-  "lossesAndAdjustments"


##Draft JSON request body/bodies

Broadly based on domain modelling spreadsheet and categorised according to SA108 schedule

###n.b.
 removed below as this can be derived:
```
"property": {
    "numberOfDisposals": 
} 
"sharesAndSecurities": { 
    "numberOfDisposals": 
}
```

---

```json
{
  "residentialProperty": [
    {
    "disposalProceeds":,
    "allowableCostsIncludingPurchasePrice":,
    "gainsInTheYearBeforeLossesDoNotIncludeAnyGainsSubjectToNon-ResidentCapitalGainsTax":,
    "lossesInTheYearDoNotIncludeAnyLossesIncurredOnTheDisposalOfAPropertySubjectToNon-ResidentCapitalGainsTax":,
    "ifYouAreMakingAnyClaimOrElectionPutTheRelevantCodeInTheBox":,
    "ifyouarechargeabletonon-ResidentCapitalGainsTaxForTheDisposalOfAUkResidentialPropertyOrPropertiesDuring2018-19PutTheTotalGainChargeableToNon-ResidentCapitalGainsTaxAfterLosses,OrLoss,InTheBox":,
    "taxOnGainsInCgt.009AlreadyCharged":,
    "ifDuringTheYearYouSubmittedRealTimeTransactionReturnsForTheDisposalOfAResidentialPropertyOrPropertiesPutTheOverallGainOrLossInTheBox":,
    "taxOnGainsInCgt.011AlreadyCharged":,
    "carriedInterest":
     }
  ],

  "other": [
     {
    "disposalProceeds":,
    "allowableCosts(IncludingPurchasePrice)":,
    "gainsInTheYearBeforeLosses":,
    "attributedGainsWherePersonalLossesCannotBeSetOff":,
    "lossesInTheYear":,
    "ifYouAreMakingAnyClaimOrElectionPutTheRelevantCodeInTheBox":,
    "ifDuring2018-19YouSubmittedRealTimeTransactionReturnsForTheDisposalOfAnAssetOfThisTypePutTheOverallGainOrLossInTheBoxIncludeTheIndividualAmountsOfGainsInCgt.017AndLossesInCgt019":,
    "taxOnGainsInBox21AlreadyCharged":
    }
  ]

  "listedSharesAndSecurities": [
    {
    "typeOfAsset": ,
    "disposalProceeds": ,
    "allowableCosts(IncludingPurchasePrice)": ,
    "gainsInTheYearBeforeLosses": ,
    "lossesInTheYear": ,
    "ifYouAreMakingAnyClaimOrElection,PutTheRelevantCodeInTheBox": ,
    "ifDuring2018-19YouSubmittedRealTimeTransactionReturnsForTheDisposalOfListedSharesOrSecuritiesPutTheOverallGainOrLossInTheBoxIncludeTheIndividua": , lAmountsOfGainsInCgt.026AndLossesInCgt.027
    "taxOnGainsInCgt.029AlreadyCharged":
     }
   ],

   "unlistedSharesAndSecurities": [
     {
    "disposalProceeds": ,
    "allowableCosts(IncludingPurchasePrice)": ,
    "gainsInTheYearBeforeLosses": ,
    "lossesInTheYear": ,
    "ifYouAreMakingAnyClaimOrElection,PutTheRelevantCodeInTheBox": ,
    "ifDuring2018-19YouSubmittedRealTimeTransactionReturnsForTheDisposalOfUnlistedSharesOrSecuritiesPutTheOverallGainOrLossInTheBoxIncludeTheIndivid": ,ualAmountsOfGainsInCgt.034AndLossesInCgt.035
    "taxOnGainsIn0.37AlreadyCharged": ,
    "gainsExceedingTheLifetimeLimitForEmployeeShareholderStatusShares": ,
    "gainsInvestedUnderSeedEnterpriseInvestmentSchemeAndQualifyingForRelief": ,
    "lossesUsedAgainstIncome": ,
    "amountInCgt041RelatingToShareLossReliefIn2018-19ToWhichEnterpriseInvestmentSchemeOrSeedEnterpriseInvestmentSchemeReliefIsAttributable": ,
    "amountInCgt043RelatingToShareLossReliefIn2017-18ToWhichEnterpriseInvestmentSchemeOrSeedEnterpriseInvestmentSchemeReliefIsAttributable": ,
    "nameOfCompanySharesHaveBeenDisposedIn": ,  // can't see in form - new?
    "gainsQualifyingForEntrepreneursRelief-GainsBefore23June2010": ,
    "gainsQualifyingForEntrepreneursRelief-GainsOnOrAfter23June2010":
    },
  ],

  "adjustments": {
    "adjustmentsToCapitalGainsTax": ,
    "additionalliabilityfornon-ResidentOrDualResidentTrusts":
    },

  "losses": {
    "lossesUsedAgainstIncome-AmountClaimedAgainst2017-18Income": ,
    "lossesBroughtForwardAndUsedIn-Year": ,
    "incomeLossesOf2018-19SetAgainstGains": ,
    "lossesAvailableToBeCarriedForward": ,
    "lossesUsedAgainstAnEarlierYearSGain": ,
    "totalOfThisYearsLosses": ,
    "usedAgainstGains": ,
    "currentYearLossesTransferredToBeneficiariesDuringTheYearAndCurrentYearLossesCarriedBack": ,
    "currentYearLossesCarriedForward": ,
    "unusedLossesOf1996-97AndLaterYears": ,
    "usedThisYear(BoxAboveIsPriorityOfTheOneBelow)": ,
    "unusedLossesOf1995-96AndEarlierYears": ,
    "remainingUnusedLossesOf1996-97AndLaterYears": ,
    "totalCarriedForwardLossesOf1996-97AndLaterYears": ,
    "totalcarriedforwardlossesof1995-96AndEarlierYears":
    },

   
    // Where are these in SA108?
    "forDirectDisposalsOfNon-ResidentialUkPropertiesOrLandOrIndirectDisposalsOfAnyUkPropertiesOrLandPutTheTotalGainsChargeableToNrcgtInTheBox": ,
    "ifAnyOfTheGainsInCgt.053.2AreFromIndirectDisposalsPutXInTheBox": ,
    "taxOnGainsInCgt.53.1And53.2AlreadyPaid": ,
    "totalLossesAvailableAgainstNrcgtGainsForTheYear": ,
    "annualExemptAmount": ,
    "taxableGains": ,
    "claimToSpecialCapitalGainsTaxTreatmentWhereAVulnerableBeneficiaryElectionHasEffectAmountOfReliefClaimed": ,
    "totalTaxableGains": ,
    "lossesBroughtForwardAndUsedInYear": ,
    "incomeLossesSetAgainstGains": ,
    "dateOfDisposal/Sale": ,
    "amountOfDisposalProceedsOrMarketValue IfAppropriate": ,
    "isTheAmountInCgt.076ActualOrMarketValue": ,
    "incidentalCostsOfDisposalAmountOfIncidentalCostsOfDisposal": ,
    "netDisposalProceeds(Sum)": ,
    "dateOfAcquisition": ,
    "costOr31March1982Value": ,
    "purchasePrice": ,
    "amountOfAllowableIncidentalCosts(ExcludingPurchasePrice)AmountOfIncidentalCostsOfAcquisition(ExcludingAcquisitionCost)": ,
    "improvementCostsAmountOfOtherAllowableExpenditure(E.G.IncludesImprovementAndOtherAllowableCosts": ,
    "amountOfGainOrLoss(Sum)": ,
    "amountOfCgElectionsOrReliefs(NotTheAnnualExemptionReliefOrEntrepreneursRelief)AmountOfGainOrLossAfterTheApplicationOfTheElectionOrRelief": ,
    "codeForCgElectionsOrReliefs": ,
    "categoryOfDisposal": ,
    "howMuchOfTheGainQualifiesForInvestorsRelief": ,
    "datePost-TransactionalValuationProvided": ,
    "amountOfPost-TransactionalValuationProvided": ,
    "addsOfPropertyDisposedOf": ,
    "doesCalculationIncludeAnyEstimatesOrValuations": ,
    "dateOfCompletion/Conveyance": ,
    "dateOfPre-TransactionRuling": ,
    "referenceOfPre-TransactionRuling": ,
    "howMuchOfThePropertyDoYouOwn": ,
    "haveYouIncludedAnyEstimatedFiguresInYourCgtCalculation": ,
    "howDidYouObtainThisProperty": ,
    "countryCode": ,
    "nameOfAvoidanceSchemeUsed": ,
    "dotasReferenceNumber":

}
```


