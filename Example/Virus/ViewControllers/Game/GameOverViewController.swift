//
//  GameOverViewController.swift
//  Virus
//
//  Created by abedalkareem omreyh on 16/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import UIKit
import SimpleEngine

class GameOverViewController: UIViewController {

  // MARK: - IBOutlets

  @IBOutlet private weak var movingBackgroundView: MovingBackgroundView!

  // MARK: - Private properties

  // MARK: - ViewController lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    playBackgroundSong()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    movingBackgroundView.view = StreamBackgroundView(frame: view.bounds)
  }

  private func playBackgroundSong() {
    SimpleMusicPlayer.shared.playBackgroundMusicWith(music: Music.gameOver)
  }

  // MARK: - IBActions

  @IBAction private func tryAgain(_ sender: Any) {
    SimpleMusicPlayer.shared.playBackgroundMusicWith(music: Music.buttonClicked)
    changeViewController(GameViewController.instance())
  }

  @IBAction private func home(_ sender: Any) {
    SimpleMusicPlayer.shared.playBackgroundMusicWith(music: Music.buttonClicked)
    changeViewController(MainViewController.instance())
  }

  @IBAction private func share(_ sender: UIButton) {
    guard let url = URL(string: Constants.links.appLink) else {
      return
    }
    GameKitHelper.shared.report(achievement: .achievement11)
    let viewController = ShareHelper.share(url: url,
                                           string: "help_string".localize,
                                           sourceView: sender)
    present(viewController, animated: true, completion: nil)
  }

  // MARK: - ViewController instance

  static func instance() -> GameOverViewController {
    return UIStoryboard.create(storyboard: .game, controller: GameOverViewController.self)
  }
}
