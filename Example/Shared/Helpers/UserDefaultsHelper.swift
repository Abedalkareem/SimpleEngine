//
//  UserDefaultsHelper.swift
//  Virus
//
//  Created by abedalkareem omreyh on 6/27/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

enum UserDefaultsHelper {

  // TODO: To support sound control in future
  static var isSoundOff: Bool {
    get {
      UserDefaults.standard.bool(forKey: "sound")
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: "sound")
    }
  }

}
