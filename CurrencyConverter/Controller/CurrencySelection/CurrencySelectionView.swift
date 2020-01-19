//
//  CurrencySelectionView.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 17/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import UIKit

protocol CurrencySelectionViewDelegate: class {
   func didSelectAmount(_  amount: Double?)
   func didPressRefreshButton()
}

class CurrencySelectionView: UIView {
   
   @IBOutlet private weak var textField: UITextField!
   @IBOutlet private weak var currencyLabel: UILabel!
   @IBOutlet private weak var refreshButton: UIButton!
      
   private var amount: Double?
   private weak var delegate: CurrencySelectionViewDelegate?
   private var baseCurrency: String?
   
   // MARK: - Static

   static func loadFromNib(baseCurrency: String, delegate: CurrencySelectionViewDelegate) -> CurrencySelectionView {
      let view = UINib(nibName: String(describing: CurrencySelectionView.self), bundle: nil).instantiate(withOwner: self, options: nil).first as! CurrencySelectionView
      view.baseCurrency = baseCurrency
      view.delegate = delegate
      view.setupUI()
      return view
   }
   
   // MARK: - Public
   
   func enableRefreshButton(_ enabled: Bool) {
      refreshButton.backgroundColor = enabled ? .blue : .lightGray
      refreshButton.setTitleColor( enabled ? .white : .gray, for: .normal)
      refreshButton.isUserInteractionEnabled = enabled
   }

   // MARK: - Private

   private func setupUI() {
      backgroundColor = .clear
      
      //Text Field
      textField.borderStyle = .none
      textField.backgroundColor = .clear
      textField.textColor = .black
      textField.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
      textField.attributedPlaceholder = NSAttributedString(string: "Enter amount", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .ultraLight)])
      textField.layer.cornerRadius = 8.0
      textField.layer.masksToBounds = true
      textField.delegate = self
      
      //Currency Label
      currencyLabel.text = baseCurrency
      currencyLabel.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
      
      //Refresh Button
      refreshButton.layer.cornerRadius = 4
      refreshButton.layer.masksToBounds = true
      enableRefreshButton(false)
   }
   
   @IBAction private func didPressRefreshButton(_ sender: Any) {
      textField.resignFirstResponder()
      enableRefreshButton(false)
      delegate?.didPressRefreshButton()
   }
   
}

extension CurrencySelectionView: UITextFieldDelegate {
   
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let currentText = textField.text ?? ""
      let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
      let isValid = replacementText.isValidDouble(maxDecimalPlaces: 2) || string.isEmpty
      
      if isValid {
         delegate?.didSelectAmount(Double(replacementText))
      }
      
      return isValid
   }
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return false
   }
}
