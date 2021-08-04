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
        //playBackground()
        GIDSignIn.sharedInstance()?.presentingViewController = self
       // emitter.particleEmitter(view: view, fileName: "MovingBackground", xval: 0, yval: 0)
        setUpView()
        
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
    
    
    private func setUpView(){
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "stockmarket", ofType: "mov")!)
          //let path = Bundle.main.path(forResource: "video", ofType: "mp4")
        let player = AVPlayer(url: path)
        
        let newLayer = AVPlayerLayer(player: player)
        newLayer.frame = self.videoView.frame
        self.videoView.layer.addSublayer(newLayer)
        newLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        player.play()
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
    
//        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.videoRe), name:  NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
//          player!.seek(to: CMTime.zero)
//          player!.play()
//          self.player?.isMuted = true
          
      }
      
    @objc func videoReachEnd (_ notification: Notification) {
        let player: AVPlayerItem = notification.object as! AVPlayerItem
        //player.seek(to: kCMTimeZero)
        player.seek(to: CMTime.zero)
         
      }
}
