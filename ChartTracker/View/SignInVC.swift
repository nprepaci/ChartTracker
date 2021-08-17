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
    @IBOutlet weak var welcomeLabelGradient: UILabel!
    @IBOutlet weak var signInLaterButton: UIButton!
    @IBOutlet weak var loginButtonBackground: UIView!
    let emitter = Emitter()
    var player: AVPlayer?
    var videoPlayer = VideoPlayer()
    var animateLabel = AnimateLabelText()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //observes notification of successful login
        NotificationCenter.default.addObserver(self, selector: #selector(didSignIn), name: NSNotification.Name("SignIn"), object: nil)
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        videoPlayer.loadBackgroundVideo(videoView: videoView)
        
        
        setShadows(view: googleSignInButton)
        
        signInLaterButton.translatesAutoresizingMaskIntoConstraints = true
        signInLaterButton.backgroundColor = UIColor.init(red: 178/255, green: 184/255, blue: 163/255, alpha: 1)
        signInLaterButton.layer.cornerRadius = 15
        
        self.navigationController?.isNavigationBarHidden = true
        //loginButtonBackground.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        animateLabel.animateLabel(labelToAnimate: welcomeLabel)
    }
    
    @IBAction func signInLaterClicked(_ sender: Any) {
        performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
    @objc func didSignIn()  {
        //pushes new VC after successful login
        performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
