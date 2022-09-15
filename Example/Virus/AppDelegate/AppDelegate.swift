//
//  AppDelegate.swift
//  Example
//
//  Created by abedalkareem omreyh on 07/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import SimpleEngine
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    setupAnalogViewSettings()

    SimpleMusicPlayer.shared.backgroundAudioPlayerVolume = 0.8

    return true
  }

  private func setupAnalogViewSettings() {
    AnalogView.Settings.analogImage = #imageLiteral(resourceName: "controller_analog")
    AnalogView.Settings.backgroundImage = #imageLiteral(resourceName: "controller_background")
    AnalogView.Settings.alpha = 0.9
    AnalogView.Settings.analogSize = 100
    AnalogView.Settings.margen = 25
  }

}
