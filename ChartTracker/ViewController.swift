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
    
    @IBOutlet weak var dateTickerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getChart.backgroundColor = UIColor.init(red: 66/255, green: 63/255, blue: 62/255, alpha: 1)
        getChart.layer.cornerRadius = 15
        
        imageView.isUserInteractionEnabled = true
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchGesture))
        imageView.addGestureRecognizer(pinchGesture)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func getChart(_ sender: Any) {
        
        getDataFromApi()
        
    }
    
    func getDataFromApi() {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
                
        guard let url = URL(string: "http://api.tradingphysics.com/getchart?type=pi&date=20151230&stock=\(tickerTextField.text ?? "")&days=1") else { return }
                
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
        
        print(datePicker.date)
        
    }
    
    func updateChartLabel() {
        
    }
    
    @objc func pinchGesture(sender: UIPinchGestureRecognizer) {
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        sender.scale = 1.0
    }

}

