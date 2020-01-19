//
//  Dictionary.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 19/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import Foundation

extension Dictionary {
   
   /**
   Helper to create a decodable model from  a dictionary
   - parameters:
     -  type: type of the desired decodabel model
   */
   func toDecodableModel<T: Decodable>(_ type: T.Type) -> T? {
      if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
         return try? JSONDecoder().decode(type, from: data)
      }
      return nil
   }
}
