//
//  GameViewController.swift
//  Virus
//
//  Created by abedalkareem omreyh on 07/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import UIKit
import SimpleEngine

class GameViewController: BaseGameViewController {

  // MARK: - IBOutlets

  @IBOutlet private weak var movingBackgroundView: MovingBackgroundView!
  @IBOutlet private weak var livesView: LivesView!


  // MARK: - Private properties

  private var virusSprite: VirusSpriteView!

  private var bloodTimer: Timer?
  private var whiteTimer: Timer?

  // MARK: - ViewController lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    addVirus()
    startBloodTimer()
    startWhiteTimer()

    observeForLives()

    livesView.livesCount = 4

    playBackgroundMusic()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    movingBackgroundView.view = StreamBackgroundView(frame: view.bounds)
  }

  private func playBackgroundMusic() {
    MusicPlayer.shared.playBackgroundMusicWith(music: Music.gameBackground)
  }

  // MARK: -

  private func observeForLives() {
    livesView.livesDidUpdate { numberOfLives in
      if numberOfLives == 0 {
        
      }
    }
  }

  private func startBloodTimer() {
    bloodTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
      self?.addBloodCells()
    }
  }

  private func stopBloodTimer() {
    bloodTimer?.invalidate()
    bloodTimer = nil
  }

  private func startWhiteTimer() {
    whiteTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { [weak self] _ in
      self?.addWhiteCells()
    }
  }

  private func stopWhiteTimer() {
    whiteTimer?.invalidate()
    whiteTimer = nil
  }

  // MARK: - Collision

  override func objectsDidCollide(object1: ObjectView, object2: ObjectView) -> Bool {
    switch (object1.type, object2.type) {
    case (CollideTypes.virus, CollideTypes.whiteCell):
      return collideBetween(virus: object1, whiteCell: object2)
    case (CollideTypes.whiteCell, CollideTypes.virus):
      return collideBetween(virus: object2, whiteCell: object1)
    case (CollideTypes.fire, CollideTypes.blood):
      return collideBetween(fire: object2, blood: object1)
    case (CollideTypes.blood, CollideTypes.fire):
      return collideBetween(fire: object1, blood: object2)
    default:
      break
    }
    return true
  }

  private func collideBetween(virus: ObjectView, whiteCell: ObjectView) -> Bool {
    livesView.remove(1)
    return true
  }

  private func collideBetween(fire: ObjectView, blood: ObjectView) -> Bool {
    return true
  }

  // MARK: - Sprites Adding

  private func addVirus() {
    virusSprite = VirusSpriteView()
    virusSprite.attachTo(analogView)
    let rightMargen: CGFloat = virusSprite.frame.width
    let x = view.frame.width - virusSprite.frame.width - rightMargen
    let y = (view.frame.height / 2) - virusSprite.frame.height
    virusSprite.frame.origin = CGPoint(x: x, y: y)
    sceneView.addSubview(virusSprite)
  }

  private func addBloodCells() {
    let bloodCellSprite = BloodCellSpriteView()
    let width = CGFloat(bloodCellSprite.width)
    let randomY = CGFloat.random(in: width...(view.bounds.height-width))
    bloodCellSprite.frame.origin = CGPoint(x: -width, y: randomY)
    sceneView.addSubview(bloodCellSprite)
    bloodCellSprite.moveTo(x: view.bounds.width, y: randomY)
  }

  private func addWhiteCells() {
    let bloodCellSprite = WhiteCellSpriteView()
    let width = CGFloat(bloodCellSprite.width)
    let randomY = CGFloat.random(in: width...(view.bounds.height-width))
    bloodCellSprite.frame.origin = CGPoint(x: -width, y: randomY)
    sceneView.addSubview(bloodCellSprite)
    bloodCellSprite.moveTo(x: view.bounds.width, y: randomY)
  }

  // MARK: - deinit

  deinit {
    stopBloodTimer()
    stopWhiteTimer()
  }
}

