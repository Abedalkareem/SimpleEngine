//
//  ManSpriteView.swift
//  Virus
//
//  Created by abedalkareem omreyh on 16/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import Foundation
import SimpleEngine

@IBDesignable
class ManSpriteView: SpriteView {

  // MARK: - Setup

  override func setup() {
    super.setup()
    #if !TARGET_INTERFACE_BUILDER
    startAnimationWith(frames: Frames(images: [#imageLiteral(resourceName: "man_2"), #imageLiteral(resourceName: "man_1")], duration: 0.2))
    #endif
  }

}
