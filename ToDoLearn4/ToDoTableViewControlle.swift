//
//  ToDoTableViewController.swift
//  ToDoLearn1
//
//  Created by bain on 15-4-26.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit
import CoreData

extension Int {
    var remainTimeYear: Int { return self/60/60/24/30/12 }
    var remainTimeMon: Int { return self/60/60/24/30 - remainTimeYear * 12 }
    var remainTimeDay: Int { return self/60/60/24 - remainTimeYear*12 - remainTimeMon * 30 }
    var remainTimeHour: Int { return self/60/60 - remainTimeYear*12 - remainTimeMon * 30 - remainTimeDay*24 }
    var remainTimeMinute: Int { return self/60 - remainTimeYear*12 - remainTimeMon * 30 - remainTimeDay*24 - remainTimeHour*60 }
    
    func todoTimeString() -> String {
        if remainTimeYear == 0 {
            if remainTimeMon == 0 {
                if remainTimeDay == 0 {
                    if remainTimeHour == 0 {
                        return "\(remainTimeMinute)分"
                    }else {
                        return "\(remainTimeHour)时 \(remainTimeMinute)分"
                    }
                }else {
                    return "\(remainTimeDay)日 \(remainTimeHour)时"
                }
            }else {
                return "\(remainTimeMon)月 \(remainTimeDay)日"
            }
        }else {
            return "\(remainTimeYear)年 \(remainTimeMon)月"
        }
    }
}

class ToDoTableViewController: UITableViewController, RefreshDelegate {
    var context:NSManagedObjectContext!
    let imageFilled = UIImage(named: "iconPipeFilled")
    let imageEmpty = UIImage(named: "iconPipeEmpty")
//    var refreshControl:UIRefreshControl?
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutRefreshViewHeaderView()
//        UIApplication.sharedApplication().cancelAllLocalNotifications() //取消所有推送
//        NSLog("取消所有推送成功")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None //不显示分割线
        self.tableView.registerNib(UINib(nibName: "ToDoCellTableViewCell", bundle:nil), forCellReuseIdentifier: "tableCell") //注册xib
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "mainBackground")!)
        context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext //数据库上下文
        refreshData()
//        self.modalPresentationStyle = .Custom
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func layoutRefreshViewHeaderView(){
        refreshControl = UIRefreshControl()
//        let font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        let font = UIFont.systemFontOfSize(17)
        let textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        let attributes = [
            NSForegroundColorAttributeName : textColor,
            NSFontAttributeName : font,
            NSTextEffectAttributeName : NSTextEffectLetterpressStyle
        ]
        refreshControl!.attributedTitle = NSAttributedString(string: "下拉添加", attributes: attributes)
//        refreshControl!.attributedTitle = NSAttributedString(string: "下拉添加")
        refreshControl!.tintColor = UIColor.whiteColor()
        refreshControl?.addTarget(self, action: "add", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(self.refreshControl!)
        
    }
    
    func add(){
        refreshControl?.beginRefreshing()
        refreshControl?.endRefreshing()
//        var vc = storyboard?.instantiateViewControllerWithIdentifier("nameAddView") as NameAddViewController
//        presentViewController(vc, animated: true, completion: nil)
        let viewController=storyboard?.instantiateViewControllerWithIdentifier("nameAddView") as NameAddViewController
        viewController.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        viewController.delegate = self
        presentViewController(viewController, animated: true, completion: nil)
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
        
        return todoCoreDataManager.todoCoreData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: ToDoCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as ToDoCellTableViewCell
        let nowDate = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-M-dd HH:mm:ss"
        let dateString = formatter.stringFromDate(nowDate)
        
        let todoItems = todoCoreDataManager.todoCoreData[indexPath.row].valueForKey("items") as String
        let dueTimeDate = todoCoreDataManager.todoCoreData[indexPath.row].valueForKey("date") as NSDate
        let todoState = todoCoreDataManager.todoCoreData[indexPath.row].valueForKey("state") as Bool
        let todoImage = todoCoreDataManager.todoCoreData[indexPath.row].valueForKey("image") as Int
        let dueTimeString = formatter.stringFromDate(dueTimeDate)
        let remainTimesec = Int(dueTimeDate.timeIntervalSinceDate(nowDate))
        
        cell.remainTimeLabel.text = remainTimesec.todoTimeString()
        cell.nameLabel.text = "\(todoItems)"
        cell.dueTimeLabel.text = "\(dueTimeString)"
        cell.stateBtn.tag = indexPath.row
        cell.imageV.image = UIImage(named: presetDataName[todoImage])
//        cell.timeProgress
        if todoState == false {
            cell.stateBtn.setImage(imageEmpty, forState: UIControlState.Normal)
            cell.timeProgress.setProgress(0, animated: true)
        }else {
            cell.stateBtn.setImage(imageFilled, forState: UIControlState.Normal)
            cell.timeProgress.setProgress(1, animated: true)
        }
//        if remainTimesec > 0 {
//            notificationManager.createAndFireToDoLocalNotification(indexPath.row)
//        }
        cell.stateBtn.addTarget(self, action: "didStateBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var data = todoCoreDataManager.todoCoreData[indexPath.row] as NSManagedObject
        var vc = storyboard?.instantiateViewControllerWithIdentifier("timeSelectView") as TimeSelectViewController
        vc.data = data
        presentViewController(vc, animated: true, completion: nil)
//        notificationManager.cancelToDoLocalNotification(indexPath.row)
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            context.deleteObject(todoCoreDataManager.todoCoreData[indexPath.row] as NSManagedObject)
            context.save(nil)
            refreshData()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    func refreshData(){
        todoCoreDataManager.todoInit()
        notificationManager.createAllNotification()
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        refreshData()
    }
    
    func didStateBtnClick(sender:UIButton){
        let row = sender.tag
        
        var data: AnyObject! = todoCoreDataManager.todoCoreData[row] as NSManagedObject
        var todoState = todoCoreDataManager.todoCoreData[row].valueForKey("state") as Bool
        if todoState == false {
            sender.setImage(imageFilled, forState: UIControlState.Normal)
            data.setValue(true, forKey: "state")
            data.managedObjectContext?.save(nil)
//            notificationManager.cancelToDoLocalNotification(row)
        }else {
            sender.setImage(imageEmpty, forState: UIControlState.Normal)
            data.setValue(false, forKey: "state")
            data.managedObjectContext?.save(nil)
//            notificationManager.createAndFireLocalNotification(row)
        }
        refreshData()
        data = todoCoreDataManager.todoCoreData[row]
        
        todoState = data.valueForKey("state") as Bool
        var todoItems = data.valueForKey("items") as String
        NSLog("项目状态修改成功 行数：\(row) 项目名称：\(todoItems)当前状态：\(todoState)")

    }
    //RefreshDelegate委托 添加完成后刷新页面
    func refresh(controller: NameAddViewController, tag: Int) {
        if tag == 1 {
            refreshData()
        }
    }
}
