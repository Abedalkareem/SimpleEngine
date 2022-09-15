//
//  AppButton.swift
//  Virus
//
//  Created by abedalkareem omreyh on 20/09/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import UIKit

class AppButton: UIButton {

  override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
    if context.nextFocusedView == self {
      animate(scaleX: 1.1, y: 1.1)
    } else if context.previouslyFocusedView == self {
      animate(scaleX: 1, y: 1)
    }
  }

}
