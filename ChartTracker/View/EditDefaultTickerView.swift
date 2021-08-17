//
//  EditDefaultTickerView.swift
//  ChartTracker
//
//  Created by Nicholas Repaci on 8/16/21.
//

import Foundation
import UIKit

class EditDefaultTickerView: UIViewController {
    
    @IBOutlet weak var tickerTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tickerTextField.text = UserDefaults.standard.string(forKey: "defaultTicker")
        saveButton.translatesAutoresizingMaskIntoConstraints = true
        saveButton.backgroundColor = UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        saveButton.layer.cornerRadius = 15
    }

    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        UserDefaults.standard.setValue(tickerTextField.text, forKey: "defaultTicker")
        DataManager.shared.settingsView.settingsTableView.reloadData()
        //dismiss(animated: true) no longer using, since embedded in navcontroller
        navigationController?.popViewController(animated: true) //this works with nav controller
        
    }
}
