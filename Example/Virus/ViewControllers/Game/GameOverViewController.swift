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

  @IBAction func tryAgain(_ sender: Any) {
    SimpleMusicPlayer.shared.playBackgroundMusicWith(music: Music.buttonClicked)
    changeViewController(GameViewController.instance())
  }

  @IBAction func home(_ sender: Any) {
    SimpleMusicPlayer.shared.playBackgroundMusicWith(music: Music.buttonClicked)
    changeViewController(MainViewController.instance())
  }

  // MARK: - ViewController instance

  static func instance() -> GameOverViewController {
    return UIStoryboard.create(storyboard: .game, controller: GameOverViewController.self)
  }
}
