//
//  CurrencyConverterCompareRatesViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by James Coughlan on 19/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterCompareRatesViewModelTests: XCTestCase {
   
   var viewModel: CompareRatesViewModel?
   
   let currencies = ["GBP", "AUD"]
   let dayOneRates = ["GBP": 0.90, "AUD": 1.50]
   let dayTwoRates = ["GBP": 0.80, "AUD": 1.40]
   let amount = 10.00
   let baseCurrency = "EUR"
   
   override func setUp() {
      super.setUp()
      
      let dayOneModel = CurrencyResponse(base: baseCurrency, date: "2020-01-02", rates: dayOneRates, success: true, timestamp: 10001)
      let dayTwoModel = CurrencyResponse(base: baseCurrency, date: "2020-01-01", rates: dayTwoRates, success: true, timestamp: 10001)
      
      viewModel = CompareRatesViewModel(models: [dayOneModel, dayTwoModel], currencies: currencies, baseCurrency: baseCurrency, amount: amount)
   }
   
   func testDateSortingAndFormatting() {
      XCTAssertNotNil(viewModel, "ViewModel is nil")
      
      if let viewModel = viewModel {
         XCTAssertTrue(viewModel.compareRateItems[0].title == "01 Jan", "date at index 0 is incorrect")
         XCTAssertTrue(viewModel.compareRateItems[1].title == "02 Jan", "date at index 1 is incorrect")
      }
   }
   
   func testCurrencySorting() {
      XCTAssertNotNil(viewModel, "ViewModel is nil")
      
      if let viewModel = viewModel {
         XCTAssertTrue(viewModel.currencies[0] == "AUD", "currency at index 0 is incorrect")
         XCTAssertTrue(viewModel.currencies[1] == "GBP", "currency at index 1 is incorrect")
      }
   }
   
   func testOrderedFormattedCalculatedAmounts() {
      XCTAssertNotNil(viewModel, "ViewModel is nil")
      
      if let viewModel = viewModel {
         let dayOne = viewModel.compareRateItems[1]
         let dayTwo = viewModel.compareRateItems[0]
         XCTAssertTrue(dayOne.values == ["15.000", "9.000"], "dayOne values are incorrect")
         XCTAssertTrue(dayTwo.values == ["14.000", "8.000"], "dayTwo values are incorrect")
      }
   }
}
