//
//  TimeSetTableViewController.swift
//  ClockLearn1
//
//  Created by bain on 15-4-29.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit
import CoreData

class TimeSetTableViewController: UITableViewController {
    
    @IBOutlet weak var soundStatusSwt: UISwitch!
    @IBOutlet weak var vibrateStatusSwt: UISwitch!
    
    var arrWorkTime = ["25", "35", "45", "60"]
    var arrRestTime = ["05", "10", "15", "20"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "settingsBackground")!)
        refreshData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didWorkSetbtnClick(sender: UIButton) {
        //        timeManager.setWorkTime(timeSetLabel.text.toInt()!)
        //        println("\(timeManager.workTime)")
        var alertControllerAS = UIAlertController(title: "选择时间", message: "选择休息时间", preferredStyle: UIAlertControllerStyle.ActionSheet)
        var cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        for item in arrWorkTime {
            var someAction = UIAlertAction(title: item + "分钟", style: UIAlertActionStyle.Default){ (action) -> Void in
                timeManager.setWorkTime(item.toInt()!)
                println("\(timeManager.workTime)")
            }
            alertControllerAS.addAction(someAction)
        }
        var archiveAction = UIAlertAction(title: "自定义", style: UIAlertActionStyle.Default){ (action) -> Void in
            var alertControllerAlert = UIAlertController(title: "输入", message: "输入工作时间", preferredStyle: UIAlertControllerStyle.Alert)
            var cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
            var okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default){ (action) -> Void in
                timeManager.setWorkTime((alertControllerAlert.textFields?.first as UITextField).text.toInt()!)
                println("\(timeManager.workTime)")
            }
            alertControllerAlert.addAction(cancelAction)
            alertControllerAlert.addAction(okAction)
            alertControllerAlert.addTextFieldWithConfigurationHandler(nil)
            self.presentViewController(alertControllerAlert, animated: true, completion: nil)
        }
        alertControllerAS.addAction(cancelAction)
        alertControllerAS.addAction(archiveAction)
        self.presentViewController(alertControllerAS, animated: true, completion: nil)
        
    }
    
    @IBAction func didRestTimeBtnClick(sender: UIButton) {
        //        timeManager.setRestTime(timeSetLabel.text.toInt()!)
        //        println("\(timeManager.restTime)")
        
        var alertControllerAS = UIAlertController(title: "选择时间", message: "选择工作时间", preferredStyle: UIAlertControllerStyle.ActionSheet)
        var cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        for item in arrRestTime {
            var someAction = UIAlertAction(title: item + "分钟", style: UIAlertActionStyle.Default){ (action) -> Void in
                timeManager.setRestTime(item.toInt()!)
                println("\(timeManager.restTime)")
            }
            alertControllerAS.addAction(someAction)
        }
        var archiveAction = UIAlertAction(title: "自定义", style: UIAlertActionStyle.Default){ (action) -> Void in
            var alertControllerAlert = UIAlertController(title: "输入", message: "输入休息时间", preferredStyle: UIAlertControllerStyle.Alert)
            var cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
            var okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default){ (action) -> Void in
                timeManager.setRestTime((alertControllerAlert.textFields?.first as UITextField).text.toInt()!)
                println("\(timeManager.restTime)")
            }
            alertControllerAlert.addAction(cancelAction)
            alertControllerAlert.addAction(okAction)
            alertControllerAlert.addTextFieldWithConfigurationHandler(nil)
            self.presentViewController(alertControllerAlert, animated: true, completion: nil)
        }
        alertControllerAS.addAction(cancelAction)
        
        alertControllerAS.addAction(archiveAction)
        self.presentViewController(alertControllerAS, animated: true, completion: nil)
    }
    
    @IBAction func didSubmitBtnClick(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func didSoundSwtChanged(sender: UISwitch) {
        if sender.on {
            timeManager.setSoundStatus(true)
        }else {
            timeManager.setSoundStatus(false)
        }
    }
    @IBAction func didVibrateSrtChanged(sender: UISwitch) {
        if sender.on {
            timeManager.setVibrateStatus(true)
        }else {
            timeManager.setVibrateStatus(false)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 2
    }
    
    func refreshData(){
        timeManager = TimeManager()
        if timeManager.soundStatus == false{
            soundStatusSwt.setOn(false, animated: true)
        } else {
            soundStatusSwt.setOn(true, animated: true)
        }
        if timeManager.vibrateStatus == false {
            vibrateStatusSwt.setOn(false, animated: true)
        } else {
            vibrateStatusSwt.setOn(true, animated: true)
        }
        super.navigationController?.setNavigationBarHidden(false, animated: true)
        super.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        refreshData()
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
    
    // Configure the cell...
    
    return cell
    }
    */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
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
