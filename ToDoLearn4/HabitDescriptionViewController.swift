//
//  HabitDescriptionViewController.swift
//  ToDoLearn4
//
//  Created by bain on 15-5-17.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit
import CoreData

class HabitDescriptionViewController: UIViewController{
    var data:NSManagedObject!
    var context:NSManagedObjectContext!
    var dataId: Int!
    var arrForSameId: [AnyObject]!
    var nowShowData: AnyObject!
    var nowDate: NSDate!
    var canEditRow: Bool!
    
    let imageFilled = UIImage(named: "settingsOptionButtonActive")
    let imageEmpty = UIImage(named: "settingsOptionButtonInActive")
    
    @IBOutlet weak var habitDescriptionTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var habitStatusBtn: UIButton!
    @IBOutlet weak var nowHabitTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habitDescriptionTableView.registerNib(UINib(nibName: "HabitTimeTableViewCell", bundle:nil), forCellReuseIdentifier: "habitTimeCell") //注册xib
        dataId = data.valueForKey("id") as Int
        titleLabel.text = (data.valueForKey("name") as String)
        canEditRow = false
        context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext //数据库上下文
//        habitStatusBtn.setTitle("未完成", forState: UIControlState.Normal)
        habitStatusBtn.setImage(imageEmpty, forState: UIControlState.Normal)
        nowHabitTimeLabel.text = "无"
        view.backgroundColor = UIColor(patternImage: UIImage(named: "editBackground")!)
        refreshData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didBackBtnClicked(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func didAddBtnClicked(sender: UIButton) {
        var vc = storyboard?.instantiateViewControllerWithIdentifier("habitTimeSelectView") as HabitTimeSelectViewController
        vc.id = dataId
        presentViewController(vc, animated: true, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return habitTimeManager.habitTimeCoreData!.count
        return arrForSameId.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let id = arrForSameId[indexPath.row].valueForKey("id") as Int
        let date = arrForSameId[indexPath.row].valueForKey("time") as NSDate
        let no = arrForSameId[indexPath.row].valueForKey("no") as Int
        let status = arrForSameId[indexPath.row].valueForKey("status") as Bool
        
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = NSTimeZone.systemTimeZone()
        let stringFromDate = formatter.stringFromDate(date)

        let cell: HabitTimeTableViewCell = tableView.dequeueReusableCellWithIdentifier("habitTimeCell", forIndexPath: indexPath) as HabitTimeTableViewCell
        cell.habitTimeLabel.text = "\(stringFromDate)"
        cell.habitIdLabel.text = "\(status)"
        cell.habitTimeNoLabel.text = "\(no)"
//        notificationManager.createAndFireHabitLocalNotification(dataId, row: indexPath.row)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        var vc = storyboard?.instantiateViewControllerWithIdentifier("habitTimeSelectView") as HabitTimeSelectViewController
//        vc.id = dataId
//        presentViewController(vc, animated: true, completion: nil)
        if canEditRow == true {
            let timeForDate = arrForSameId[indexPath.row].valueForKey("time") as NSDate
            let formatter = NSDateFormatter()
            formatter.dateFormat = "HH:mm"
            formatter.timeZone = NSTimeZone.systemTimeZone()
            let timeForString = formatter.stringFromDate(timeForDate)
            nowHabitTimeLabel.text = "无"
            nowShowData = arrForSameId[indexPath.row]
            refreshData()
        }
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
//            context.deleteObject(arrForSameId[indexPath.row] as NSManagedObject)
//            context.save(nil)
            habitTimeManager.deleteARowData(arrForSameId[indexPath.row])
            refreshData()
        } else if editingStyle == .Insert {
        }
    }
    
    @IBAction func didStatusBtnClicked(sender: UIButton) {
        habitTimeManager.setStatus(nowShowData)
        refreshData()
    }
    @IBAction func didSwitchChange(sender: UISwitch) {
        if sender.on {
            canEditRow = true
        }else {
            canEditRow = false
            refreshData()
        }
    }
    
    func timeLabelShow() {
        if arrForSameId.count > 0 {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "HH:mm"
            formatter.timeZone = NSTimeZone.systemTimeZone()
            let daDate = formatter.stringFromDate(nowShowData.valueForKey("time") as NSDate)
            let daStatus = nowShowData.valueForKey("status") as Bool
            //            println("现在为\(daStatus)")
            if daStatus {
//                habitStatusBtn.setTitle("已完成", forState: UIControlState.Normal)
                habitStatusBtn.setImage(imageFilled, forState: UIControlState.Normal)
            } else {
//                habitStatusBtn.setTitle("未完成", forState: UIControlState.Normal)
                habitStatusBtn.setImage(imageEmpty, forState: UIControlState.Normal)
            }
            nowHabitTimeLabel.text = "\(daDate)"
        } else {
            nowHabitTimeLabel.text = "无"
        }
    }
    
    func refreshData(){
        habitManager = HabitManager()
        habitTimeManager = HabitTimeManager()
        notificationManager.createAllNotification()
        arrForSameId = habitTimeManager.findData(dataId)
        if arrForSameId.count > 0 {
            if canEditRow == false {
                nowShowData = habitTimeManager.compareTime(arrForSameId)
            }
        }
        timeLabelShow()
        habitDescriptionTableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        refreshData()
    }
}
