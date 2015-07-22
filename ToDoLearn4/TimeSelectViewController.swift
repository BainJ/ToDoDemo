//
//  TimeSelectViewController.swift
//  ToDoLearn1
//
//  Created by bain on 15-4-26.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit
import CoreData

class TimeSelectViewController: UIViewController, DatePickerChanagedDelegate, ImageChanagedDelegate, NotifiedChanagedDelegate, RepeatChanagedDelegate {
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    
    var imageView = imgCollectionViewController(collectionViewLayout:UICollectionViewFlowLayout())
    var notifiedView = NotifiedCollectionViewController(collectionViewLayout:UICollectionViewFlowLayout())
    var repeatView = RepeatCollectionViewController(collectionViewLayout:UICollectionViewFlowLayout())
    var datePickerView: DatePickerView!
    
    var data:NSManagedObject!
    var selectImage: Int?
    var selectNotified: String?
    var selectRepeat: String?
    var selectDatePicker: String?
    var selectDate: NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = NSBundle.mainBundle().loadNibNamed("DatePickerView", owner: self, options: nil)
        datePickerView = nib[0] as DatePickerView
        datePickerView.delegate = self
        imageView.delegate = self
        notifiedView.delegate = self
        repeatView.delegate = self
        addSubviewAll()
        segment.frame = CGRectMake(46, 100, 280, 60)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "editBackgroundx")!)
        taskNameLabel.text = data.valueForKey("items") as? String
        
        hiddenSubviewAll()
        hiddenSubviewAll()
        imageView.collectionView?.hidden = false
        nameLabel.text = "选择图片"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSubmitClick(sender: AnyObject) {
        if selectDate != nil {
            data.setValue(selectDate!, forKey: "date")
        }
        if selectImage != nil {
            data.setValue(selectImage!, forKey: "image")
        }
        
        data.managedObjectContext?.save(nil)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didCancelClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didSegChanaged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            hiddenSubviewAll()
            imageView.collectionView?.hidden = false
            nameLabel.text = "选择图片"
            discriptionLabel.text = ""
        case 1:
            hiddenSubviewAll()
            notifiedView.collectionView?.hidden = false
            nameLabel.text = "提醒时间"
            discriptionLabel.text = ""
        case 2:
            hiddenSubviewAll()
            repeatView.collectionView?.hidden = false
            nameLabel.text = "提醒周期"
            discriptionLabel.text = ""
        case 3:
            hiddenSubviewAll()
            datePickerView.hidden = false
            nameLabel.text = "提醒时间"
            discriptionLabel.text = ""
        default:
            println("aaa")
        }
    }
    
    func addSubviewAll () {
        imageView.collectionView!.frame = containerView.bounds
        containerView.addSubview(imageView.collectionView!)
        
        notifiedView.collectionView!.frame = containerView.bounds
        containerView.addSubview(notifiedView.collectionView!)
        
        repeatView.collectionView!.frame = containerView.bounds
        containerView.addSubview(repeatView.collectionView!)
        
        containerView.addSubview(datePickerView)
    }
    
    func hiddenSubviewAll () {
        imageView.collectionView?.hidden = true
        notifiedView.collectionView?.hidden = true
        repeatView.collectionView?.hidden = true
        datePickerView.hidden = true
    }
    
    func datePickerChanaged(controller: DatePickerView,date: NSDate) {
        let formatter  = NSDateFormatter()
        selectDate = date
        formatter.dateFormat = "yyyy-M-dd HH:mm:ss"
        selectDatePicker = formatter.stringFromDate(date)
        
        discriptionLabel.text = selectDatePicker
    }
    
    func imageChanaged(controller: imgCollectionViewController, data: Int) {
        selectImage = data
    }
    
    func notifiedChanaged(controller: NotifiedCollectionViewController, data: String) {
        selectNotified = data
        discriptionLabel.text = selectNotified
    }
    
    func repeatChanaged(controller: RepeatCollectionViewController, data: String) {
        selectRepeat = data
        discriptionLabel.text = selectRepeat
    }
}
