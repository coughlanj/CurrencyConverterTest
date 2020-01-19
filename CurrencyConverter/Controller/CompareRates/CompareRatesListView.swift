//
//  CompareRatesListView.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 19/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import UIKit

class CompareRatesListView: UIView {
   
   @IBOutlet private weak var titleLabel: UILabel!
   @IBOutlet private weak var valueStackView: UIStackView!
   
   // MARK: - Static

   static func loadFromNib() -> CompareRatesListView {
      let view = UINib(nibName: String(describing: CompareRatesListView.self), bundle: nil).instantiate(withOwner: self, options: nil).first as! CompareRatesListView
      return view
   }
   
   // MARK: - Public

   override func awakeFromNib() {
      super.awakeFromNib()
      valueStackView.distribution = .fillEqually
   }
   
   func configure(title: String, values: [String], isHeader: Bool) {
      titleLabel.text = title
      let font = isHeader ? UIFont.systemFont(ofSize: 16, weight: .semibold) : UIFont.systemFont(ofSize: 12, weight: .regular)
      titleLabel.font = font
      values.forEach({ addValueView(text: $0, font: font) })
   }
   
   // MARK: - Private

   private func addValueView(text: String, font: UIFont) {
      let label = UILabel(frame: .zero)
      label.text = text
      label.font = font      
      label.translatesAutoresizingMaskIntoConstraints = false
      valueStackView.addArrangedSubview(label)
   }
}
