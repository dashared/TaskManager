//
//  NewTaskViewController.swift
//  TaskManager
//
//  Created by cstore on 28/04/2019.
//  Copyright © 2019 drHSE. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dateTimeOfTask: UIDatePicker!
    
    @IBOutlet weak var statusOfTask: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
    }
    
    func setUpNavigationBar(){
        navigationItem.title = "New task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveTask))
    }
    
    // TODO: - add logic
    @objc func saveTask(){
        DataStorage.standard.addData(Task(name: "No", info: "Nothing", date: "today", status: .todo))
        navigationController?.popViewController(animated: true)
    }
}

extension NewTaskViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


