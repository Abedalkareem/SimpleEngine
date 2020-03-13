//
//  BloodCellSpriteView.swift
//  Virus
//
//  Created by abedalkareem omreyh on 12/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import Foundation
import SimpleEngine

class BloodCellSpriteView: SpriteView {

  // MARK: - Properties

  let width = 40
  let height = 40

  // MARK: - Setup

  override func setup() {
    super.setup()

    frame = CGRect(x: 0, y: 0, width: width, height: height)

    type = CollideTypes.blood
    speed = 10

    stopWhenCollideTypes = [CollideTypes.virus, CollideTypes.fire]

    frames.idel = [#imageLiteral(resourceName: "blood_cell"), #imageLiteral(resourceName: "blood_cell")]
    frames.defaultDuration = 0
  }

  // MARK: -

  override func didRechedDesiredPoint() {
    removeFromSuperview()
  }

  override func onCollisionEnter(with object: ObjectView?) {
    super.onCollisionEnter(with: object)
    if object is FireSpriteView || object is VirusSpriteView {
      frames.idel = [#imageLiteral(resourceName: "infected_blood_cell")]
      updateFrames()
    }
  }
}
