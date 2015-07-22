//
//  DatePickView.swift
//  dataPickTest
//
//  Created by bain on 15-6-3.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit

class DatePickView: UIView {
    
    @IBOutlet weak var subBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var stringLbl: UILabel!
    
    var dateArr = [NSDate]()
    var dateTag: Int! {
        willSet(newDateTage) {
            let formatter1 = NSDateFormatter()
            formatter1.dateFormat = "yyyy-MM-dd"
            formatter1.timeZone = NSTimeZone.systemTimeZone()
            let formatter2 = NSDateFormatter()
            formatter2.dateFormat = "EE"
            formatter2.timeZone = NSTimeZone.systemTimeZone()
            dateLbl.text = formatter1.stringFromDate(dateArr[newDateTage])
            switch newDateTage {
            case 6:
                stringLbl.text = "今天"
            case 5:
                stringLbl.text = "昨天"
            case 4:
                stringLbl.text = "前天"
            default:
                stringLbl.text = formatter2.stringFromDate(dateArr[newDateTage])
            }
            switch newDateTage {
            case 6:
                addBtn.enabled = false
                addBtn.alpha = 0
                subBtn.enabled = true
                subBtn.alpha = 1
            case 0:
                addBtn.enabled = true
                addBtn.alpha = 1
                subBtn.enabled = false
                subBtn.alpha = 0
            default:
                addBtn.enabled = true
                addBtn.alpha = 1
                subBtn.enabled = true
                subBtn.alpha = 1
            }
        }
    }
    
    func initial() {
        dateArrInitial()
        dateTag = 6
    }
    
    func dateArrInitial() {
        dateArr = [NSDate]()
        for (var i = 6; i >= 0; i--) {
            let iDay = NSTimeInterval(-60 * 60 * 24 * i)
            let iDayDate = NSDate(timeIntervalSinceNow: iDay)
            dateArr.append(iDayDate)
        }
    }
    
    @IBAction func subBtnClicked(sender: UIButton) {
        if dateTag != 0 {
            dateTag = dateTag - 1
        }
    }
    
    @IBAction func addBtnClicked(sender: UIButton) {
        if dateTag != 6 {
            dateTag = dateTag + 1
        }
    }
}
