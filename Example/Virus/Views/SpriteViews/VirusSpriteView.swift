//
//  VirusSpriteView.swift
//  Example
//
//  Created by abedalkareem omreyh on 09/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import Foundation
import SimpleEngine

class VirusSpriteView: SpriteView {

  // MARK: - Properties

  let width = 75
  let height = 75

  // MARK: - Setup

  override func setup() {
    super.setup()

    frame = CGRect(x: 0, y: 0, width: width, height: height)

    type = CollideTypes.virus

    stopWhenCollideTypes = []

    let framesArray = [#imageLiteral(resourceName: "virus"), #imageLiteral(resourceName: "virus")]
    frames.top = framesArray
    frames.left = framesArray
    frames.right = framesArray
    frames.bottom = framesArray
    frames.idel = framesArray
  }
}
