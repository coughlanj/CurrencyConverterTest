//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by James Coughlan on 17/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterAPITests: XCTestCase {
   
   var apiController: CurrencyConversionAPIController?
   
   override func setUp() {
      super.setUp()
      let accessKey = "85f55a5b20ae47e7c6f7ca7b3bef477a"
      let baseUrl = "http://data.fixer.io/api/"
      let networkSettings = NetworkSettings(accessKey: accessKey, baseURL: baseUrl)
      apiController = CurrencyConversionAPIController(networkSettings: networkSettings)
   }
   
   func testLatestEndpoint() {
      let expectation = XCTestExpectation(description: "GET latest currencies")

      apiController?.getLatestCurrencyConversion(baseCurrency: "EUR", allowedCurrencies: ["GBP", "JPY"], onCompletion: { (response, error) in
         // Make sure we dont have an error
         XCTAssertNil(error, "error - \(error!)")
         
         // Make Sure we have parsed the correct Model
         XCTAssertNotNil(response, "CurrencyResponse is nil")
         expectation.fulfill()
      })
      
      wait(for: [expectation], timeout: 10.0)
   }
   
   func testPerformanceExample() {
      let expectation = XCTestExpectation(description: "GET historical currencies")

      apiController?.getHistoricalCurrencyConversion(baseCurrency: "EUR", selectedCurrencies: ["GBP", "JPY"], daysAgo: 2, onCompletion: { (response, error) in
         // Make sure we dont have an error
         XCTAssertNil(error, "error - \(error!)")
         
         // Make Sure we have parsed the correct Model
         XCTAssertNotNil(response, "CurrencyResponse is nil")
         expectation.fulfill()
      })
      
      wait(for: [expectation], timeout: 10.0)
   }
   
}
