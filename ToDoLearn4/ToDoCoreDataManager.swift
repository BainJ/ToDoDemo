//
//  ToDoCoreDataManager.swift
//  ToDoLearn4
//
//  Created by bain on 15-5-12.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit
import CoreData

var todoCoreDataManager: ToDoCoreDataManager = ToDoCoreDataManager()

class ToDoCoreDataManager: NSObject {
    var todoCoreData:[AnyObject]!
    var context:NSManagedObjectContext!
    
//    初始化
    func todoInit() {
        context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext //数据库上下文
        let coreData = NSFetchRequest(entityName: "ToDo1")
        todoCoreData = context?.executeFetchRequest(coreData, error: nil)
    }
    
    func findMaxId() -> Int {
        var maxId = 0
        if todoCoreData.count > 0 {
            for items in todoCoreData {
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
}