//
//  SettingsTest.swift
//  CurrencyConverterTests
//
//  Created by James Coughlan on 19/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterSettingsTests: XCTestCase {
   
   func testSettingsParsedCorrectly() {
      let settings = Settings.fromPlist()
      XCTAssertNotNil(settings, "Settings is nil")
      if let settings = settings {
         XCTAssertFalse(settings.network.accessKey.isEmpty, "Access key is empty")
         XCTAssertFalse(settings.network.baseURL.isEmpty, "base url is empty")
         XCTAssertFalse(settings.currency.baseCurrency.isEmpty, "base currency is empty")
         XCTAssertFalse(settings.currency.currencies.isEmpty, "currencies array is empty")
      }
   }
   
}
