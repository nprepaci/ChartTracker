//
//  API.swift
//  ChartTracker
//
//  Created by Nicholas Repaci on 8/8/21.
//

import Foundation
import UIKit

class API {
    
    var selectedDate = ""
    
    func getDataFromApi(clearEnterTickerLabel: UILabel, tickerEntered: UITextField, imageView: UIImageView, activityIndicator: UIActivityIndicatorView) {
        
        clearEnterTickerLabel.text = ""
        activityIndicator.startAnimating()
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        guard let url = URL(string: "http://api.tradingphysics.com/getchart?type=pi&date=\(selectedDate)&stock=\(tickerEntered.text ?? "")&days=1") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Something went wrong: \(error)")
                activityIndicator.stopAnimating()
            }
            
            if let imageData = data {
                // The UI should be updated from the main thread
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: imageData)
                    activityIndicator.stopAnimating()
                }
            }
        }
        .resume()
    }
    
    func convertDateForApi(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        selectedDate = dateFormatter.string(from: datePicker.date)
    }
}
