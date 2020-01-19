//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 17/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
   var window: UIWindow?
   var homeManager: HomeManager?
   
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      startFlow()
      return true
   }
   
   // MARK: - Private
   
   /**
   Pull in the settings from the info.Plist and start the home manager
   This app avoids usage of storyboards in order to provide modular views that can be easily moved/removed
   */
   private func startFlow() {
      let window = UIWindow(frame: UIScreen.main.bounds)
      let rootViewController = UINavigationController()
      window.rootViewController = rootViewController
      window.makeKeyAndVisible()
      if let settings = Settings.fromPlist() {
         homeManager = HomeManager(settings: settings, navigationController: rootViewController)
         homeManager?.start()
         self.window = window
      }
   }
   
}

