//
//  Settings.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 17/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import Foundation

struct NetworkSettings: Decodable {
   
   let accessKey: String
   let baseURL: String
   
}

struct CurrencySettings: Decodable {
   
   let baseCurrency: String
   let currencies: [String]
   
}

struct Settings: Decodable {
   
   let network: NetworkSettings
   let currency: CurrencySettings

   /**
   Settings in the app are pulled in from the info.plist in order to allow for addition of fastlane and/or jenkins to control app/environment settings
   */
   static func fromPlist() -> Settings? {
      guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
         let plistDict = NSDictionary(contentsOfFile: path), let settingsDict = plistDict["Settings"] as? [String: Any], let model = settingsDict.toDecodableModel(Settings.self) else {
            return nil
      }
      return model
   }
   
}
