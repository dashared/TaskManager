//
//  DataStorage.swift
//  TaskManager
//
//  Created by cstore on 28/04/2019.
//  Copyright © 2019 drHSE. All rights reserved.
//

import Foundation

protocol StoredData {
    
    associatedtype Element: TextDescriptive
    
    func getData() -> [Element]
    
    func saveData(with new: [Element])
    
    func addData(_ data: Element)
    
    func changeData(at index: Int, with status: TaskStatus)
    
    func deleteData(at index: Int)
}

/*
 Class for storing all of the information using UserDefaults
 Functions:
     1. Get tasks
     2. Save tasks
     3. Delete tasks
     4. Change tasks
 */
class DataStorage: StoredData {
    
    typealias Element = Task
    
    private init(){}
    
    static let standard = DataStorage()
    
    func getData() -> [Task] {
        let dictionaries = UserDefaults.standard.array(forKey: Element.key) as? [[String:Any?]] ?? []
        
        var gettableData: [Task] = []
        
        for el in dictionaries {
            gettableData.append(Task(from: el))
        }
        
        return gettableData
    }
    
    func saveData(with new: [Task]) {
        var dictionaries: [[String: Any?]] = []
        for d in new {
            dictionaries.append(d.toDictionary())
        }
        UserDefaults.standard.set(dictionaries, forKey: Element.key)
    }
    
    func addData(_ data: Task) {
        var dataArr = getData()
        dataArr.append(data)
        saveData(with: dataArr)
    }
    
    func changeData(at index: Int, with status: TaskStatus)
    {
        var data = getData()
        data[index].status = status
        saveData(with: data)
    }
    
    func deleteData(at index: Int) {
        var data = getData()
        data.remove(at: index)
        saveData(with: data)
    }
    
}
