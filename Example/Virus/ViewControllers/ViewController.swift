//
//  ViewController.swift
//  Example
//
//  Created by abedalkareem omreyh on 07/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import UIKit
import SimpleEngine

class ViewController: BaseGameViewController {

  // MARK: - IBOutlets

  @IBOutlet weak var movingBackgroundView: MovingBackgroundView!

  // MARK: - Private properties

  private var virusSprite: VirusSpriteView!

  // MARK: - ViewController lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    addVirus()

    movingBackgroundView.view = UIImageView(image: #imageLiteral(resourceName: "moving_strings"))
  }

  private func addVirus() {
    virusSprite = VirusSpriteView()
    virusSprite.attachTo(analogView)
    virusSprite.frame.origin = CGPoint(x: 30, y: 30)
    sceneView.addSubview(virusSprite)
  }

}

