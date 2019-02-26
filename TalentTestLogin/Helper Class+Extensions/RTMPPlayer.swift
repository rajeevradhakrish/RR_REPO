//
//  RTMPPlayer.swift
//  TalentTestLogin
//
//  Created by Rajeev Radhakrishnan on 21/02/2019.
//  Copyright © 2019 Rajeev Radhakrishnan. All rights reserved.
//

import Foundation


class RTMPPlayer
{
    var player: VLCMediaPlayer?
    
    init(with View:UIView)
    {
        player = VLCMediaPlayer()
        let width = Int(UIScreen.main.bounds.width)
        let height = Int(UIScreen.main.bounds.height)
        player?.videoAspectRatio = UnsafeMutablePointer<Int8>(mutating: "\(width):\(height)")
        player?.media = VLCMedia(url: URL(string: "rtmp://184.72.239.149/vod/BigBuckBunny_115k.mov")!)
        player?.drawable = View
    }
    
    func play()
    {
        if let player1 = player,!player1.isPlaying {
            player1.play()
        }
    }
    
    func stop()
    {
        if let player1 = player,player1.isPlaying {
            player1.stop()
        }
    }
}
