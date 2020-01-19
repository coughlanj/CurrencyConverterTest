//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 17/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import UIKit

protocol HomeViewControllerDelegate: class {
   
   func didPressCompareButton(currencies: [String], amount: Double, viewController: HomeViewController)
   func didPressRefreshButton(viewController: HomeViewController)
   
}

class HomeViewController: UIViewController {
   
   @IBOutlet private weak var stackView: UIStackView!
   
   private let baseCurrency: String
   private weak var delegate: HomeViewControllerDelegate?
   private var listView: CurrencyListView?
   private var selectionView: CurrencySelectionView?

   // MARK: - Initializers

   init(baseCurrency: String, delegate: HomeViewControllerDelegate) {
      self.baseCurrency = baseCurrency
      self.delegate = delegate
      super.init(nibName: "HomeView", bundle: nil)
   }
   
   required init?(coder aDecoder: NSCoder) {
      return nil
   }
   
   // MARK: - Public

   override func viewDidLoad() {
      super.viewDidLoad()
      setupUI()
   }
   
   func updateList(viewModel: CurrencyListViewModel) {
      selectionView?.enableRefreshButton(true)
      listView?.updateViewModel(viewModel)
   }
   
   // MARK: - Private

   private func setupUI() {
      view.backgroundColor = .white
      setupSelectionView()
      setupListView()
   }
   
   private func setupSelectionView() {
      let currencySelectionView = CurrencySelectionView.loadFromNib(baseCurrency: baseCurrency, delegate: self)
      currencySelectionView.translatesAutoresizingMaskIntoConstraints = false
      stackView.addArrangedSubview(currencySelectionView)
      self.selectionView = currencySelectionView
   }
   
   private func setupListView() {
      let currencyListView = CurrencyListView.loadFromNib(delegate: self)
      currencyListView.translatesAutoresizingMaskIntoConstraints = false
      stackView.addArrangedSubview(currencyListView)
      self.listView = currencyListView
   }
   
}

extension HomeViewController: CurrencySelectionViewDelegate {
   
   func didSelectAmount(_  amount: Double?) {
      listView?.updateAmount(amount)
   }
   
   func didPressRefreshButton() {
      listView?.invalidate()
      delegate?.didPressRefreshButton(viewController: self)
   }
   
}

extension HomeViewController: CurrencyListViewDelegate {
   
   func didPressCompareButton(currencies: [String], amount: Double) {
      delegate?.didPressCompareButton(currencies: currencies, amount: amount, viewController: self)
   }
   
}
