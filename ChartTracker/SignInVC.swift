//
//  SignInVC.swift
//  ChartTracker
//
//  Created by Nicholas Repaci on 8/1/21.
//

import Foundation
import UIKit
import GoogleSignIn
import AVFoundation

class SignInVC: UIViewController {
    
    @IBOutlet weak var videoView: UIView!
    let emitter = Emitter()
    var player: AVPlayer?
    @IBOutlet weak var updateLabel: UIButton!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //observes notification of successful login
        NotificationCenter.default.addObserver(self, selector: #selector(didSignIn), name: NSNotification.Name("SignIn"), object: nil)
        GIDSignIn.sharedInstance()?.presentingViewController = self
        loadBackgroundVideo()
        
    }
    @IBAction func updateLabelCLicked(_ sender: Any) {
        userEmailLabel.text = "gurt"
    }
    
    @objc func didSignIn()  {
        //pushes new VC after successful login
        performSegue(withIdentifier: "loginSegue", sender: self)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    private func loadBackgroundVideo(){
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "stockmarket", ofType: "mov")!)
        let player = AVPlayer(url: path)
        
        let newLayer = AVPlayerLayer(player: player)
        newLayer.frame = self.videoView.frame
        self.videoView.layer.addSublayer(newLayer)
        newLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        player.play()
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        
        NotificationCenter.default.addObserver(self, selector: #selector(videoReachEnd(_:)), name: NSNotification.Name(rawValue: "AVPlayerItemDidPlayToEndTimeNotification"), object: player.currentItem)
        self.player?.isMuted = true
        
    }
    
    //replay video once it reaches the end
    @objc func videoReachEnd (_ notification: Notification) {
        let player: AVPlayerItem = notification.object as! AVPlayerItem
        player.seek(to: CMTime.zero)
        
    }
}
