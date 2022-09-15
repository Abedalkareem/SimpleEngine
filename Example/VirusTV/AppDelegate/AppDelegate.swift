//
//  AppDelegate.swift
//  VirusTV
//
//  Created by abedalkareem omreyh on 19/09/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import SimpleEngine
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    setupAnalogViewSettings()

    SimpleMusicPlayer.shared.backgroundAudioPlayerVolume = 0.9

    return true
  }

  private func setupAnalogViewSettings() {
    AnalogView.Settings.analogImage = #imageLiteral(resourceName: "controller_analog")
    AnalogView.Settings.backgroundImage = #imageLiteral(resourceName: "controller_background")
    AnalogView.Settings.alpha = 0.9
    AnalogView.Settings.analogSize = 100
    AnalogView.Settings.margen = 25
  }

  func applicationWillResignActive(_ application: UIApplication) { }

  func applicationDidEnterBackground(_ application: UIApplication) { }

  func applicationWillEnterForeground(_ application: UIApplication) { }

  func applicationDidBecomeActive(_ application: UIApplication) { }

}
