//
//  VideoPlayer.swift
//  ChartTracker
//
//  Created by Nicholas Repaci on 8/8/21.
//

import Foundation
import UIKit
import AVFoundation

class VideoPlayer {
    func loadBackgroundVideo(videoView: UIView){
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "trimmedCityWater", ofType: "mov")!)
        let player = AVPlayer(url: path)
        
        let newLayer = AVPlayerLayer(player: player)
        newLayer.frame = videoView.frame
        videoView.layer.addSublayer(newLayer)
        newLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        player.play()
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        
        NotificationCenter.default.addObserver(self, selector: #selector(videoReachEnd(_:)), name: NSNotification.Name(rawValue: "AVPlayerItemDidPlayToEndTimeNotification"), object: player.currentItem)
            player.isMuted = true
        
    }
    
    //replay video once it reaches the end
    @objc func videoReachEnd (_ notification: Notification) {
        let player: AVPlayerItem = notification.object as! AVPlayerItem
        player.seek(to: CMTime.zero)
        
    }
}
