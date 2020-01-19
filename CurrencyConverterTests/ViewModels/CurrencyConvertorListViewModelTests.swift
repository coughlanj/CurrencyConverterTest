//
//  CurrencyConverterListViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by James Coughlan on 19/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterListViewModelTests: XCTestCase {

   var viewModel: CurrencyListViewModel?
   
   let rates = ["GBP": 0.90, "AUD": 1.50]
   let amount = 10.00
   let baseCurrency = "EUR"
   
   override func setUp() {
      super.setUp()
      let model = CurrencyResponse(base: baseCurrency, date: "2020-01-01", rates: rates, success: true, timestamp: 10001)
      viewModel = CurrencyListViewModel(model: model, selectedCurrency: baseCurrency)
   }
   
   func testFormattedCalculatedAmounts() {
      XCTAssertNotNil(viewModel, "viewModel is nil")
      
      if let viewModel = viewModel {
         let gbpRate = viewModel.calculatedAmountForCurrency("GBP", amount: amount)
         XCTAssertNotNil(gbpRate)
         XCTAssertTrue(gbpRate == "9.000", "GBP rate is incorrect")

         let audRate = viewModel.calculatedAmountForCurrency("AUD", amount: amount)
         XCTAssertNotNil(audRate)
         XCTAssertTrue(audRate == "15.000", "AUD rate is incorrect")
      }
   }
}
