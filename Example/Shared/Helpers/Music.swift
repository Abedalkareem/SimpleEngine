//
//  Music.swift
//  Virus
//
//  Created by abedalkareem omreyh on 14/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import Foundation
import SimpleEngine

enum Music: String, MusicType {

  var format: String {
    var type: Type!
    switch self {
    case .mainMenu:
      type = .wav
    case .gameBackground:
      type = .wav
    case .gameOver:
      type = .mp3
    case .bodyScreen:
      type = .mp3
    case .buttonClicked:
      type = .wav
    case .fire:
      type = .wav
    case .win:
      type = .mp3
    case .liveDestroyed:
      type = .wav
    case .finalFight:
      type = .mp3
    case .virusVoice:
      type = .mp3
    }
    return type.rawValue
  }

  case mainMenu = "main_menu"
  case gameBackground = "new_battle"
  case gameOver = "game_over"
  case bodyScreen = "levels"
  case fire = "fire"
  case buttonClicked = "button_clicked"
  case win = "victory"
  case liveDestroyed = "explosion"
  case finalFight = "final_fight"
  case virusVoice = "virus_voice"
}

enum Type: String {
  case mp3
  case wav
}
