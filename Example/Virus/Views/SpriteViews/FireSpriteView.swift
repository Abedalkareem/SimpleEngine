//
//  FireSpriteView.swift
//  Virus
//
//  Created by abedalkareem omreyh on 11/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import Foundation
import SimpleEngine

class FireSpriteView: SpriteView {

  // MARK: - Properties

  let width = 20
  let height = 20

  // MARK: - Setup

  override func setup() {
    super.setup()

    frame = CGRect(x: 0, y: 0, width: width, height: height)

    type = CollideTypes.fire
    speed = 20

    stopWhenCollideTypes = []

    frames.idel = [#imageLiteral(resourceName: "fire"), #imageLiteral(resourceName: "fire")]
  }
}
