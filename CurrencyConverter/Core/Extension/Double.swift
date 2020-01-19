//
//  Double.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 19/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import Foundation

extension Double {
   
   /**
    - parameters:
      - decimalPlaces: the number of decimal places to format the string
    */
   func toString(decimalPlaces: Int) -> String {
      return String(format: "%.\(decimalPlaces)f", self)

   }
   
}
