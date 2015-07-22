//
//  TimeManager.swift
//  ClockLearn1
//
//  Created by bain on 15-4-28.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit
import CoreData

var timeManager : TimeManager = TimeManager()

class TimeManager: NSObject {
    
    var workTime: Int!
    var restTime: Int!
    var soundStatus: Bool!   //声音控制 ture:有声音 false:无声音
    var vibrateStatus: Bool! //震动控制 ture:有震动 false:无震动
    
    var context:NSManagedObjectContext!
    var timeCoreData: [AnyObject]!
    override init() {
        context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext //数据库上下文
        let coreData = NSFetchRequest(entityName: "PomodoroState")
        timeCoreData = context?.executeFetchRequest(coreData, error: nil)
        workTime = timeCoreData[0].valueForKey("worktime") as Int
        restTime = timeCoreData[0].valueForKey("resttime") as Int
        soundStatus = timeCoreData[0].valueForKey("soundstatus") as Bool
        vibrateStatus = timeCoreData[0].valueForKey("vibratestatus") as Bool
    }
    
    func setWorkTime(workTimeData: Int) {
        var data: AnyObject! = timeCoreData[0] as NSManagedObject
        data.setValue(workTimeData, forKey: "worktime")
        data.managedObjectContext?.save(nil)
        timeManager = TimeManager()
    }
    
    func setRestTime(restTimeData: Int) {
        var data: AnyObject! = timeCoreData[0] as NSManagedObject
        data.setValue(restTimeData, forKey: "resttime")
        data.managedObjectContext?.save(nil)
        timeManager = TimeManager()
    }
    
    func setSoundStatus(soundStatusData: Bool) {
        var data: AnyObject! = timeCoreData[0] as NSManagedObject
        data.setValue(soundStatusData, forKey: "soundstatus")
        data.managedObjectContext?.save(nil)
        timeManager = TimeManager()
        NSLog("声音开关设置为\(soundStatusData)")
    }
    
    func setVibrateStatus(vibrateStatusData: Bool) {
        var data: AnyObject! = timeCoreData[0] as NSManagedObject
        data.setValue(vibrateStatusData, forKey: "vibratestatus")
        data.managedObjectContext?.save(nil)
        timeManager = TimeManager()
    }
}