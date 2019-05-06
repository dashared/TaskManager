//
//  TodayViewController.swift
//  TaskForToday
//
//  Created by cstore on 30/04/2019.
//  Copyright © 2019 drHSE. All rights reserved.
//

import UIKit
import NotificationCenter
import TaskInfoKit

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var taskButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reload()
    }
    
    @IBAction func openCurrentTask(_ sender: UIButton) {
        
        let url = URL(string: "TaskManager://")!
        extensionContext?.open(url, completionHandler: nil)
        
    }
    /// Function to reload data when viewDidLoad is called
    /// Gets all info and filters needed information
    func reload(){
        let now = Date()
        print("\(DataStorage.standard.getDataFromDataBase())")
        let currentTask = DataStorage.standard.getDataFromDataBase()
            .filter { Calendar.current.compare(now, to: $0.dueDate, toGranularity: .day) == .orderedSame && $0.status != .done }
            .first
        
        if let currentTask = currentTask {
            nameLabel.text = currentTask.name
            statusLabel.text = "\(currentTask.status)"
        } else {
            nameLabel.text = "Nothing to display"
            statusLabel.text = ""
        }
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
