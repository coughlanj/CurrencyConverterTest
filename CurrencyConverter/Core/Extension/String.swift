//
//  String.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 18/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import Foundation

extension String {
   
   /**
    - parameters:
      - maxDecimalPlaces: the max number of decimal places
    */
   func isValidDouble(maxDecimalPlaces: Int) -> Bool {
      let formatter = NumberFormatter()
      formatter.allowsFloats = true
      let decimalSeparator = formatter.decimalSeparator ?? "."
      if formatter.number(from: self) != nil {
         let split = self.components(separatedBy: decimalSeparator)
         let digits = split.count == 2 ? split.last ?? "" : ""
         return digits.count <= maxDecimalPlaces
      }
      return false
   }
   
}
