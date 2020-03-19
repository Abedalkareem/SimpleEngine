//
//  ShareHelper.swift
//  Virus
//
//  Created by abedalkareem omreyh on 6/24/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class ShareHelper: NSObject {

  class func takeScreenshotFrom(_ view: UIView) -> UIImage? {
    UIGraphicsBeginImageContext(view.frame.size)
    if let context = UIGraphicsGetCurrentContext() {
      view.layer.render(in: context)
    }
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }

  class func share(image: UIImage, sourceView: UIView) -> UIViewController {
    let vc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
    vc.popoverPresentationController?.sourceView = sourceView
    vc.popoverPresentationController?.sourceRect = sourceView.bounds
    return vc
  }

}
