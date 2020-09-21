//
//  StreamBackgroundView.swift
//  Virus
//
//  Created by abedalkareem omreyh on 11/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import UIKit

class StreamBackgroundView: UIView {

  // MARK: - Private properties

  private var topWallImageView: UIImageView!
  private var bottomWallImageView: UIImageView!
  private var stringsImageView: UIImageView!

  // MARK: - init

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  private func setup() {

    stringsImageView = UIImageView()
    stringsImageView.image = #imageLiteral(resourceName: "moving_strings")
    stringsImageView.contentMode = .scaleAspectFill
    addSubview(stringsImageView)

    topWallImageView = UIImageView()
    topWallImageView.image = #imageLiteral(resourceName: "top_wall")
    topWallImageView.contentMode = .scaleAspectFill
    addSubview(topWallImageView)

    bottomWallImageView = UIImageView()
    bottomWallImageView.image = #imageLiteral(resourceName: "bottom_wall")
    bottomWallImageView.contentMode = .scaleAspectFill
    addSubview(bottomWallImageView)

    makeConstraints()
  }

  private func makeConstraints() {

    topWallImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      topWallImageView.topAnchor.constraint(equalTo: topAnchor),
      topWallImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      topWallImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      topWallImageView.heightAnchor.constraint(equalToConstant: 30)
    ])

    bottomWallImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      bottomWallImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      bottomWallImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      bottomWallImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      bottomWallImageView.heightAnchor.constraint(equalToConstant: 30)
    ])

    stringsImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stringsImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      stringsImageView.topAnchor.constraint(equalTo: topAnchor),
      stringsImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stringsImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
    ])
  }

}
