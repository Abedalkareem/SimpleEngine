//
//  MovingBackgroundView.swift
//  Pods-Virus
//
//  Created by abedalkareem omreyh on 10/03/2020.
//

import UIKit

class MovingBackgroundView: UIView {

  // MARK: - Properties

  public var view: UIView? {
    didSet {
      oldValue?.removeFromSuperview()
      setup()
    }
  }

  // MARK: - Private properties

  private var secondView: UIView? {
     didSet {
       oldValue?.removeFromSuperview()
     }
   }
  // MARK: - init

  public init(view: UIView) {
    super.init(frame: .zero)
    self.view = view
    setup()
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    secondView = view?.snapshotView(afterScreenUpdates: true)
    if let view = view, let secondView = secondView {
      addSubview(view)
      addSubview(secondView)
    }

    animate()
    animateSecondView()
  }

  private func animate() {
    guard let view = view else {
      return
    }
    let orginalFrame = bounds
    var newFrame = orginalFrame
    newFrame.origin.x = -orginalFrame.size.width
    view.frame = newFrame
    UIView.animate(withDuration: 1, delay: 0, options: [.repeat], animations: {
      view.frame = orginalFrame
    })
  }

  private func animateSecondView() {
    guard let secondView = secondView else {
      return
    }
    let orginalFrame = bounds
    var newFrame = orginalFrame
    newFrame.origin.x = +orginalFrame.size.width
    secondView.frame = orginalFrame
    UIView.animate(withDuration: 1, delay: 0, options: [.repeat], animations: {
      secondView.frame = newFrame
    })
  }
}
