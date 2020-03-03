//
//  Frames.swift
//  Zaina
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
/// You can set the duration of the frames by setting the duration property.
///
public class Frames {
  var duration = 0.3
  var top: [UIImage]?
  var left: [UIImage]?
  var right: [UIImage]?
  var bottom: [UIImage]?
  var idel: [UIImage]?
  var topLeft: [UIImage]?
  var bottomLeft: [UIImage]?
  var topRight: [UIImage]?
  var bottomRight: [UIImage]?

  ///
  /// A method that will return an array of images to animate depending on the direction you will pass.
  ///
  public func framesFor(_ direction: Direction) -> [UIImage] {
    var movmentImages = [UIImage]()
    switch direction {
    case .left:
      movmentImages = left!
    case .right:
      movmentImages = right!
    case .top:
      movmentImages = top!
    case .bottom:
      movmentImages = bottom!
    case .center:
      movmentImages = idel!
    case .topLeft:
      movmentImages = topLeft ?? left!
    case .bottomLeft:
      movmentImages = bottomLeft ?? left!
    case .topRight:
      movmentImages = topRight ?? right!
    case .bottomRight:
      movmentImages = bottomRight ?? right!
    }
    return movmentImages
  }
}
