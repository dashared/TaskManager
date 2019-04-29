//
//  ViewController.swift
//  TaskManager
//
//  Created by cstore on 23/04/2019.
//  Copyright © 2019 drHSE. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    
    var currentTasks = [Task]()
    
    var dictFilter : [Int: ((Task)->(Bool))] = [
        0 : { $0.status == .todo },
        1 : { $0.status == .inprogress },
        2 : { $0.status == .done }
    ]

    @IBOutlet weak var tasksTableView: UITableView!
    
    @IBOutlet weak var taskStatusControl: UISegmentedControl!
    
    func reload(){
        currentTasks = DataStorage.standard.getData().filter(dictFilter[taskStatusControl.selectedSegmentIndex]!)
        tasksTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        setUpNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }

    fileprivate func setUpNavigationBar(){
        navigationItem.title = "Tasks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewTask))
    }
    
    @objc func createNewTask(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateTask") as! NewTaskViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func changedStatusFilter(_ sender: UISegmentedControl) {
        reload()
    }
}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskViewCell
        cell.fill(with: currentTasks[indexPath.row])
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //
//    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
//    {
//
//    }
}

