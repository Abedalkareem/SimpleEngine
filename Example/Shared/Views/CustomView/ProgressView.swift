//
//  ProgressView.swift
//  Pods-Virus
//
//  Created by abedalkareem omreyh on 19/03/2020.
//

import UIKit

@IBDesignable
open class ProgressView: UIView {

  public typealias ProgressDidUpdate = (CGFloat) -> Void

  // MARK: - IBInspectables

  ///
  /// An image to set as a background.
  ///
  @IBInspectable open var backgroundImage: UIImage = UIImage() {
    didSet {
      updateBackgroundImage()
    }
  }

  ///
  /// An image to show for the progress.
  ///
  @IBInspectable open var progressImage: UIImage = UIImage()  {
    didSet {
      updateProgressImages()
    }
  }

  ///
  /// An image to show as a background for the progress.
  ///
  @IBInspectable open var progressBackgroundImage: UIImage = UIImage()  {
    didSet {
      updateProgressImages()
    }
  }

  // MARK: - Properties

  ///
  /// Progress. The default value is `0`.
  ///
  open var progress: CGFloat = 0 {
    didSet {
      progressUpdated()
      _progressDidUpdate?(progress)
    }
  }

  // MARK: - Private properties

  private var backgroundImageView: UIImageView!
  private var progressBackgroundImageView: UIImageView!
  private var progressImageView: UIImageView!

  private var _progressDidUpdate: ProgressDidUpdate?

  private var progressWidthAnchor: NSLayoutConstraint!

  // MARK: - init

  override public init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required public init(coder: NSCoder) {
    super.init(coder: coder)!
    setup()
  }

  private func setup() {

    backgroundColor = .clear

    backgroundImageView = UIImageView()
    backgroundImageView.contentMode = .scaleToFill
    addSubview(backgroundImageView)

    progressBackgroundImageView = UIImageView()
    progressBackgroundImageView.contentMode = .scaleToFill
    addSubview(progressBackgroundImageView)

    progressImageView = UIImageView()
    progressImageView.contentMode = .scaleToFill
    addSubview(progressImageView)

    makeConstraints()
  }

  private func makeConstraints() {

    let spacing: CGFloat = 16
    let topSpacing: CGFloat = 14
    progressBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      progressBackgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -topSpacing),
      progressBackgroundImageView.topAnchor.constraint(equalTo: topAnchor, constant: topSpacing),
      progressBackgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
      progressBackgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing)
    ])


    progressImageView.translatesAutoresizingMaskIntoConstraints = false
    progressWidthAnchor = progressImageView.widthAnchor.constraint(equalToConstant: 0)
    NSLayoutConstraint.activate([
      progressImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -topSpacing),
      progressImageView.topAnchor.constraint(equalTo: topAnchor, constant: topSpacing),
      progressWidthAnchor,
      progressImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing)
    ])

    backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
      backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
    ])
  }

  private func updateBackgroundImage() {
    backgroundImageView.image = backgroundImage
      .resizableImage(withCapInsets: UIEdgeInsets(top: 13, left: 15, bottom: 13, right: 15))
  }

  private func updateProgressImages() {
    progressBackgroundImageView.image = progressBackgroundImage
      .resizableImage(withCapInsets: UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10))

    progressImageView.image = progressImage
      .resizableImage(withCapInsets: UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10))
  }

  // MARK: - View lifecycle

  open override func layoutSubviews() {
    super.layoutSubviews()
    updateBackgroundImage()
  }

  private func progressUpdated() {
    let progress = self.progress
    let progressWidth = self.progressBackgroundImageView
    .frame.width
    UIView.animate(withDuration: 0.5) {
      self.progressWidthAnchor.constant = progress * progressWidth
      self.layoutIfNeeded()
    }
  }

  // MARK: - Public methods

  ///
  /// Update the progress.
  ///
  open func update(_ number: CGFloat) {
    progress = number
  }

  ///
  /// It will be called whenever the progress updated.
  ///
  open func progressDidUpdate(_ progressDidUpdate: @escaping ProgressDidUpdate) {
    self._progressDidUpdate = progressDidUpdate
  }
}
