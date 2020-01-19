//
//  CurrencyListRateView.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 18/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import UIKit

protocol CurrencyListRateViewDelegate: class {
   func didToggleSelectedStatus()
}

class CurrencyListRateView: UIView {
   
   @IBOutlet private weak var currencyLabel: UILabel!
   @IBOutlet private weak var rateLabel: UILabel!
   
   private weak var delegate: CurrencyListRateViewDelegate?
   
   var isSelected: Bool = false {
      didSet {
         if isSelected {
            backgroundColor = .blue
            currencyLabel.textColor = .white
            rateLabel.textColor = .white
         } else {
            backgroundColor = .clear
            currencyLabel.textColor = .black
            rateLabel.textColor = .black
         }
         delegate?.didToggleSelectedStatus()
      }
   }
   
   var currency: String?
   
   // MARK: - Static

   static func loadFromNib(currency: String, value: String, delegate: CurrencyListRateViewDelegate) -> CurrencyListRateView {
      let view = UINib(nibName: String(describing: CurrencyListRateView.self), bundle: nil).instantiate(withOwner: self, options: nil).first as! CurrencyListRateView
      view.setupUI(currency: currency, value: value)
      view.delegate = delegate
      view.currency = currency
      let gestureRecogniser = UITapGestureRecognizer(target: view, action: #selector(didSelectCurrencyRateView))
      view.addGestureRecognizer(gestureRecogniser)
      return view
   }
   
   // MARK: - Private

   private func setupUI(currency: String, value: String) {
      currencyLabel.text = currency
      rateLabel.text = value
   }
   
   @objc private func didSelectCurrencyRateView() {
      isSelected = !isSelected
   }
}
