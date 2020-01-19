//
//  CurrencyListViewModel.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 18/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import Foundation

struct CurrencyListViewModel {
   
   let currencyItems: [(key: String, value: Double)]
   
   // MARK: - Initializers

   init(model: CurrencyResponse, selectedCurrency: String) {
      currencyItems = model.sortedRates
   }
   
   // MARK: - Public

   func calculatedAmountForCurrency(_ currency: String, amount: Double) -> String {
      if let currencyItem = currencyItems.filter({ $0.key == currency }).first {
         return (currencyItem.value * amount).toString(decimalPlaces: 3)
      }
      return ""
   }
}
