//
//  MusciPlayer.swift
//  SimpleEngine
//
//  Created by abedalkareem omreyh on 7/31/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit
import AVFoundation

open class MusicPlayer {

  ///
  /// A singleton object to use the music player.
  ///
  public static let shared = MusicPlayer()

  // MARK: - Properties

  ///
  /// To check if the background audio is playing or not.
  ///
  open var isPlaying = false

  // MARK: - Private properties

  ///
  /// An ongoing audio playing in the background.
  ///
  private var backgroundAudioPlayer: AVAudioPlayer?

  ///
  /// A audio to play one time.
  ///
  private var subAudioPlayer: AVAudioPlayer?

  ///
  /// Start playing the background music for ever.
  ///
  open func playBackgroundMusicWith<M: MusicType>(music: M) {
    let path = Bundle.main.path(forResource: music.rawValue, ofType: music.format)!
    let url = URL(fileURLWithPath: path)
    do {
      backgroundAudioPlayer = try AVAudioPlayer(contentsOf: url)
      backgroundAudioPlayer?.numberOfLoops = .max
      backgroundAudioPlayer?.volume = 0.4
    } catch {
      print(error.localizedDescription)
    }
    backgroundAudioPlayer?.play()
    isPlaying = true
  }

  ///
  /// Pause background music.
  ///
  func pauseBackgroundMusic() {
    backgroundAudioPlayer?.pause()
    isPlaying = false
  }

  ///
  /// Play a music one time.
  ///
  open func playMusic<M: MusicType>(music: M) {
    guard let path = Bundle.main.path(forResource: music.rawValue, ofType: music.format) else {
      return
    }
    let url = URL(fileURLWithPath: path)
    do {
      subAudioPlayer = try AVAudioPlayer(contentsOf: url)
      subAudioPlayer?.play()
    } catch {
      print(error.localizedDescription)
    }
  }
}

public protocol MusicType: RawRepresentable where RawValue == String {
  var format: String { get }
}
