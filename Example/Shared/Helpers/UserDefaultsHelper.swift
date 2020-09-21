//
//  UserDefaultsHelper.swift
//  Virus
//
//  Created by abedalkareem omreyh on 6/27/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class UserDefaultsHelper {

  // TODO: To support sound control in future
  class var isSoundOff: Bool {
    get {
      return UserDefaults.standard.bool(forKey: "sound")
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: "sound")
    }
  }

}
