//
//  MainViewController.swift
//  Virus
//
//  Created by abedalkareem omreyh on 13/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import UIKit
import SimpleEngine

class MainViewController: BaseGameViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet private weak var movingBackgroundView: MovingBackgroundView!

  // MARK: - Private properties

  private var bloodTimer: Timer?

  // MARK: - ViewController lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupViews()
    playBackgroundMusic()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    movingBackgroundView.view = StreamBackgroundView(frame: view.bounds)
    startBloodTimer()
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    stopBloodTimer()
  }
  
  private func setupViews() {
    analogView.isHidden = true
  }

  private func playBackgroundMusic() {
    MusicPlayer.shared.playBackgroundMusicWith(music: Music.mainMenu)
  }

  // MARK: -

  private func startBloodTimer() {
    bloodTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
      self?.addBloodCells()
    }
  }

  private func stopBloodTimer() {
    bloodTimer?.invalidate()
    bloodTimer = nil
  }

  // MARK: - Sprites Adding

  private func addBloodCells() {
    let bloodCellSprite = BloodCellSpriteView()
    let width = CGFloat(bloodCellSprite.width)
    let randomY = CGFloat.random(in: width...(view.bounds.height-width))
    bloodCellSprite.frame.origin = CGPoint(x: -width, y: randomY)
    sceneView.addSubview(bloodCellSprite)
    bloodCellSprite.moveTo(x: view.bounds.width, y: randomY)
  }

  // MARK: - Properties

  @IBAction func start(_ sender: Any) {
    MusicPlayer.shared.playMusic(music: Music.buttonClicked)
    changeViewController(Status.currentLevelViewController())
  }

}
