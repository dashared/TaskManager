//
//  Task.swift
//  TaskManager
//
//  Created by cstore on 23/04/2019.
//  Copyright © 2019 drHSE. All rights reserved.
//

import Foundation

// protocol
protocol TextDescriptive {
    static var key: String { get }
}

struct Task: TextDescriptive {
    
    static var key: String {
        return "Task"
    }
    
    var name: String
    var info: String
    var dueDate: String
    var status: TaskStatus
    
    init(name: String, info: String, date: String, status: TaskStatus = .todo) {
        self.dueDate = date
        self.name = name
        self.info = info
        self.status = status
    }
    
    init(from dictinary: [String:Any?]) {
        self.dueDate = dictinary[TaskFields.date.rawValue] as? String ?? ""
        self.name = dictinary[TaskFields.name.rawValue] as? String ?? ""
        self.info = dictinary[TaskFields.info.rawValue] as? String ?? "Me"
        self.status = dictinary[TaskFields.status.rawValue] as? TaskStatus ?? .todo
    }
    
    func toDictionary() -> [String: Any] {
        return [
            TaskFields.date.rawValue: dueDate,
            TaskFields.name.rawValue: name,
            TaskFields.info.rawValue: info,
            TaskFields.status.rawValue: status.rawValue
        ]
    }
}

enum TaskFields: String {
    case date = "date"
    case name = "name"
    case info = "info"
    case status = "status"
}


enum TaskStatus: String {
    case inprogress
    case done
    case todo 
}
