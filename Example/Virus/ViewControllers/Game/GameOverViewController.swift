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
    MusicPlayer.shared.playBackgroundMusicWith(music: Music.gameOver)
  }

  // MARK: - IBActions

  @IBAction func tryAgain(_ sender: Any) {
    MusicPlayer.shared.playBackgroundMusicWith(music: Music.buttonClicked)
    changeViewController(GameViewController.instance())
  }

  // MARK: - ViewController instance

  static func instance() -> GameOverViewController {
    return UIStoryboard.create(storyboard: .game, controller: GameOverViewController.self)
  }
}
