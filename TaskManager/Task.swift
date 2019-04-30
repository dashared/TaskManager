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
    var dueDate: Date
    var status: TaskStatus
    
    init(name: String, info: String, date: Date, status: TaskStatus = .todo) {
        self.dueDate = date
        self.name = name
        self.info = info
        self.status = status
    }
    
    init(from dictinary: [String:Any?]) {
        self.dueDate = dictinary[TaskFields.date.rawValue] as? Date ?? Date()
        self.name = dictinary[TaskFields.name.rawValue] as? String ?? ""
        self.info = dictinary[TaskFields.info.rawValue] as? String ?? "Me"
        self.status = TaskStatus(rawValue: dictinary[TaskFields.status.rawValue] as? Int ?? 0) ?? .todo
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


enum TaskStatus: Int {
    case inprogress = 1
    case done = 2
    case todo = 0
}


extension Date {
    
    /// Extention method to present date in a string format dd MMM yyyy
    func toStringFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
}
