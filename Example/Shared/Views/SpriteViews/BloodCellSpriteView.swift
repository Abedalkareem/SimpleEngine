//
//  BloodCellSpriteView.swift
//  Virus
//
//  Created by abedalkareem omreyh on 12/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import UIKit
import SimpleEngine

class BloodCellSpriteView: SpriteView {

  // MARK: - Properties

  let width = 40
  let height = 40

  // MARK: - Private properties

  var notInfected = true

  // MARK: - Setup

  override func setup() {
    super.setup()

    frame = CGRect(x: 0, y: 0, width: width, height: height)

    type = CollideTypes.blood
    speed = 10

    stopWhenCollideTypes = [CollideTypes.virus, CollideTypes.fire]

    frames.idel = Frames(images: [#imageLiteral(resourceName: "blood_cell")])
  }

  // MARK: -

  override func didRechedDesiredPoint() {
    removeFromSuperview()
  }

  override func onCollisionEnter(with object: ObjectView?) -> Bool {
    super.onCollisionEnter(with: object)
    guard notInfected else {
      return false
    }
    if object is FireSpriteView {
      infect()
    }
    return true
  }

  private func infect() {
    notInfected = false
    let frames = Frames(images: [#imageLiteral(resourceName: "infected_1"), #imageLiteral(resourceName: "infected_2"), #imageLiteral(resourceName: "infected_3"), #imageLiteral(resourceName: "infected_4"), #imageLiteral(resourceName: "infected_5"), #imageLiteral(resourceName: "infected_6")], duration: 0.4)
    startAnimationWith(frames: frames,
                       repeatCount: 1,
                       stopOtherAnimations: false) {
      self.frames.idel = Frames(images: [#imageLiteral(resourceName: "infected_6")])
      self.updateFrames()
    }
  }
}
