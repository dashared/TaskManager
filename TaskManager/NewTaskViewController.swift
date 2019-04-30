//
//  NewTaskViewController.swift
//  TaskManager
//
//  Created by cstore on 28/04/2019.
//  Copyright © 2019 drHSE. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    @IBOutlet weak var dateTimeOfTask: UIDatePicker!
    
    @IBOutlet weak var statusOfTask: UISegmentedControl!
    
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var noteTextView: UITextView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    var currentTask: (index: Int, task: Task)?
    
    /// Dictionary to map selectedSegmentIndex of segmentedControl with task status it means
    let statusDict : [Int: TaskStatus] = [
        0: .todo,
        1: .inprogress,
        2: .done
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        magicForKeyboardChanges()
        guard let currentT = currentTask else { return }
        
        noteTextView.text = currentT.task.info
        nameLabel.text = currentT.task.name
        dateTimeOfTask.date = currentT.task.dueDate
        statusOfTask.selectedSegmentIndex = currentT.task.status.rawValue
    }
    
    func setUpNavigationBar(){
        navigationItem.title = "New task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveTask))
    }
    
    /// Create and save task with parameters set
    @objc func saveTask()
    {
        let newTask = Task(name: nameLabel.text!, info: noteTextView.text, date: dateTimeOfTask.date, status: statusDict[statusOfTask.selectedSegmentIndex]!)
        if let changedTask = currentTask{
            DataStorage.standard.changeData(at: changedTask.index, with: newTask)
        } else {
            DataStorage.standard.addData(newTask)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    /// Mehtod to handle all the changes according to the position of the keyboard
    @objc func handleKeyboardNotifications(notification: NSNotification){
        if let userInfo = notification.userInfo{
            // UIKeyboardFrameEndUserInfoKey
            
            let keyBoardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            bottomConstraint?.constant = notification.name == UIResponder.keyboardWillShowNotification ? keyBoardFrame.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }) { (completed) in
                
            }
        }
    }
    
    /// Method to change position of textView bottom constraint to react to keyboard frame/size changes. Observers are added here
    func magicForKeyboardChanges()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotifications), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotifications), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension NewTaskViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}


