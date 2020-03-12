//
//  Frames.swift
//  SimpleEngine
//
//  Created by abedalkareem omreyh on 7/26/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

///
/// To set a frames for the movment of the `SpriteView`. You can set the images (frames) that will show
/// when the user move to right, left, top, bottom, topLeft, bottomLeft, topRight, bottomRight or idel.
/// If you did not pass the topLeft or bottomLeft the left images will be used, same for topRight and bottomRight you
/// will get right images.
/// At least you need to pass the idel images and it will be used for
/// all the frames.
/// You can set the duration of the frames by setting the duration property.
///
open class Frames {
  open var defaultDuration = 0.3
  open var idelDuration = 0.3
  open var top: [UIImage]?
  open var left: [UIImage]?
  open var right: [UIImage]?
  open var bottom: [UIImage]?
  open var idel: [UIImage]!
  open var topLeft: [UIImage]?
  open var bottomLeft: [UIImage]?
  open var topRight: [UIImage]?
  open var bottomRight: [UIImage]?

  ///
  /// A method that will return an array of images to animate depending on the direction you will pass.
  ///
  open func framesFor(_ direction: Direction) -> (frames: [UIImage], duration: Double) {
    var movmentImages = [UIImage]()
    var duration = defaultDuration
    switch direction {
    case .left:
      movmentImages = left ?? idel
    case .right:
      movmentImages = right ?? idel
    case .top:
      movmentImages = top ?? idel
    case .bottom:
      movmentImages = bottom ?? idel
    case .center:
      movmentImages = idel
      duration = idelDuration
    case .topLeft:
      movmentImages = topLeft ?? left ?? idel
    case .bottomLeft:
      movmentImages = bottomLeft ?? left ?? idel
    case .topRight:
      movmentImages = topRight ?? right ?? idel
    case .bottomRight:
      movmentImages = bottomRight ?? right ?? idel
    }
    return (movmentImages, duration)
  }
}
