//
//  BaseGameViewController.swift
//  SimpleEngine
//
//  Created by abedalkareem omreyh on 7/21/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import GameController
import UIKit

open class BaseGameViewController: UIViewController {

  // MARK: - IBOutlet

  // swiftlint:disable private_outlet
  /// A scene to add `SpriteView`s and `NodeView`s to it.
  @IBOutlet open weak var sceneView: SceneView!

  // MARK: - Properties

  ///
  /// A property to attach a physical controller to the analog.
  ///
  /// ```
  ///   controller = GCController.controllers().first
  /// ```
  ///
  open var controller: GCController? = nil {
    didSet {
      analogView.attach(controller: controller)
    }
  }

  ///
  /// An analog to be attached to a `SpriteView` to control it.
  ///
  open lazy var analogView = AnalogView()

  ///
  /// A property to pause or resume the game.
  /// If you set it to true the game will be paused but, still you need to
  /// handle some code by your own, like if you have a timer you need to
  /// stop it and resume it again. to do that you can override the
  /// `didPause` and `didResume`.
  /// Inside the `didPause` you can stop any timer
  /// and in `didResume` you can start it again.
  /// The default value is `false`.
  ///
  open var paused: Bool = false {
    didSet {
      if paused {
        pause()
      } else {
        resume()
      }
    }
  }

  // MARK: - Private properties

  private var timer: Timer?
  private var shouldKeepUpdatingTheScene = true

  // MARK: - ViewController lifecycle

  override open func viewDidLoad() {
    super.viewDidLoad()

    addAnalogView()
    start()
    setDefaultController()
  }

  override open func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    addObservers()
  }

  override open func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    removeObservers()
    paused = true
  }

  private func setDefaultController() {
    controller = GCController.controllers().first
  }

  ///
  /// Start the game. resume `sceneView`, set `shouldKeepUpdatingTheScene` to `true`
  /// and start the timer.
  ///
  private func start() {
    sceneView.paused = false
    shouldKeepUpdatingTheScene = true
    startTimer()
  }

  ///
  /// Resume the game. It's same as `start` but, it's also calling `didResume` so you can be notified.
  ///
  @objc
  private func resume() {
    start()
    didResume()
  }

  ///
  /// Stop the game. pause `sceneView` , set `shouldKeepUpdatingTheScene` to `false`
  /// and stop the timer.
  ///
  @objc
  private func stop() {
    sceneView.paused = true
    shouldKeepUpdatingTheScene = false
    stopTimer()
  }

  ///
  /// Pause the game. It's same as `stop` but, it's also calling `didPause` so you can be notified.
  ///
  @objc
  private func pause() {
    stop()
    didPause()
  }

  private func addAnalogView() {
    view.addSubview(analogView)

    makeAnalogViewConstraints()
  }

  private func makeAnalogViewConstraints() {
    let analogSize = AnalogView.Settings.analogSize
    let margen = AnalogView.Settings.margen
    analogView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      analogView.widthAnchor.constraint(equalToConstant: analogSize),
      analogView.heightAnchor.constraint(equalToConstant: analogSize),
      analogView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margen),
      analogView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margen)
    ])
  }

  // MARK: - Observers

  private func addObservers() {
    NotificationCenter.default
      .addObserver(self,
                   selector: #selector(didBecomeActive),
                   name: UIApplication.didBecomeActiveNotification,
                   object: nil)
    NotificationCenter.default
      .addObserver(self,
                   selector: #selector(willResignActive),
                   name: UIApplication.willResignActiveNotification,
                   object: nil)
  }

  private func removeObservers() {
    NotificationCenter.default
      .removeObserver(self,
                      name: UIApplication.didBecomeActiveNotification,
                      object: nil)

    NotificationCenter.default
      .removeObserver(self,
                      name: UIApplication.willResignActiveNotification,
                      object: nil)
  }

  @objc
  private func didBecomeActive() { }

  @objc
  private func willResignActive() {
    paused = true
  }

  // MARK: - Timer

  private func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 0.016,
                                 target: self,
                                 selector: #selector(update),
                                 userInfo: nil,
                                 repeats: true)
  }

  private func stopTimer() {
    timer?.invalidate()
    timer = nil
  }

  // MARK: - Public methods

  ///
  /// Override it to make changes or move objects.
  /// if you override it you need to call `super.update` at
  /// some point.
  ///
  @objc
  open func update() {
    checkIfObjectsCollided()
  }

  ///
  /// To check if any two objects collided.
  /// if you override it you need to call `super.checkIfObjectsCollided` at
  /// some point.
  ///
  open func checkIfObjectsCollided() {
    let subviews = sceneView.subviews.compactMap { $0 as? ObjectView }
    for object1 in subviews {
      for object2 in subviews {
        guard object1 != object2 else {
          continue
        }
        guard object1.frame.intersects(object2.frame) else {
          continue
        }
        let shouldReportCollideToViewController = shouldKeepUpdatingTheScene &&
          object1.onCollisionEnter(with: object2) &&
          object2.onCollisionEnter(with: object1)
        if shouldReportCollideToViewController {
          shouldKeepUpdatingTheScene = objectsDidCollide(object1: object1, object2: object2)
        }
      }
    }
  }

  ///
  /// Override this method to get notify when two objects collided.
  /// return true if you want to still get updates aftet two objects collide.
  ///
  open func objectsDidCollide(object1: ObjectView, object2: ObjectView) -> Bool { true }

  ///
  /// Override to get an update when the game paused to do any pause logic.
  ///
  open func didPause() {}

  ///
  /// Override to get an update when the game resumed to do any resume logic.
  ///
  open func didResume() {}

}
