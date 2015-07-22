//
//  PomodoroHistoryManager.swift
//  ToDoLearn4
//
//  Created by bain on 15-5-21.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit
import CoreData

var pomodoroHistoryManager: PomodoroHistoryManager = PomodoroHistoryManager()

class PomodoroHistoryManager: NSObject {
    var pomodoroHistoryData:[AnyObject]!
    var dataByMonth = Dictionary<String, [AnyObject]>()
    var dataByDay = Dictionary<String, [AnyObject]>()
    var context:NSManagedObjectContext!
    
    func allInit() {
        pomodoroInit()
        dataByDay = Dictionary<String, [AnyObject]>()
        sortDataByDay()
    }
    
    func pomodoroInit() {
        context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext //数据库上下文
        let coreData = NSFetchRequest(entityName: "PomodoroHistory")
        pomodoroHistoryData = context?.executeFetchRequest(coreData, error: nil)
    }
    
    func addNewData(startTime: NSDate, endTime: NSDate, duration: Int) {
        let data: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("PomodoroHistory", inManagedObjectContext: context!)
        data.setValue(startTime, forKey: "starttime")
        data.setValue(endTime, forKey: "endtime")
        data.setValue("", forKey: "name")
        data.setValue(findMaxId() + 1, forKey: "id")
        data.setValue(duration, forKey: "duration")
        context?.save(nil)
        pomodoroInit()
//        println("\(pomodoroHistoryData)")
    }
    
    func findMaxId() -> Int {
        var maxId = 0
        if pomodoroHistoryData.count > 0 {
            for items in pomodoroHistoryData {
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
    
    func setName(id: Int, name: String) {
        var data: AnyObject = pomodoroHistoryData[id]
        data.setValue(name, forKey: "name")
        context?.save(nil)
    }
    
    func deleteData(id: Int) {
        for items in pomodoroHistoryData {
            let itemsId = items.valueForKey("id") as Int
            if itemsId == id {
                context.deleteObject(items as NSManagedObject)
                context.save(nil)
                println("\(id)删除成功")
            }
        }
    }
    
    func sortDataByDay() {
        pomodoroInit()
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = NSTimeZone.systemTimeZone()
        for items in pomodoroHistoryData {
            let startTime = items.valueForKey("starttime") as NSDate
            let stringFromTimeByDay = formatter.stringFromDate(startTime)
            var a: [AnyObject] = []
            a.append(items)
//            let oldValue = dataByDay.updateValue(a, forKey: stringFromTimeByDay)
            let value = dataByDay[stringFromTimeByDay]
            if (value != nil) {
                dataByDay[stringFromTimeByDay]?.append(items)
            } else {
                dataByDay.updateValue(a, forKey: stringFromTimeByDay)
            }
        }
//        let aaa = Array(dataByDay.values)[1][1].valueForKey("id") as Int
//        println("----\(aaa)")
    }

}