//
//  ShareHelper.swift
//  Virus
//
//  Created by abedalkareem omreyh on 6/24/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class ShareHelper: NSObject {

  class func share(url: URL, string: String, sourceView: UIView) -> UIViewController? {
    var viewController: UIViewController?
    #if os(iOS)
    viewController = UIActivityViewController(activityItems: [string, url], applicationActivities: nil)
    viewController?.popoverPresentationController?.sourceView = sourceView
    viewController?.popoverPresentationController?.sourceRect = sourceView.bounds
    #endif
    return viewController
  }

}
