//
//  HabitManager.swift
//  ToDoLearn4
//
//  Created by bain on 15-5-18.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit
import CoreData

var habitManager: HabitManager = HabitManager()
class HabitManager: NSObject {
    var habitCoreData:[AnyObject]!
    var context:NSManagedObjectContext!
    
    //    初始化
    override init() {
        context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext //数据库上下文
        let coreData = NSFetchRequest(entityName: "Habit")
        habitCoreData = context?.executeFetchRequest(coreData, error: nil)
    }
    
    func findMaxId() -> Int {
        var maxId = 0
        if habitCoreData.count > 0 {
            for items in habitCoreData {
                let id = items.valueForKey("id") as Int
                if id > maxId {
                    maxId = id
                }
            }
            
            return maxId
        } else {
            return 0
        }
    }
    
    func getHabitName(id: Int) -> String{
        var returnName = ""
        for items in habitCoreData {
            if (items.valueForKey("id") as Int) == id {
                returnName = items.valueForKey("name") as String
            }
        }
        return returnName
    }
    
    func deleteData(deleteDate: AnyObject) {
        context.deleteObject(deleteDate as NSManagedObject)
        context.save(nil)
    }
}