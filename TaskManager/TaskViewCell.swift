//
//  TaskViewCell.swift
//  TaskManager
//
//  Created by cstore on 23/04/2019.
//  Copyright © 2019 drHSE. All rights reserved.
//

import UIKit

class TaskViewCell: UITableViewCell {

    @IBOutlet weak var taskNameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fill(with task: Task){
        taskNameLabel.text = task.name
        dateLabel.text = "due to \(task.dueDate)"
        infoLabel.text = task.info
    }
}