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
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
}
