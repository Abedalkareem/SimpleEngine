//
//  AppDelegate.swift
//  Example
//
//  Created by abedalkareem omreyh on 07/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import UIKit
import SimpleEngine

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    AnalogView.Settings.analogImage = #imageLiteral(resourceName: "controller_analog")
    AnalogView.Settings.backgroundImage = #imageLiteral(resourceName: "controller_background")

    return true
  }

}

