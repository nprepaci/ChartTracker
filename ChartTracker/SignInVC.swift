//
//  SignInVC.swift
//  ChartTracker
//
//  Created by Nicholas Repaci on 8/1/21.
//

import Foundation
import UIKit
import GoogleSignIn

class SignInVC: UIViewController {
    
    @IBOutlet weak var updateLabel: UIButton!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //observes notification of successful login
        NotificationCenter.default.addObserver(self, selector: #selector(didSignIn), name: NSNotification.Name("SignIn"), object: nil)
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
    }
    @IBAction func updateLabelCLicked(_ sender: Any) {
        userEmailLabel.text = "gurt"
    }
    
    @objc func didSignIn()  {
        //pushes new VC after successful login
      navigationController?.pushViewController(ViewController(), animated: true)

    }

//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
}
