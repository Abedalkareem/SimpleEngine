//
//  DialogView.swift
//  Virus
//
//  Created by abedalkareem omreyh on 19/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import UIKit

class DialogView: UIView {

  // MARK: - Properties

  var blurEffectView: UIVisualEffectView!
  var containerView: UIView!
  var label: UILabel!
  var backgroundImageView: UIImageView!
  var overlayWindow: UIWindow!

  // MARK: - init

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
  }

  private func setupViews() {
    backgroundColor = .clear

    addBlurEffect()
    addContainer()
    addBackgroundImage()
    addLabel()

    makeConstraints()
  }

  private func addBlurEffect() {
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.alpha = 0.5
    blurEffectView.isUserInteractionEnabled = true
    addSubview(blurEffectView)
  }

  private func addContainer() {
    containerView = UIView()
    containerView.backgroundColor = .clear
    addSubview(containerView)
  }

  private func addBackgroundImage() {
    backgroundImageView = UIImageView()
    backgroundImageView.image = #imageLiteral(resourceName: "button_background").resizableImage(withCapInsets: UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20))
    containerView.addSubview(backgroundImageView)
  }

  private func addLabel() {
    label = UILabel()
    label.text = "more_lives".localize
    containerView.addSubview(label)
  }

  private func makeConstraints() {
    blurEffectView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      blurEffectView.topAnchor.constraint(equalTo: topAnchor),
      blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
      blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
      blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
    ])

    containerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
      containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
      containerView.widthAnchor.constraint(equalToConstant: 250),
      containerView.heightAnchor.constraint(equalToConstant: 150),
    ])

    backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      backgroundImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
      backgroundImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
      backgroundImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      backgroundImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
    ])

    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
      label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
    ])
  }

  // MARK: - View lifecycle

  override func draw(_ rect: CGRect) {
    animate(isShowing: true)
  }

  // MARK: - Actions

  @objc
  private func hide() {
    dismiss()
  }

  func dismiss(completion: ((Bool) -> Void)? = nil) {
    animate(isShowing: false, completion: completion)
  }

  // MARK: - Animation

  func animate(isShowing: Bool, completion: ((Bool) -> Void)? = nil) {
    UIView.animate(withDuration: 0.5, animations: {
      self.alpha = isShowing ? 1 : 0
    }) { finished in
      if !isShowing {
        self.overlayWindow = nil
        self.removeFromSuperview()
        completion?(finished)
      }
    }
  }

  // MARK: - Show

  class func show() {
    let bounds = UIScreen.main.bounds
    let window = UIWindow()
    window.backgroundColor = .clear
    window.makeKeyAndVisible()
    window.frame = bounds
    let view = DialogView()
    view.overlayWindow = window
    view.frame = window.bounds
    view.animate(isShowing: true)
    window.addSubview(view)
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    endEditing(true)
  }
}

