//
//  UserDefaultsHelper.swift
//  Virus
//
//  Created by abedalkareem omreyh on 6/27/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class UserDefaultsHelper {

  class var isSoundOff: Bool {
    get {
      return UserDefaults.standard.bool(forKey: "sound")
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: "sound")
    }
  }

  class var lives: Int {
    get {
      return UserDefaults.standard.integer(forKey: "lives")
    }
    set {
      if newValue < 0 {
        assertionFailure()
        return
      }
      UserDefaults.standard.set(newValue, forKey: "lives")
    }
  }

}
