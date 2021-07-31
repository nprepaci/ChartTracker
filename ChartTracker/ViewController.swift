//
//  ViewController.swift
//  ChartTracker
//
//  Created by Nicholas Repaci on 7/30/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var getChart: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tickerTextField: UITextField!
    @IBOutlet weak var chartDetailsLabel: UILabel!
    @IBOutlet weak var tickerLine: UIView!
    @IBOutlet weak var dateLine: UIView!
    
    var selectedDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getChart.backgroundColor = UIColor.init(red: 66/255, green: 63/255, blue: 62/255, alpha: 1)
        getChart.layer.cornerRadius = 15
        
        imageView.isUserInteractionEnabled = true
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchGesture))
        imageView.addGestureRecognizer(pinchGesture)
        
        //keyboard dismissal funciton
        self.hideKeyboardWhenTappedAround()
        animateLines()
        
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func getChart(_ sender: Any) {
        animateGetChartButton()
        convertDateForApi()
        getDataFromApi()
        updateChartLabel()
        
    }
    
    func getDataFromApi() {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        guard let url = URL(string: "http://api.tradingphysics.com/getchart?type=pi&date=\(selectedDate)&stock=\(tickerTextField.text ?? "")&days=1") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Something went wrong: \(error)")
            }
            
            if let imageData = data {
                // The UI should be updated from the main thread
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData)
                }
            }
        }.resume()
        
    }
    
    func updateChartLabel() {
        
        //self.tickerTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters
        chartDetailsLabel.text = tickerTextField.text
    }
    
    func convertDateForApi() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        print(dateFormatter.string(from: datePicker.date))
        //return dateFormatter.string(from: datePicker.date)
        selectedDate = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func pinchGesture(sender: UIPinchGestureRecognizer) {
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        sender.scale = 1.0
    }
    
    func animateLines() {
        UIView.animate(withDuration: 0.6,
                       animations: {
                        self.tickerLine.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                        self.dateLine.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.6) {
                            self.tickerLine.transform = CGAffineTransform.identity
                            self.dateLine.transform = CGAffineTransform.identity
                        }
                       })
    }
    
    func animateGetChartButton() {
        UIView.animate(withDuration: 0.09,
                       animations: {
                        self.getChart.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.09) {
                            self.getChart.transform = CGAffineTransform.identity
                        }
                       })
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
