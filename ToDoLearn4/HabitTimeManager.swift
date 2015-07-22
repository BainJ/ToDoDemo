//
//  HabitTimeManager.swift
//  ToDoLearn4
//
//  Created by bain on 15-5-18.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit
import CoreData

var habitTimeManager: HabitTimeManager = HabitTimeManager()
class HabitTimeManager: NSObject {
    var habitTimeCoreData:[AnyObject]!
    var context:NSManagedObjectContext!
    
    //    初始化
    override init() {
        context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext //数据库上下文
        let coreData = NSFetchRequest(entityName: "HabitTime")
        habitTimeCoreData = context?.executeFetchRequest(coreData, error: nil)
    }
    
    func findData(id: Int) -> [AnyObject] {
        var arrForSameId: [AnyObject] = []
        for items in habitTimeCoreData {
            let itemsId = items.valueForKey("id") as Int
            let itemsDate = items.valueForKey("time") as NSDate
            if itemsId == id {
                arrForSameId.append(items)
            }
        }
        //排序
        var targetDate: AnyObject!
        let count = arrForSameId.count
        for(var i = 0; i < count - 1; i++){
            for(var j = i + 1; j < count; j++){
                let dateI = arrForSameId[i].valueForKey("time") as NSDate
                let dateJ = arrForSameId[j].valueForKey("time") as NSDate
                let earlierDate = dateI.earlierDate(dateJ)
                if earlierDate == dateJ {
                    targetDate = arrForSameId[i]
                    arrForSameId[i] = arrForSameId[j]
                    arrForSameId[j] = targetDate
                }
            }
        }
//        println("------------------2222-----------------------")
//        println("\(arrForSameId)")
//        println("-----------------------------------------")
        return arrForSameId
    }
    
    func compareTime(data: [AnyObject]) -> AnyObject{
        var returnData: AnyObject!
        var earlierDate: NSDate!
        var tag = 0
        var nowDate: NSDate!
        nowDate = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.timeZone = NSTimeZone.systemTimeZone()
        var nowString = formatter.stringFromDate(nowDate)
        nowString = "2015-05-17 " + nowString
//        println(nowString)
        formatter.dateFormat = "yyyy-M-dd HH:mm:ss"
        nowDate = formatter.dateFromString(nowString)
//        println("\(nowDate)")
        
        for items in data {
            let itemsDate = items.valueForKey("time") as NSDate
            earlierDate = nowDate.earlierDate(itemsDate)
            if earlierDate == nowDate {
                returnData = items
                tag = 1
                break
            }
        }
        if tag == 0 {
            returnData = data[0]
        }
        return returnData
    }
    
    func findMaxNo() -> Int {
        var maxNo = 0
        if habitTimeCoreData.count > 0 {
            for items in habitTimeCoreData {
                let no = items.valueForKey("no") as Int
                if no > maxNo {
                    maxNo = no
                }
            }
            return maxNo
        } else {
            return 0
        }
    }
    
    func addData(addDate: NSDate, id: Int) {
        let data: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("HabitTime", inManagedObjectContext: context!)
        let no = findMaxNo()
        data.setValue(id, forKey: "id")
        data.setValue(addDate, forKey: "time")
        data.setValue(no + 1, forKey: "no")
        data.setValue(false, forKey: "status")
        context?.save(nil)
    }
    
    func setStatus(data: AnyObject) {
        let status = data.valueForKey("status") as Bool
        data.setValue(!status, forKey: "status")
        context?.save(nil)
        println("设为\(!status)")
    }
    
    func deleteARowData(deleteDate: AnyObject) {
        context.deleteObject(deleteDate as NSManagedObject)
        context.save(nil)
    }
    
    func deleteAllData(deleteDate: [AnyObject]) {
        for items in deleteDate {
            context.deleteObject(items as NSManagedObject)
            context.save(nil)
        }
    }
}
