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
  
}
