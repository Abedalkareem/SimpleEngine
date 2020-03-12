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
    speed = 10

    stopWhenCollideTypes = []

    frames.defaultDuration = 0.5
    frames.idelDuration = 1
    frames.top = [#imageLiteral(resourceName: "move_top_1"), #imageLiteral(resourceName: "move_top_2"), #imageLiteral(resourceName: "move_top_3")]
    frames.left = [#imageLiteral(resourceName: "move_for_1"), #imageLiteral(resourceName: "move_for_2"), #imageLiteral(resourceName: "move_for_3")]
    frames.right = [#imageLiteral(resourceName: "move_back_1"), #imageLiteral(resourceName: "move_back_2"), #imageLiteral(resourceName: "move_back_3")]
    frames.bottom = [#imageLiteral(resourceName: "move_bottom_1"), #imageLiteral(resourceName: "move_bottom_2"), #imageLiteral(resourceName: "move_bottom_3")]
    frames.idel = [#imageLiteral(resourceName: "idel_1"), #imageLiteral(resourceName: "idel_2")]

  }

  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
      self.startFiring()
    }
  }

  private func startFiring() {
    let sceneView = superview as! SceneView
    let spriteView = FireSpriteView()
    spriteView.frame = CGRect(x: center.x, y: center.y, width: 20, height: 20)
    sceneView.addSubview(spriteView)
    spriteView.moveTo(x: -20, y: center.y)
  }
}
