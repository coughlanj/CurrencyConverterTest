//
//  AnimatedSkeletonView.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 18/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import UIKit

class AnimatedSkeletonView: UIView {
   
   private var gradientLayer: CAGradientLayer? = nil
   
   // MARK: - Public

   /**
    Begin animation on the skeleton view
    - parameters:
      - startLocations: The start location for the animation, in the case the leftmost centre point of the view
      - endLocations: The end location for the animation, in the case the rightmost centre point of the view
      - movingAnimationDuration: The length of the animation between the start and end locations
      - delayBetweenAnimationLoops: The delay of the animation between movements
      - backgroundColor: The static background color
      - animationColor: The color of the animation
    */
   func startAnimation(startLocations: [Float] = [-1.0, -0.5, 0.0], endLocations: [Float] = [1.0, 1.5, 2.0], movingAnimationDuration: CFTimeInterval = 0.8, delayBetweenAnimationLoops: CFTimeInterval = 0.0, backgroundColor: UIColor = UIColor.lightGray.withAlphaComponent(0.7), animationColor: UIColor = .white) {
      if gradientLayer != nil {
         stopAnimation()
      }
      
      let gradientLayer = CAGradientLayer()
      gradientLayer.startPoint = CGPoint(x: -0.1, y: 1.0)
      gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
      gradientLayer.colors = [
         backgroundColor.cgColor,
         animationColor.cgColor,
         backgroundColor.cgColor
      ]
      gradientLayer.locations = startLocations.map({ NSNumber(value: $0) })
      gradientLayer.frame = bounds
      layer.addSublayer(gradientLayer)
      
      let animation = CABasicAnimation(keyPath: "locations")
      animation.fromValue = startLocations
      animation.toValue = endLocations
      animation.duration = movingAnimationDuration
      animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
      
      let animationGroup = CAAnimationGroup()
      animationGroup.duration = movingAnimationDuration + delayBetweenAnimationLoops
      animationGroup.animations = [animation]
      animationGroup.repeatCount = .infinity
      
      gradientLayer.add(animationGroup, forKey: "locations_" + String(describing: index))
      self.gradientLayer = gradientLayer
   }
   
   func stopAnimation() {
      if let gradientLayer = gradientLayer {
         gradientLayer.removeFromSuperlayer()
         self.gradientLayer = nil
      }
   }
}
