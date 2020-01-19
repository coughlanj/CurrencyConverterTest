//
//  CompareRatesViewController.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 19/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import UIKit

class CompareRatesViewController: UIViewController {
   
   @IBOutlet private weak var titleLabel: UILabel!
   @IBOutlet private weak var stackView: UIStackView!
   
   private let titleText: String
   
   // MARK: - Initializers
   
   init(title: String) {
      titleText = title
      super.init(nibName: "CompareRatesView", bundle: nil)
   }
   
   required init?(coder aDecoder: NSCoder) {
      return nil
   }
   
   // MARK: - Public
   
   override func viewDidLoad() {
      super.viewDidLoad()
      titleLabel.text = titleText
      stackView.spacing = 8
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      if stackView.arrangedSubviews.isEmpty {
         for _ in 0..<5 {
            addSkeletonView()
         }
      }
   }
   
   
   func update(viewModel: CompareRatesViewModel) {
      stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
      
      //add header
      addCompareRateListView(title: "Date", values: viewModel.currencies, isHeader: true)
      
      //add rows
      for item in viewModel.compareRateItems {
         addCompareRateListView(title: item.title, values: item.values, isHeader: false)
      }
   }
   
   // MARK: - Private
   
   private func addCompareRateListView(title: String, values: [String], isHeader: Bool) {
      let compareRateListView = CompareRatesListView.loadFromNib()
      compareRateListView.translatesAutoresizingMaskIntoConstraints = false
      compareRateListView.configure(title: title, values: values, isHeader: isHeader)
      stackView.addArrangedSubview(compareRateListView)
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
   
   @IBAction private func didPressDismiss(_ sender: Any) {
      dismiss(animated: true, completion: nil)
   }
   
}
