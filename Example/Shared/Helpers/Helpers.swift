//
//  Helpers.swift
//  Virus
//
//  Created by abedalkareem omreyh on 20/09/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import Foundation

var isTV: Bool {
  #if os(iOS)
  return false
  #else
  return true
  #endif
}
