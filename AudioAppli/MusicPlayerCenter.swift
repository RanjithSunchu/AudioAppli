//
//  MusicPlayerCenter.swift
//  MusicApp
//
//  Created by HungDo on 7/25/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation
import AVFoundation

class MusicPlayerCenter {
    
    enum MusicPlayerState {
        case played
        case paused
        case stopped
    }
    
    fileprivate var internalState: MusicPlayerState = .stopped
    
    fileprivate var internalPlayingSong: Song?
    
    fileprivate var player: AVAudioPlayer!
    
    var state: MusicPlayerState {
        return internalState
    }
    
    var playingSong: Song? {
        return internalPlayingSong
    }
    
    var duration: TimeInterval {
        return player.duration
    }
    
    var volume: Float {
        get {
            return player.volume
        }
        set {
            player.volume = newValue
        }
    }
    
    var currentTime: TimeInterval {
        get {
            return player.currentTime
        }
        set {
            player.currentTime = newValue
        }
    }
    
    var playing: Bool {
        return player.isPlaying
    }
    
    var startedTime: (minute: Int, second: Int) {
        let currentTime = Float(player.currentTime)
        return (Int(currentTime / 60), Int(currentTime.truncatingRemainder(dividingBy: 60)))
    }
    
    var remainingTime: (minute: Int, second: Int) {
        let remainingTime = Float(player.duration - player.currentTime)
        return (Int(remainingTime / 60), Int(remainingTime.truncatingRemainder(dividingBy: 60)))
    }
    
    func playWithSong(_ song: Song) {
        if song.title == internalPlayingSong?.title {
            if internalState == .paused {
                internalState = .played
                player.play()
            }
            return
        }
        
        guard let path = Bundle.main.path(forResource: song.url, ofType: "mp3") else { return }
        guard let player = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path)) else { return }
            
        internalPlayingSong = song
        internalState = .played
        self.player = player
            
        player.play()
    }
    
    func pause() {
        internalState = .paused
        player.pause()
    }
    
    func destroy() {
        internalState = .stopped
        player = nil
    }
    
}
