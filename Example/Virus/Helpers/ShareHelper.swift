//
//  ShareHelper.swift
//  Virus
//
//  Created by abedalkareem omreyh on 6/24/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class ShareHelper: NSObject {

  class func share(url: URL, string: String, sourceView: UIView) -> UIViewController {
    let vc = UIActivityViewController(activityItems: [string, url], applicationActivities: nil)
    vc.popoverPresentationController?.sourceView = sourceView
    vc.popoverPresentationController?.sourceRect = sourceView.bounds
    return vc
  }

}
