//
//  HabitTimeSelectViewController.swift
//  ToDoLearn4
//
//  Created by bain on 15-5-18.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit
import CoreData

class HabitTimeSelectViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    var id: Int!
    var selectTime: String!
    var selectTimeForDate: NSDate!
    var context:NSManagedObjectContext!
    override func viewDidLoad() {
        super.viewDidLoad()
        context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone.systemTimeZone()
        selectTimeForDate = formatter.dateFromString("2015-05-17 12:00:00")
        timeLabel.text = "12:00"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSubmitBtnClicked(sender: UIButton) {
        var targetData: [AnyObject] = habitTimeManager.findData(id)
        var tag = 0
        var i = 0
        for items in targetData {
            let itemsDate = items.valueForKey("time") as NSDate
            if itemsDate.isEqualToDate(selectTimeForDate) {
                tag = 1
            }
        }
        
        if tag == 0 {
            habitTimeManager.addData(selectTimeForDate, id: id)
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func didBackBtnClicked(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func didDPChanged(sender: UIDatePicker) {
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = NSTimeZone.systemTimeZone()
        selectTimeForDate = sender.date
        selectTime = formatter.stringFromDate(sender.date)
        timeLabel.text = "\(selectTime)"
    }

}
