//
//  CurrencyResponse.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 17/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import Foundation

struct CurrencyResponse: Decodable {
   let base: String
   let date: String
   let rates: [String: Double]
   let success: Bool
   let timestamp: Int
   
   var sortedRates: [(key: String, value: Double)] {
      return rates.sorted { (first, second) -> Bool in
         return first.key < second.key
      }
   }
}
