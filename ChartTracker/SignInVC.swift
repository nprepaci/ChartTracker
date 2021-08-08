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
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    let emitter = Emitter()
    var player: AVPlayer?
    @IBOutlet weak var welcomeLabelGradient: UILabel!
    private var gradient: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //observes notification of successful login
        NotificationCenter.default.addObserver(self, selector: #selector(didSignIn), name: NSNotification.Name("SignIn"), object: nil)
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        DispatchQueue.main.async {
            self.loadBackgroundVideo()
        }
        
        animateLabel()
        setShadows(view: googleSignInButton)
        
    }
    
    @objc func didSignIn()  {
        //pushes new VC after successful login
        performSegue(withIdentifier: "loginSegue", sender: self)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    private func loadBackgroundVideo(){
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "trimmedCityWater", ofType: "mov")!)
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
    
    func animateLabel() {
        
        welcomeLabel.text = ""
            let titleText = "ChartTracker"
            var charIndex = 0.0
            for letter in titleText {
                Timer.scheduledTimer(withTimeInterval: 0.25 * charIndex, repeats: false) { (timer) in
                    self.welcomeLabel.text?.append(letter)
                }
                 charIndex += 1
            }
        welcomeLabel.layer.zPosition = 1
    }
    
    func setShadows(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 30
        
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
    }
}
