//
//  LevelsViewController.swift
//  Virus
//
//  Created by abedalkareem omreyh on 17/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import SimpleEngine
import UIKit

class LevelsViewController: BaseGameViewController {

  // MARK: - IBOutlets

  @IBOutlet private weak var descriptionLabel: UILabel!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var bodyImageView: UIImageView!
  @IBOutlet private weak var movingBackgroundView: MovingBackgroundView!
  @IBOutlet private weak var actionButton: UIButton!

  // MARK: - ViewController lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setupViews()
    playBackgroundMusic()
    reportAchievement()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    movingBackgroundView.view = StreamBackgroundView(frame: view.bounds)
  }

  private func setupViews() {
    analogView.isHidden = true
    let level = Status.currentLevel + 1
    titleLabel.text = "mission_\(level)_title".localize
    descriptionLabel.text = "mission_\(level)_description".localize
    bodyImageView.image = UIImage(named: "level_\(level)")
    actionButton
      .setTitle(Status.isGameEnd ? "start_again".localize : "attack".localize,
                for: .normal)
  }

  private func playBackgroundMusic() {
    let music = Status.isGameEnd ? Music.win : Music.bodyScreen
    SimpleMusicPlayer.shared.playBackgroundMusicWith(music: music)
    SimpleMusicPlayer.shared.playMusic(music: Music.virusVoice)
  }

  private func reportAchievement() {
    var achievement: Achievement = .achievement1
    switch Status.currentLevel {
    case 1:
      achievement = .achievement2
    case 2:
      achievement = .achievement3
    case 3:
      achievement = .achievement4
    case 4:
      achievement = .achievement5
    case 5:
      achievement = .achievement6
    case 6:
      achievement = .achievement7
    case 7:
      achievement = .achievement8
    case 8:
      achievement = .achievement9
    default:
      break
    }
    if Status.isGameEnd {
      GameKitHelper.shared.report(achievement: .achievement10)
    }
    GameKitHelper.shared.report(achievement: achievement)
  }

  // MARK: - IBActions

  @IBAction private func attack(_ sender: Any) {
    GameKitHelper.shared.report(achievement: .achievement1)
    SimpleMusicPlayer.shared.playMusic(music: Music.buttonClicked)
    if Status.isGameEnd {
      Status.currentLevel = 0
    }
    let viewController = GameViewController.instance()
    changeViewController(viewController)
  }

  @IBAction private func back(_ sender: Any) {
    let viewController = MainViewController.instance()
    changeViewController(viewController)
  }

  // MARK: - ViewController instance

  static func instance() -> LevelsViewController {
     UIStoryboard.create(storyboard: .main, controller: LevelsViewController.self)
  }

  // MARK: - deinit

  deinit {
    SimpleMusicPlayer.shared.stopMusic(music: Music.virusVoice)
  }
}
