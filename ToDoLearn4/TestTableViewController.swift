//
//  TestTableViewController.swift
//  ToDoLearn4
//
//  Created by bain on 15-5-31.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshData()
        tableView.registerNib(UINib(nibName: "PomodoroHistoryTableViewCell", bundle:nil), forCellReuseIdentifier: "pomodoroHistoryCell") //注册xib
        view.backgroundColor = UIColor(patternImage: UIImage(named: "settingsBackground")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return Array(pomodoroHistoryManager.dataByDay.keys).count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return Array(pomodoroHistoryManager.dataByDay.values)[section].count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let id = pomodoroHistoryManager.pomodoroHistoryData[indexPath.row].valueForKey("id") as Int
//        let startTime = pomodoroHistoryManager.pomodoroHistoryData[indexPath.row].valueForKey("starttime") as NSDate
//        let endTime = pomodoroHistoryManager.pomodoroHistoryData[indexPath.row].valueForKey("endtime") as NSDate
//        let name = pomodoroHistoryManager.pomodoroHistoryData[indexPath.row].valueForKey("name") as String
//        let duration = pomodoroHistoryManager.pomodoroHistoryData[indexPath.row].valueForKey("duration") as Int
        
        let data: AnyObject = Array(pomodoroHistoryManager.dataByDay.values)[indexPath.section][indexPath.row]
        let id = data.valueForKey("id") as Int
        let startTime = data.valueForKey("starttime") as NSDate
        let endTime = data.valueForKey("endtime") as NSDate
        let name = data.valueForKey("name") as String
        let duration = data.valueForKey("duration") as Int
        
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = NSTimeZone.systemTimeZone()
        let stringFromTimeYear = formatter.stringFromDate(startTime)
        formatter.dateFormat = "HH:mm"
        let stringFromStartTime = formatter.stringFromDate(startTime)
        let stringFromEndTime = formatter.stringFromDate(endTime)
        
        let cell: PomodoroHistoryTableViewCell = tableView.dequeueReusableCellWithIdentifier("pomodoroHistoryCell", forIndexPath: indexPath) as PomodoroHistoryTableViewCell
        cell.timeLabel.text = "\(stringFromTimeYear)  \(stringFromStartTime) ~ \(stringFromEndTime)"
        cell.durationLabel.text = "\(duration)"
        cell.nameLabel.text = "\(name)"
        cell.idLabel.text = "\(id)"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(Array(pomodoroHistoryManager.dataByDay.keys)[section])   完成番茄数:\(Array(pomodoroHistoryManager.dataByDay.values)[section].count)"
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let data: AnyObject = Array(pomodoroHistoryManager.dataByDay.values)[indexPath.section][indexPath.row]
            let id = data.valueForKey("id") as Int
            pomodoroHistoryManager.deleteData(id)
            refreshData()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func refreshData(){
        pomodoroHistoryManager.allInit()
        tableView.reloadData()
        super.navigationController?.setNavigationBarHidden(false, animated: true)
        super.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        refreshData()
    }
//    @IBAction func didBarBtnClick(sender: UIBarButtonItem) {
//        let viewController=storyboard?.instantiateViewControllerWithIdentifier("popupTest") as PopupTestViewController
//        viewController.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
//        presentViewController(viewController, animated: true, completion: nil)
//    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
