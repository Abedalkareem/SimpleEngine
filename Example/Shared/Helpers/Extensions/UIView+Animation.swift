//
//  UIView+Animation.swift
//  Virus
//
//  Created by abedalkareem omreyh on 20/09/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import UIKit

extension UIView {
  
  ///
  /// Scale the view with the givin `x` and `y`.
  ///
  func animate(scaleX x: CGFloat, y: CGFloat, duration: TimeInterval = 0.2, completion: ((Bool) -> Void)? = nil) {
    UIView.animate(withDuration: duration,
                   animations: {
      self.transform = CGAffineTransform(scaleX: x, y: y)
    }, completion: completion)
  }

  ///
  /// Animate the alpha of the view with `duration`.
  /// - Parameter duration: Defualt value for duration is `0.5`.
  ///
  func animate(alpha: CGFloat, with duration: Double = 0.5) {
    UIView.animate(withDuration: duration) {
      self.alpha = alpha
    }
  }
  
}
