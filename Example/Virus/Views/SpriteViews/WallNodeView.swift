//
//  WallNodeView.swift
//  Virus
//
//  Created by abedalkareem omreyh on 14/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import Foundation
import SimpleEngine

@IBDesignable
class WallNodeView: NodeView {
  // MARK: - Properties

  let width = 40
  let height = 40

  // MARK: - Setup

  override func setup() {
    super.setup()

    backgroundColor = .clear

    type = CollideTypes.wall
  }

}
