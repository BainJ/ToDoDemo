//
//  HabitTableViewController.swift
//  ToDoLearn4
//
//  Created by bain on 15-5-17.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit
import CoreData

class HabitTableViewController: UITableViewController {
    
    var context:NSManagedObjectContext!
//    var habitCoreData: [AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "HabitMainTableViewCell", bundle:nil), forCellReuseIdentifier: "habitMaincell") //注册xib
        context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext //数据库上下文
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "mainBackground")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return habitManager.habitCoreData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("habitCell", forIndexPath: indexPath) as UITableViewCell
//        let nameLabel = cell.viewWithTag(1) as UILabel
//        let idLabel = cell.viewWithTag(2) as UILabel
//        let id = habitManager.habitCoreData[indexPath.row].valueForKey("id") as Int
//        nameLabel.text = habitManager.habitCoreData[indexPath.row].valueForKey("name") as? String
//        idLabel.text = "\(id)"
        
        
        
        
        let cell: HabitMainTableViewCell = tableView.dequeueReusableCellWithIdentifier("habitMaincell", forIndexPath: indexPath) as HabitMainTableViewCell
        cell.habitNameLabel.text = habitManager.habitCoreData[indexPath.row].valueForKey("name") as? String
        cell.habitTimeLabel.text = ""

//        if todoState == false {
//            cell.stateBtn.setImage(imageEmpty, forState: UIControlState.Normal)
//        }else {
//            cell.stateBtn.setImage(imageFilled, forState: UIControlState.Normal)
//        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var data = habitManager.habitCoreData[indexPath.row] as NSManagedObject
        var vc = storyboard?.instantiateViewControllerWithIdentifier("habitDescription") as HabitDescriptionViewController
        vc.data = data
        presentViewController(vc, animated: true, completion: nil)
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
//            println("\(habitManager.habitCoreData[indexPath.row])")
//            context.deleteObject(habitManager.habitCoreData[indexPath.row] as NSManagedObject)
//            context.save(nil)
            let id = habitManager.habitCoreData[indexPath.row].valueForKey("id") as Int
            let arrData = habitTimeManager.findData(id)
            habitManager.deleteData(habitManager.habitCoreData[indexPath.row])
            habitTimeManager.deleteAllData(arrData)
            refreshData()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func refreshData(){
        habitManager = HabitManager()
        habitTimeManager = HabitTimeManager()
        notificationManager.createAllNotification()
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        refreshData()
    }
    

}
