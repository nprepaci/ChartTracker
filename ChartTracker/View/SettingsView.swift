//
//  SettingsView.swift
//  ChartTracker
//
//  Created by Nicholas Repaci on 8/13/21.
//

import Foundation
import UIKit

class SettingsView: UIViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!

    var placeholderArray = [
        ["item1", "item 2", "item3"],
        ["1","2","3","4"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        DataManager.shared.settingsView = self
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
}

extension SettingsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "updateDefaultTicker", sender: self)
    }
}

extension SettingsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        return "Preferences"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
       // return placeholderArray.count
        //return 2
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return placeholderArray[section].count
        //return 7
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = "Default Ticker"
        cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: "defaultTicker")
        //cell.textLabel?.text = placeholderArray[indexPath.section][indexPath.row]
       // cell.textLabel?.text = placeholderArray[indexPath.row]
        return cell
    }
}

