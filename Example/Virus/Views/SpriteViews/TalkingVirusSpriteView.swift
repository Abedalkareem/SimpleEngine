//
//  TalkingVirusSpriteView.swift
//  Virus
//
//  Created by abedalkareem omreyh on 18/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import Foundation
import SimpleEngine

@IBDesignable
class TalkingVirusSpriteView: SpriteView {

  // MARK: - Setup

  override func setup() {
    super.setup()
    #if !TARGET_INTERFACE_BUILDER
    startAnimationWith(frames: Frames(images: [#imageLiteral(resourceName: "idel_1"), #imageLiteral(resourceName: "idel_2")], duration: 0.2))
    #endif
  }

}
