//
//  NotificationManager.swift
//  ToDoLearn4
//
//  Created by bain on 15-5-12.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIkit

var notificationManager: NotificationManager = NotificationManager()

class NotificationManager: NSObject {
    var notification = UILocalNotification()
    var dict: Dictionary<String, Int> = ["row" : 0, "tag" : 0,"id" : 0] //row:行数 value: 0:当前 1:1小时前 2:1天前 7:一周前  id:推送的属性 1:todo类 3:habit类
    
    func createAllNotification() {
        todoCoreDataManager.todoInit()
        habitManager = HabitManager()
        habitTimeManager = HabitTimeManager()
        UIApplication.sharedApplication().cancelAllLocalNotifications() //取消所有推送
        NSLog("取消所有推送成功")
        createAndFireToDoLocalNotification()
        createAndFireHabitLocalNotification()
    }
    
    func createAndFireHabitLocalNotification() {
        var message = "你的习惯还没有签到"
        let habitTimeCoreData = habitTimeManager.habitTimeCoreData
        for data in habitTimeCoreData {
            let status = data.valueForKey("status") as Bool
            if status == false {
                var time = data.valueForKey("time") as NSDate
                let no = data.valueForKey("no") as Int
                let id = data.valueForKey("id") as Int
                let name = habitManager.getHabitName(id)
                
                var nowDate = NSDate()
                var formatter = NSDateFormatter()
                formatter.dateFormat = "yyyy-MM-dd "
                formatter.timeZone = NSTimeZone.systemTimeZone()
                var nowString = formatter.stringFromDate(nowDate)
                
                formatter.dateFormat = "HH:mm:ss"
                var timeForString = formatter.stringFromDate(time)
                timeForString = nowString + timeForString
                
                formatter.dateFormat = "yyyy-M-dd HH:mm:ss"
                time = formatter.dateFromString(timeForString)!
                
                notification.alertBody = message
                notification.fireDate = time
                dict.updateValue(1, forKey: "tag")
                dict.updateValue(3, forKey: "id")
                dict.updateValue(no, forKey: "row")
                notification.userInfo = dict
                notification.timeZone = NSTimeZone.systemTimeZone()
                notification.repeatInterval = NSCalendarUnit.CalendarUnitDay
                NSLog("本地推送添加成功 项目名字：\(name) 推送时间：\(time) ")
                UIApplication.sharedApplication().scheduleLocalNotification(notification) //创建推送
            }
        }
    }
    
    func createAndFireToDoLocalNotification(){
        let todoCoreData = todoCoreDataManager.todoCoreData
        for data in todoCoreData {
            var nowDate = NSDate()
            let status = data.valueForKey("state") as Bool
            let date1 = data.valueForKey("date") as NSDate
            //比较时间
            if date1.earlierDate(nowDate) == nowDate {
                //判断状态是否未false
                if status == false {
                    var formatter = NSDateFormatter()
                    formatter.dateFormat = "yyyy-M-dd HH:mm:ss"
                    let dueTimeDate = data.valueForKey("date") as NSDate
                    let items = data.valueForKey("items") as String
                    let todoState = data.valueForKey("state") as Bool
                    let id = data.valueForKey("id") as Int
                    var remainTimeSec = Int(dueTimeDate.timeIntervalSinceDate(nowDate))
                    var remainTimeDay = remainTimeSec/60/60/24
                    var remainTimeHour = remainTimeSec/60/60
                    if todoState == false {
                        dict.updateValue(id, forKey: "row")
                        dict.updateValue(1, forKey: "id")
                        setToDoLocalNotification(dueTimeDate, items: items, tag: 0)
                        if remainTimeHour >= 1 {
                            setToDoLocalNotification(dueTimeDate, items: items, tag: 1)
                            if remainTimeDay >= 1 {
                                setToDoLocalNotification(dueTimeDate, items: items, tag: 2)
                                if remainTimeDay >= 7 {
                                    setToDoLocalNotification(dueTimeDate, items: items, tag: 7)
                                }
                            }
                        }
                    }
                }//end 判断状态是否未false
            } //end 比较时间
        } //end for
    }
    
    func setToDoLocalNotification(dueTimeDate: NSDate, items: String, tag: Int) {
        var message = ""
        var date:NSDate
        
        switch tag {
        case 0:
            message = "\(items) 时间到！"
            date = dueTimeDate
        case 1:
            message = "\(items) 还有一小时"
            date = NSDate(timeInterval:-60*60, sinceDate: dueTimeDate)
        case 2:
            message = "\(items) 还有一天"
            date = NSDate(timeInterval:-60*60*24, sinceDate: dueTimeDate)
        case 7:
            message = "\(items) 还有一周"
            date = NSDate(timeInterval:-60*60*24*7, sinceDate: dueTimeDate)
        default:
            message = "error"
            date = dueTimeDate
        }
        notification.alertBody = message
        notification.fireDate = date
        dict.updateValue(tag, forKey: "tag")
        
        notification.userInfo = dict
        notification.timeZone = NSTimeZone.systemTimeZone()
        //        notification.repeatInterval = NSCalendarUnit.CalendarUnitDay
        NSLog("本地推送添加成功 项目名字：\(message) 推送时间：\(date) ")
        UIApplication.sharedApplication().scheduleLocalNotification(notification) //创建推送
    }
    
//    func createAndFireHabitLocalNotification(id: Int, row: Int) {
//        var message = "你的习惯还没有签到"
//        let data: AnyObject = habitTimeManager.findData(id)[row]
//        var time = data.valueForKey("time") as NSDate
//        let no = data.valueForKey("no") as Int
//        let name = habitManager.getHabitName(id)
//        var nowDate = NSDate()
//        var formatter = NSDateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd "
//        formatter.timeZone = NSTimeZone.systemTimeZone()
//        var nowString = formatter.stringFromDate(nowDate)
//        
//        formatter.dateFormat = "HH:mm:ss"
//        var timeForString = formatter.stringFromDate(time)
//        timeForString = nowString + timeForString
//        
//        formatter.dateFormat = "yyyy-M-dd HH:mm:ss"
//        time = formatter.dateFromString(timeForString)!
//        
//        notification.alertBody = message
//        notification.fireDate = time
//        dict.updateValue(1, forKey: "tag")
//        dict.updateValue(3, forKey: "id")
//        dict.updateValue(no, forKey: "row")
//        notification.userInfo = dict
//        notification.timeZone = NSTimeZone.systemTimeZone()
//        notification.repeatInterval = NSCalendarUnit.CalendarUnitDay
//        NSLog("本地推送添加成功 项目名字：\(name) 推送时间：\(time) ")
//        UIApplication.sharedApplication().scheduleLocalNotification(notification) //创建推送
//    }
//    
//    func createAndFireToDoLocalNotification(row: Int){
//        var nowDate = NSDate()
//        var formatter = NSDateFormatter()
//        formatter.dateFormat = "yyyy-M-dd HH:mm:ss"
//        let dueTimeDate = todoCoreDataManager.todoCoreData[row].valueForKey("date") as NSDate
//        let items = todoCoreDataManager.todoCoreData[row].valueForKey("items") as String
//        let todoState = todoCoreDataManager.todoCoreData[row].valueForKey("state") as Bool
//        var remainTimeSec = Int(dueTimeDate.timeIntervalSinceDate(nowDate))
//        var remainTimeDay = remainTimeSec/60/60/24
//        var remainTimeHour = remainTimeSec/60/60
//        if todoState == false {
//            dict.updateValue(row, forKey: "row")
//            dict.updateValue(1, forKey: "id")
//            setToDoLocalNotification(dueTimeDate, items: items, tag: 0)
//            if remainTimeHour >= 1 {
//                setToDoLocalNotification(dueTimeDate, items: items, tag: 1)
//                if remainTimeDay >= 1 {
//                    setToDoLocalNotification(dueTimeDate, items: items, tag: 2)
//                    if remainTimeDay >= 7 {
//                        setToDoLocalNotification(dueTimeDate, items: items, tag: 7)
//                    }
//                }
//            }
//        }
//    }
//    
//    func cancelToDoLocalNotification(row: Int){
//        let array:NSArray = UIApplication.sharedApplication().scheduledLocalNotifications
//        var count = array.count
//        for(var i = 0; i<count; i++){
//            let notification: UILocalNotification = array[i] as UILocalNotification
//            var userInfo = notification.userInfo as Dictionary!
//            var userRow = userInfo["row"] as Int
//            var userId = userInfo["id"] as Int
//            if userId == 1 {
//                if userRow == row {
//                    UIApplication.sharedApplication().cancelLocalNotification(notification)
//                    NSLog("取消推送 \(userInfo)")
//                }
//            }
//        }
//        
//    }
}