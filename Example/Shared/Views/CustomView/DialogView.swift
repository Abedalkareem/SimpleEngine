//
//  DialogView.swift
//  Virus
//
//  Created by abedalkareem omreyh on 19/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import UIKit

class DialogView: UIView {

  typealias ActionPressed = (Action) -> Void

  // MARK: - Properties

  var cancelWhenFirstButtonClick = false

  ///
  /// Dialog text.
  ///
  var text: String = "" {
    didSet {
      label.text = text
    }
  }
  ///
  /// First button title text.
  ///
  var firstButtonText: String = "" {
     didSet {
      firstButton.setTitle(firstButtonText, for: .normal)
     }
   }
  ///
  /// Second button title text.
  ///
  var secondButtonText: String = "" {
     didSet {
       secondButton.setTitle(secondButtonText, for: .normal)
     }
   }

  // MARK: - Private properties

  private var blurEffectView: UIVisualEffectView!
  private var containerView: UIView!
  private var label: UILabel!
  private var firstButton: AppButton!
  private var secondButton: AppButton!
  private var backgroundImageView: UIImageView!

  private var _actionPressed: ActionPressed?

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
    addButtons()

    makeConstraints()

    setNeedsFocusUpdate()
    updateFocusIfNeeded()
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
    label.text = text
    label.font = UIFont(name: Constants.Strings.fontName, size: isTV ? 32 : 17)
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = .black
    containerView.addSubview(label)
  }

  private func addButtons() {
    firstButton = AppButton()
    firstButton.setTitle(firstButtonText, for: .normal)
    firstButton.titleLabel?.font = UIFont(name: Constants.Strings.fontName, size: isTV ? 32 : 17)
    firstButton.setTitleColor(.black, for: .normal)
    firstButton.addTarget(self, action: #selector(first), for: .touchUpInside)
    firstButton.addTarget(self, action: #selector(first), for: .primaryActionTriggered)
    containerView.addSubview(firstButton)

    secondButton = AppButton()
    secondButton.setTitle(secondButtonText, for: .normal)
    secondButton.titleLabel?.font = UIFont(name: Constants.Strings.fontName, size: isTV ? 32 : 17)
    secondButton.setTitleColor(.black, for: .normal)
    secondButton.addTarget(self, action: #selector(second), for: .touchUpInside)
    secondButton.addTarget(self, action: #selector(second), for: .primaryActionTriggered)
    containerView.addSubview(secondButton)
  }

  private func makeConstraints() {
    blurEffectView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      blurEffectView.topAnchor.constraint(equalTo: topAnchor),
      blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
      blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
      blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor)
    ])

    containerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
      containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
      containerView.widthAnchor.constraint(equalToConstant: isTV ? 500 : 250),
      containerView.heightAnchor.constraint(equalToConstant: isTV ? 300 : 150)
    ])

    backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      backgroundImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
      backgroundImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
      backgroundImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      backgroundImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
    ])

    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
      label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
    ])

    firstButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      firstButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
      firstButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
    ])

    secondButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      secondButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
      secondButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
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

  @objc
  private func second() {
    dismiss { _ in
      self._actionPressed?(.second)
    }
  }

  @objc
  private func first() {
    guard cancelWhenFirstButtonClick else {
      _actionPressed?(.first)
      return
    }

    dismiss { _ in
      self._actionPressed?(.first)
    }
  }

  // MARK: -

  func actionPressed(actionPressed: @escaping ActionPressed) {
    self._actionPressed = actionPressed
  }

  func dismiss(completion: ((Bool) -> Void)? = nil) {
    animate(isShowing: false, completion: completion)
  }

  // MARK: - Animation

  func animate(isShowing: Bool, completion: ((Bool) -> Void)? = nil) {
    UIView.animate(withDuration: 0.5,
                   animations: {
      self.alpha = isShowing ? 1 : 0
    }, completion: { finished in
      if !isShowing {
        self.removeFromSuperview()
        completion?(finished)
      }
    })
  }

  // MARK: - Show

  @discardableResult
  class func show(in view: UIView,
                  text: String,
                  firstButton: String,
                  secondButton: String,
                  cancelWhenFirstButtonClick: Bool = false,
                  actionPressed: @escaping ActionPressed) -> DialogView {
    let dialogView = DialogView()
    dialogView.frame = view.bounds
    dialogView.text = text
    dialogView.firstButtonText = firstButton
    dialogView.secondButtonText = secondButton
    dialogView.cancelWhenFirstButtonClick = cancelWhenFirstButtonClick
    dialogView.animate(isShowing: true)
    dialogView.actionPressed(actionPressed: actionPressed)
    view.addSubview(dialogView)
    return dialogView
  }

  // MARK: - Enum

  enum Action {
    case first
    case second
  }
}
