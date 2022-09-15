//
//  Status.swift
//  Virus
//
//  Created by abedalkareem omreyh on 08/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

enum Status {

  ///
  /// Return the current level.
  ///
  static var currentLevel: Int {
    get {
      UserDefaults.standard.integer(forKey: "currentLevel")
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "currentLevel")
    }
  }

  static var isGameEnd: Bool {
    currentLevel == 8
  }
}
