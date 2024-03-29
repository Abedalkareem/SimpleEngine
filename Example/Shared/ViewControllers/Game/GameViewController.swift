//
//  GameViewController.swift
//  Virus
//
//  Created by abedalkareem omreyh on 07/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import SimpleEngine
import UIKit

class GameViewController: BaseGameViewController {

  // MARK: - IBOutlets

  @IBOutlet private weak var movingBackgroundView: MovingBackgroundView!
  @IBOutlet private weak var livesView: LivesView!
  @IBOutlet private weak var progressView: ProgressView!

  // MARK: - Private properties

  private var virusSprite: VirusSpriteView!
  private var dialogView: DialogView?

  private var bloodTimer: Timer?
  private var whiteTimer: Timer?
  private var livesNotification: NSObjectProtocol?
  private var adDismissedNotification: NSObjectProtocol?

  private let numberOfLives = 4
  private var goalNumber = 0
  private var currentNumber = 0.0
  private var bloodTimerInterval = 0.0
  private var whiteTimerInterval = 0.0
  private var gameDifficulty: Double {
    Double(Status.currentLevel + 1) * 0.1
  }

  override var preferredFocusedView: UIView? {
    analogView
  }

  // MARK: - ViewController lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setGameDifficulty()

    addVirus()
    startBloodTimer()
    startWhiteTimer()

    observeForLives()
    addNotificationCenterObservers()

    playBackgroundMusic()

    livesView.livesCount = numberOfLives

//    analogView.isHidden = isTV
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    movingBackgroundView.view = StreamBackgroundView(frame: view.bounds)
  }

  private func playBackgroundMusic() {
    SimpleMusicPlayer.shared.playBackgroundMusicWith(music: Music.gameBackground)
  }

  private func setGameDifficulty() {
    goalNumber = Int(gameDifficulty * 50)
    bloodTimerInterval = (0.5 + gameDifficulty) * 2
    whiteTimerInterval = (1 - gameDifficulty) * 1.5
    currentNumber = 0
  }

  // MARK: - Observers

  private func observeForLives() {
    livesView.livesDidUpdate { [weak self] numberOfLives in
      guard let self = self else { return }
      if numberOfLives == 0 {
        if isTV {
          self.showGameOverController()
        } else {
          self.showGetMoreLivesDialog()
          self.paused = true
        }
      }
    }

  }

  private func addNotificationCenterObservers() {
    #if os(iOS)
    livesNotification = NotificationCenter.default
      .addObserver(forName: .livesChanged, object: nil, queue: .main) { [weak self] _ in
      guard let numberOfLives = self?.numberOfLives else {
        return
      }
      self?.livesView.add(numberOfLives)
      }

    adDismissedNotification = NotificationCenter.default
      .addObserver(forName: .adDismissed, object: nil, queue: .main) { [weak self] _ in
      self?.showGameOverController()
      }
    #endif
  }

  // MARK: - Dialogs

  private func showGetMoreLivesDialog() {
    guard dialogView == nil else {
      return
    }
    dialogView = DialogView.show(in: view,
                                 text: "more_lives".localize,
                                 firstButton: "watch".localize,
                                 secondButton: "no".localize) { [unowned self] action in
      if action == .second {
        self.showGameOverController()
      } else {
        self.dialogView?.dismiss()
        self.dialogView = nil
        self.showPauseDialog()
      }
    }
  }

  private func showPauseDialog() {
    guard dialogView == nil else {
      return
    }

    dialogView = DialogView.show(in: view,
                                 text: "paused".localize,
                                 firstButton: "resume".localize,
                                 secondButton: "end".localize,
                                 cancelWhenFirstButtonClick: true) { [unowned self] action in
      self.dialogView = nil
      if action == .second {
        self.showGameOverController()
      } else {
        self.paused = false
      }
    }
  }

  // MARK: - Timers

  private func startBloodTimer() {
    bloodTimer = Timer.scheduledTimer(withTimeInterval: bloodTimerInterval,
                                      repeats: true) { [weak self] _ in
      self?.addBloodCells()
    }
  }

  private func stopBloodTimer() {
    bloodTimer?.invalidate()
    bloodTimer = nil
  }

  private func startWhiteTimer() {
    whiteTimer = Timer.scheduledTimer(withTimeInterval: whiteTimerInterval,
                                      repeats: true) { [weak self] _ in
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
      return collideBetween(fire: object1, blood: object2)
    case (CollideTypes.blood, CollideTypes.fire):
      return collideBetween(fire: object2, blood: object1)
    case (CollideTypes.whiteFire, CollideTypes.virus):
      return collideBetween(virus: object2, whiteCell: object1)
    case (CollideTypes.virus, CollideTypes.whiteFire):
      return collideBetween(virus: object1, whiteCell: object2)
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
    currentNumber += 1
    progressView.update(CGFloat(currentNumber / Double(goalNumber)))
    GameKitHelper.shared.report(score: Int64(currentNumber))
    if Int(currentNumber) == goalNumber {
      Status.currentLevel += 1
      showLevelsController()
      return false
    }
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
    let randomY = CGFloat.random(in: width...(view.bounds.height - width))
    bloodCellSprite.frame.origin = CGPoint(x: -width, y: randomY)
    sceneView.addSubview(bloodCellSprite)
    bloodCellSprite.moveTo(x: view.bounds.width, y: randomY)
  }

  private func addWhiteCells() {
    let bloodCellSprite = WhiteCellSpriteView(virusPoint: virusSprite.center)
    let width = CGFloat(bloodCellSprite.width)
    let randomY = CGFloat.random(in: width...(view.bounds.height - width))
    bloodCellSprite.frame.origin = CGPoint(x: -width, y: randomY)
    sceneView.addSubview(bloodCellSprite)
    bloodCellSprite.moveTo(x: view.bounds.width, y: randomY)
  }

  // MARK: - Show ViewControllers

  private func showLevelsController() {
    let viewController = LevelsViewController.instance()
    changeViewController(viewController)
  }

  private func showGameOverController() {
    let viewController = GameOverViewController.instance()
    changeViewController(viewController)
  }

  // MARK: - Pause and Resume callbacks

  override func didPause() {
    showPauseDialog()
    stopBloodTimer()
    stopWhiteTimer()
  }

  override func didResume() {
    startBloodTimer()
    startWhiteTimer()
  }

  // MARK: - ViewController instance

  static func instance() -> GameViewController {
    UIStoryboard.create(storyboard: .game, controller: GameViewController.self)
  }

  // MARK: - deinit

  deinit {
    if let livesNotification = livesNotification {
      NotificationCenter.default.removeObserver(livesNotification)
    }
    if let adDismissedNotification = adDismissedNotification {
      NotificationCenter.default.removeObserver(adDismissedNotification)
    }
  }

  //  override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
  //    event?.allPresses.dffzsz
  //  }
}

extension NSNotification.Name {
  static let livesChanged = NSNotification.Name("livesChanged")
  static let adDismissed = NSNotification.Name("adDismissed")
}
