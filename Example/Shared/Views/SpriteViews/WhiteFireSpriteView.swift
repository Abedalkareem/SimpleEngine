//
//  WhiteFireSpriteView.swift
//  Virus
//
//  Created by abedalkareem omreyh on 19/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import Foundation
import SimpleEngine

class WhiteFireSpriteView: SpriteView {

  // MARK: - Properties

  let width = 10
  let height = 10

  // MARK: - Private properties

  private var didColide = false

  // MARK: - Setup

  override func setup() {
    super.setup()

    type = CollideTypes.whiteFire
    speed = 20

    stopWhenCollideTypes = [CollideTypes.virus, CollideTypes.fire]

    frames?.idel = Frames(images: [#imageLiteral(resourceName: "white_fire")], duration: 0.1)
  }

  // MARK: -

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
    removeFromSuperview()
    DispatchQueue.global().async {
      SimpleMusicPlayer.shared.playMusic(music: Music.liveDestroyed)
    }
  }

  override func didRechedDesiredPoint() {
    removeFromSuperview()
  }
}
