//
//  ViewController.swift
//  ChartTracker
//
//  Created by Nicholas Repaci on 7/30/21.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var getChart: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tickerTextField: UITextField!
    @IBOutlet weak var chartDetailsLabel: UILabel!
    @IBOutlet weak var tickerLine: UIView!
    @IBOutlet weak var dateLine: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var enterTickerLabel: UILabel!
    @IBOutlet weak var parentViewToEntryFields: UIView!
    @IBOutlet weak var logOutButton: UIButton!
    let api = API()
    let animations = Animations()
    var selectedDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getChart.translatesAutoresizingMaskIntoConstraints = true
        getChart.backgroundColor = UIColor.init(red: 66/255, green: 63/255, blue: 62/255, alpha: 1)
        getChart.layer.cornerRadius = 15
        imageView.isUserInteractionEnabled = true
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchGesture))
        imageView.addGestureRecognizer(pinchGesture)
        
        //keyboard dismissal funciton
        self.hideKeyboardWhenTappedAround()
        animations.animateLines(view1: tickerLine, view2: dateLine)
        animations.animateParentViewToFormFields(view: parentViewToEntryFields)
        activityIndicator.hidesWhenStopped = true
    }
    
    @IBAction func getChart(_ sender: Any) {
        animations.animateGetChartButton(button: getChart)
        api.convertDateForApi(datePicker: datePicker)
        api.getDataFromApi(clearEnterTickerLabel: enterTickerLabel, tickerEntered: tickerTextField, imageView: imageView, activityIndicator: activityIndicator)
        updateChartLabel()
    }
    @IBAction func logOutButtonClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "logOutSegue", sender: nil)
            print("worked")
        } catch let error {
            print(error)
        }
    }
    
    func updateChartLabel() {
        //self.tickerTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters
        chartDetailsLabel.text = tickerTextField.text
    }
    
    @objc func pinchGesture(sender: UIPinchGestureRecognizer) {
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        sender.scale = 1.0
    }
}

//allows dismissal of keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
