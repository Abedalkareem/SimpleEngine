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

    type = CollideTypes.fire
    speed = 20

    stopWhenCollideTypes = []

    frames.idel = [#imageLiteral(resourceName: "fire"), #imageLiteral(resourceName: "fire_2"), #imageLiteral(resourceName: "fire_3"), #imageLiteral(resourceName: "fire_4"), #imageLiteral(resourceName: "fire_5")]
    frames.defaultDuration = 0.1
  }

  override func didRechedDesiredPoint() {
    removeFromSuperview()
  }
}
