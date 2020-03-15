//
//  WhiteCellSpriteView.swift
//  Virus
//
//  Created by abedalkareem omreyh on 12/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import Foundation
import SimpleEngine

class WhiteCellSpriteView: SpriteView {

  // MARK: - Properties

  let width = 40
  let height = 40

  // MARK: - Private properties

  private var didColideWithVirus = false

  // MARK: - Setup

  override func setup() {
    super.setup()

    frame = CGRect(x: 0, y: 0, width: width, height: height)

    type = CollideTypes.whiteCell
    speed = 10

    stopWhenCollideTypes = [CollideTypes.virus, CollideTypes.fire]

    frames.idel = Frames(images: [#imageLiteral(resourceName: "white_cell"), #imageLiteral(resourceName: "white_cell")])
  }

  // MARK: -

  override func didRechedDesiredPoint() {
    removeFromSuperview()
  }

  override func onCollisionEnter(with object: ObjectView?) -> Bool {
    super.onCollisionEnter(with: object)
    guard !didColideWithVirus else {
      return false
    }
    switch object {
    case object as FireSpriteView:
      removeFromSuperview()
    case object as VirusSpriteView:
      didColideWithVirus = true
    default:
      break
    }
    return true
  }
}
