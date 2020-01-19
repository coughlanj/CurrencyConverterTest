//
//  CurrencyConversionAPIInteractor.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 17/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import Foundation

typealias CurrencyAPICompletion = (CurrencyResponse?, String?) -> Void

struct CurrencyConversionAPIController {
   
   let networkSettings: NetworkSettings
   
   // MARK: - Initializers

   init(networkSettings: NetworkSettings) {
      self.networkSettings = networkSettings
   }
   
   // MARK: - Public

   func getLatestCurrencyConversion(baseCurrency: String, allowedCurrencies: [String], onCompletion: @escaping CurrencyAPICompletion) {
      let request = GetLatestCurrenciesRequest(baseCurrency: baseCurrency, allowedCurrencies: allowedCurrencies)
      execute(request: request, onCompletion: onCompletion)
   }
   
   func getHistoricalCurrencyConversion(baseCurrency: String, selectedCurrencies: [String], daysAgo: Int, onCompletion: @escaping CurrencyAPICompletion) {
      let request = GetHistoricalCurrencyConversion(baseCurrency: baseCurrency, selectedCurrencies: selectedCurrencies, daysAgo: daysAgo)
      execute(request: request, onCompletion: onCompletion)
   }
   
   // MARK: - Private
   
   /**
   Creates an API session and executes the request. The callback will then attempt to parse the data into a CurrencyResponse model
   - parameters:
     -  onCompletion: callback which will return either a valid CurrencyResponse model or an error
   */
   private func execute(request: Request, onCompletion: @escaping CurrencyAPICompletion) {
      let apiSession = APISession(request: request, networkSettings: networkSettings)
      apiSession.execute { response, error in
         if let response = response, let dict = response as? [String: Any], let model = dict.toDecodableModel(CurrencyResponse.self){
            onCompletion(model, nil)
         } else {
            onCompletion(nil, error ?? "UNKNOWN ERROR")
         }
      }
   }
}
