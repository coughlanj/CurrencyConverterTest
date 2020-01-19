//
//  GetHistoricalCurrencyConversion.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 19/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import Foundation

class GetHistoricalCurrencyConversion: Request {
   
   // MARK: - Initializers

   /**
    Historical currency rate request used to compare selected currencies to the base currency
    - parameters:
      -  baseCurrency: the currency that will be used as a comparison
      -  selectedCurrencies: the currencies that we need to get the exchange rates for
      -  daysAgo: how far in the past we want the data for
    */
   init(baseCurrency: String, selectedCurrencies: [String], daysAgo: Int) {
      let date = Calendar.current.date(byAdding: .day, value: -daysAgo, to:  Date()) ?? Date()
      
      let parameters: [String: String] = [
         "base": baseCurrency,
         "symbols": selectedCurrencies.filter({$0 != baseCurrency}).joined(separator: ",")
      ]
      super.init(action: DateFormatHelper.dateToString(date: date, format: .api), parameters: parameters, requestType: .get)
   }
   
}
