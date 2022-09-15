//
//  GameKitHelper.swift
//  Virus
//
//  Created by abedalkareem omreyh on 6/18/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import GameKit
import UIKit

class GameKitHelper: NSObject {

  static let shared = GameKitHelper()

  var leaderboardID = "topplayers"

  func authenticateUser(_ authenticateHandler: @escaping (UIViewController?) -> Void) {
    let player = GKLocalPlayer.local
    player.authenticateHandler = { viewController, error in
      guard error == nil else {
        print(error?.localizedDescription ?? "")
        return
      }
      authenticateHandler(viewController)
    }
  }

  func report(score: Int64) {
    let reportedScore = GKScore(leaderboardIdentifier: leaderboardID)
    reportedScore.value = score
    GKScore.report([reportedScore]) { error in
      guard error == nil else {
        print(error?.localizedDescription ?? "")
        return
      }
      print("The score submitted to the game center")
    }
  }

  func report(achievement: Achievement, percentComplete: Double = 100) {
    let achievement = GKAchievement(identifier: achievement.identifier)
    achievement.percentComplete = percentComplete
    achievement.showsCompletionBanner = true
    GKAchievement.report([achievement]) { error in
      print(error?.localizedDescription ?? "")
    }
  }

  func getGameCenterControllerWith(viewState: GKGameCenterViewControllerState) -> GKGameCenterViewController {
    let viewController = GKGameCenterViewController()
    viewController.gameCenterDelegate = self
    viewController.viewState = viewState
    if viewState == .leaderboards {
      viewController.leaderboardIdentifier = leaderboardID
    }
    return viewController
  }

}

extension GameKitHelper: GKGameCenterControllerDelegate {

  func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
    gameCenterViewController.dismiss(animated: true, completion: nil)
  }
}

enum Achievement: String {

  var identifier: String {
    rawValue
  }

  case achievement1 = "start_the_attack"
  case achievement2 = "first_mission"
  case achievement3 = "second_mission"
  case achievement4 = "third_mission"
  case achievement5 = "forth_mission"
  case achievement6 = "fifth_mission"
  case achievement7 = "sixth_mission"
  case achievement8 = "seventh_mission"
  case achievement9 = "final_mission"
  case achievement10 = "you_saved_us"
  case achievement11 = "ask_for_help"
}
