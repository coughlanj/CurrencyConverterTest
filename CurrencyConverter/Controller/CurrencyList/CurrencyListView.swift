//
//  CurrencyListView.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 17/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import UIKit

protocol CurrencyListViewDelegate: class {
   
   func didPressCompareButton(currencies: [String], amount: Double)
   
}

class CurrencyListView: UIView {
   
   @IBOutlet private weak var stackView: UIStackView!
   @IBOutlet private weak var compareButton: UIButton!
   @IBOutlet private weak var ratesLabel: UILabel!
   
   private weak var delegate: CurrencyListViewDelegate?
   
   private var amount: Double?
   private var viewModel: CurrencyListViewModel?
   
   // MARK: - Static

   static func loadFromNib(delegate: CurrencyListViewDelegate) -> CurrencyListView {
      let view = UINib(nibName: String(describing: CurrencyListView.self), bundle: nil).instantiate(withOwner: self, options: nil).first as! CurrencyListView
      view.setupUI()
      view.delegate = delegate
      return view
   }
   
   // MARK: - Public
   
   func updateViewModel(_ viewModel: CurrencyListViewModel?) {
      
      self.viewModel = viewModel
      reload()
   }
   
   func updateAmount(_ amount: Double?) {
      self.amount = amount
      reload()
   }
   
   func invalidate() {
      viewModel = nil
      compareButton.isHidden = true
      stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
      
      for _ in 0..<10 {
         addSkeletonView()
      }
      
      ratesLabel.isHidden = false
   }
   
   // MARK: - Private

   private func reload() {
      stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
      
      if let amount = amount, let viewModel = viewModel {
         viewModel.currencyItems.forEach {
            addCurrencyRateView(currency: $0.key, value: viewModel.calculatedAmountForCurrency($0.key, amount: amount))
         }
      }
      
      ratesLabel.isHidden = stackView.arrangedSubviews.count == 0
   }

   private func setupUI() {
      backgroundColor = .clear
      updateCompareButton()
   }
   
   private func addCurrencyRateView(currency: String, value: String) {
      let view = CurrencyListRateView.loadFromNib(currency: currency, value: value, delegate: self)
      view.translatesAutoresizingMaskIntoConstraints = false
      stackView.addArrangedSubview(view)
      view.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
   }
   
   private func addSkeletonView() {
      let view = AnimatedSkeletonView(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 30))
      view.translatesAutoresizingMaskIntoConstraints = false
      stackView.addArrangedSubview(view)
      view.heightAnchor.constraint(equalToConstant: 30).isActive = true
      view.layer.cornerRadius = 3
      view.layer.masksToBounds = true
      view.startAnimation()
   }
   
   private func updateCompareButton() {
      let canCompare = stackView.arrangedSubviews.compactMap({ $0 as? CurrencyListRateView }).filter({ $0.isSelected }).count >= 2
      compareButton.isHidden = !canCompare
   }
   
   @IBAction private func compareButtonPressed(_ sender: UIButton) {
      if let amount = amount {
         let currencies = stackView.arrangedSubviews.compactMap({ $0 as? CurrencyListRateView }).filter({ $0.isSelected }).compactMap({ $0.currency })
         delegate?.didPressCompareButton(currencies: currencies, amount: amount)
      }
   }
   
}

extension CurrencyListView: CurrencyListRateViewDelegate {
   
   func didToggleSelectedStatus() {
      updateCompareButton()
   }
   
}
