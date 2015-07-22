//
//  DatePickerView.swift
//  ToDoLearn4
//
//  Created by bain on 15-6-8.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit

protocol DatePickerChanagedDelegate: NSObjectProtocol{
    //回调方法
    func datePickerChanaged(controller: DatePickerView,date: NSDate)
}

class DatePickerView: UIView {
    var delegate:DatePickerChanagedDelegate?
    
    func print() {
        println("1")
    }
    
    @IBAction func didDPChanged(sender: UIDatePicker) {
        if (delegate != nil) {
            delegate?.datePickerChanaged(self, date: sender.date)
            println("delegate")
        }
        
        println(sender.date)
    }

}
