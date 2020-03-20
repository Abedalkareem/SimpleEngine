//
//  AdmobHelper.swift
//  Virus
//
//  Created by abedalkareem omreyh on 7/13/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AdmobRewardedHelper: NSObject, GADRewardedAdDelegate {

  static let shared = AdmobRewardedHelper()

  var rewardedAd: GADRewardedAd?

  func load() {
    rewardedAd = GADRewardedAd(adUnitID: Constants.strings.adID)
    rewardedAd?.load(GADRequest()) { error in
      if let error = error {
        print(error.localizedDescription)
      }
    }
  }

  @discardableResult
  func show(in viewController: UIViewController) -> Bool {
    guard rewardedAd?.isReady == true else {
      return false
    }
    rewardedAd?.present(fromRootViewController: viewController, delegate:self)
    return true
  }

  func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
    print("Rewarded ad presented.")
  }

  func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
    print("Rewarded ad failed to present.")
  }

  func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
    print("Rewarded ad dismissed.")
    NotificationCenter.default.post(name: .adDismissed, object: nil, userInfo: nil)
    load()
  }

  func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
    print("Reward received with currency: \(reward.type), amount \(reward.amount).")
    NotificationCenter.default.post(name: .livesChanged, object: nil, userInfo: nil)
    load()
  }
}

extension NSNotification.Name {
  static let livesChanged = NSNotification.Name("livesChanged")
  static let adDismissed = NSNotification.Name("adDismissed")
}
