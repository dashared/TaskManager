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
    
    func getDataFromDataBase() -> [Element]
    
    func saveData(with new: [Element])
    
    func addData(_ data: Element)
    
    func changeData(at index: Int, with newData: Task)
    
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
public class DataStorage: StoredData {
    
    let dataBase = UserDefaults(suiteName: "group.rednikina.com.drHSE.TaskManager")
    
    typealias Element = Task
    
    private init(){}
    
    public static let standard = DataStorage()
    
    public func getDataFromDataBase() -> [Task] {
        
        let dictionaries = dataBase!.array(forKey: Element.key) as? [[String:Any?]] ?? []
        
        var gettableData: [Task] = []
        
        for el in dictionaries {
            gettableData.append(Task(from: el))
        }
        
        return gettableData
    }
    
    public func saveData(with new: [Task])
    {
        var dictionaries: [[String: Any?]] = []
        
        for d in new {
            dictionaries.append(d.toDictionary())
        }
        
        dataBase?.set(dictionaries, forKey: Element.key)
    }
    
    public func addData(_ data: Task) {
        var dataArr = getDataFromDataBase()
        dataArr.insert(data, at: 0)
        saveData(with: dataArr)
    }
    
    public func changeData(at index: Int, with newData: Task)
    {
        var data = getDataFromDataBase()
        data[index] = newData
        saveData(with: data)
    }
    
    public func deleteData(at index: Int) {
        var data = getDataFromDataBase()
        data.remove(at: index)
        saveData(with: data)
    }
    
}
