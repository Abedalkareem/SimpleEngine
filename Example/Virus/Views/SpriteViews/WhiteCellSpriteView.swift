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

  private var didColide = false

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
    guard !didColide else {
      return false
    }
    switch object {
    case object as FireSpriteView:
      destroy()
    case object as VirusSpriteView:
      destroy()
    default:
      break
    }
    return true
  }

  private func destroy() {
    didColide = true
    let frames = Frames(images: [#imageLiteral(resourceName: "destroy_1"), #imageLiteral(resourceName: "destroy_2"), #imageLiteral(resourceName: "destroy_3"), #imageLiteral(resourceName: "destroy_4")],
                        duration: 0.2)
    startAnimationWith(frames: frames,
                       repeatCount: 1,
                       stopOtherAnimations: true) {
                        self.removeFromSuperview()
    }
  }
}
