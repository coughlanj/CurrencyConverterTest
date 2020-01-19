//
//  HomeManager.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 17/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import UIKit

class HomeManager {
   
   private let navigationController: UINavigationController
   private let settings: Settings
   private let apiController: CurrencyConversionAPIController
   
   // MARK: - Initializers

   init(settings: Settings, navigationController: UINavigationController) {
      self.settings = settings
      self.navigationController = navigationController
      navigationController.setNavigationBarHidden(true, animated: false)
      apiController = CurrencyConversionAPIController(networkSettings: settings.network)
   }
   
   // MARK: - Navigation

   func start() {
      let viewController = HomeViewController(baseCurrency: settings.currency.baseCurrency, delegate: self)
      navigationController.pushViewController(viewController, animated: true)
      updateRates(viewController: viewController)
   }
   
   private func presentCompareRatesView(currencies: [String], amount: Double, viewController: HomeViewController) {
      let title = "\(amount.toString(decimalPlaces: 2)) \(settings.currency.baseCurrency)"
      let compareRatesViewController = CompareRatesViewController(title: title)
      viewController.present(compareRatesViewController, animated: true, completion: nil)
      
      fetchCompareRates(currencies: currencies) { models in
         let viewModel = CompareRatesViewModel(models: models, currencies: currencies,    baseCurrency: self.settings.currency.baseCurrency, amount: amount)
         compareRatesViewController.update(viewModel: viewModel)
      }
   }
   
   private func updateRates(viewController: HomeViewController) {
      fetchLatestRates(currency: settings.currency.baseCurrency) { model in
         let viewModel = CurrencyListViewModel(model: model, selectedCurrency: model.base)
         viewController.updateList(viewModel: viewModel)
      }
   }
   
   // MARK: - Dialog

   private func presentError(_ message: String?) {
      let alert = UIAlertController(title: "Alert", message: message ?? "Unknown error", preferredStyle: UIAlertController.Style.alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
      navigationController.present(alert, animated: true, completion: nil)
   }
   
   // MARK: - API

   /**
    Fetch the rates selected in the list view to compare against each other based on the baseCurrency and the amount imputed in the selection screen
    Note: This logic should be replaced with the 'timeseries' endpoint when upgrading from a basic plan
    */
   private func fetchCompareRates(currencies: [String], onCompletion: @escaping ([CurrencyResponse]) -> Void) {
      /* A little clunky, but seeing as the time-series endpoint isn't available for free users, we can access historical data with 5 seperate calls to the 'historical' endpoint */
      let group = DispatchGroup()
      var models: [CurrencyResponse] = []
      for days in (0..<5) {
         group.enter()
         apiController.getHistoricalCurrencyConversion(baseCurrency: settings.currency.baseCurrency, selectedCurrencies: currencies, daysAgo: days) { model, error in
            if let model = model {
               models.append(model)
            } else {
               self.presentError(error)
            }
            group.leave()
         }
      }
      group.notify(queue: .main) {
         onCompletion(models)
      }
   }
   
   /**
   Fetch the latest rates based on the base currency
   Note: basic API plan currenctly only allows EUR
   */
   private func fetchLatestRates(currency: String, onCompletion: @escaping (CurrencyResponse) -> Void) {
      apiController.getLatestCurrencyConversion(baseCurrency: currency, allowedCurrencies: self.settings.currency.currencies) { model, error in
         if let model = model {
            onCompletion(model)
         } else {
            self.presentError(error)
         }
      }
      
   }
}

extension HomeManager: HomeViewControllerDelegate {
   
   func didPressCompareButton(currencies: [String], amount: Double, viewController: HomeViewController) {
      presentCompareRatesView(currencies: currencies, amount: amount, viewController: viewController)
   }
   
   func didPressRefreshButton(viewController: HomeViewController) {
      updateRates(viewController: viewController)
   }

}
