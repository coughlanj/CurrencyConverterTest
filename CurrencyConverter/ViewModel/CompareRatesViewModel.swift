//
//  CompateRatesViewModel.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 19/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import Foundation

struct CompareRatesViewModel {
   
   let compareRateItems: [(title: String, values: [String])]
   let currencies: [String]
   let baseCurrency: String
   
   // MARK: - Initializers

   init(models: [CurrencyResponse], currencies: [String], baseCurrency: String, amount: Double) {
      let orderedModels = models.sorted { (first, second) -> Bool in
         return first.date < second.date
      }
      
      compareRateItems = orderedModels.map({
         let sortedRates = $0.sortedRates
         let formattedDate = DateFormatHelper.stringToFormattedString(dateString: $0.date, inFormat: .api, outFormat: .display) ?? $0.date
         return (formattedDate, sortedRates.map({ ($0.value * amount).toString(decimalPlaces: 3) }))
      })
      
      self.currencies = currencies.sorted()
      self.baseCurrency = baseCurrency
   }
}
