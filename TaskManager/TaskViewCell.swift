//
//  TaskViewCell.swift
//  TaskManager
//
//  Created by cstore on 23/04/2019.
//  Copyright © 2019 drHSE. All rights reserved.
//

import UIKit
import TaskInfoKit

class TaskViewCell: UITableViewCell {

    @IBOutlet weak var taskNameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// Method to fill up the content of the cell
    ///
    /// - Parameter task: The task to be displayed in the cell
    func fill(with task: Task){
        taskNameLabel.text = task.name
        dateLabel.text = "due to \(task.dueDate.toStringFormat())"
        infoLabel.text = task.info
    }
}
