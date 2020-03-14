//
//  Status.swift
//  Virus
//
//  Created by abedalkareem omreyh on 08/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class Status {

  ///
  /// Return the current level.
  ///
  static var currentLevel: Int {
    get {
      return UserDefaults.standard.integer(forKey: "currentLevel")
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "currentLevel")
    }
  }

  ///
  /// Return current level view controller.
  ///
  static func currentLevelViewController() -> UIViewController {
    let type: UIViewController.Type?
    let storyboard: Storyboard!
    
    switch currentLevel {
    case 0:
      type = GameViewController.self
      storyboard = .main
    default:
      type = GameViewController.self
      storyboard = .main
    }
    
    return UIStoryboard.create(storyboard: storyboard, controller: type!)
  }
  
}
