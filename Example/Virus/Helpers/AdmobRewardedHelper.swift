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
    rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-3940256099942544/1712485313")
    rewardedAd?.load(GADRequest()) { error in
      if let error = error {
        print(error.localizedDescription)
      }
    }
  }

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
    load()
  }

  func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
    print("Reward received with currency: \(reward.type), amount \(reward.amount).")
    UserDefaultsHelper.lives += 1
    NotificationCenter.default.post(name: .livesChanged, object: nil, userInfo: nil)
    load()
  }
}

extension NSNotification.Name {
  static let livesChanged = NSNotification.Name("livesChanged")
}
