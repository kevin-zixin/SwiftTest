//
//  KVVideoPlayer.swift
//  SwiftTest
//
//  Created by kevin on 7/4/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import MediaPlayer
class KVVideoPlayer: NSObject {
    var kvPlayer = MPMoviePlayerController()
    override init() {
        kvPlayer.controlStyle = MPMovieControlStyle.Default
        kvPlayer.shouldAutoplay = true
        kvPlayer.movieSourceType = MPMovieSourceType.Streaming
    }
    func startPlaying(urlStr:String) {
        kvPlayer.contentURL = NSURL(string: urlStr)
        kvPlayer.prepareToPlay()
        kvPlayer.play()
    }
    
}
