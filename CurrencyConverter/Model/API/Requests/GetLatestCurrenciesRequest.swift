//
//  GetLatestCurrenciesRequest.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 17/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import Foundation

class GetLatestCurrenciesRequest: Request {
   
   // MARK: - Initializers

   /**
   Latest currency rate request used to get the rates for the allowed currencied compared to the base currency
   - parameters:
     -  baseCurrency: the currency that will be used as a comparison
     -  allowedCurrencies: the currencies that we need to get the exchange rates for
   */
   init(baseCurrency: String, allowedCurrencies: [String]) {
      let parameters: [String: String] = [
         "base": baseCurrency,
         "symbols": allowedCurrencies.filter({$0 != baseCurrency}).joined(separator: ",")
      ]
      super.init(action: "latest", parameters: parameters, requestType: .get)
   }
   
}
