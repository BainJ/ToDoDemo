//
//  NameAddViewController.swift
//  ToDoLearn1
//
//  Created by bain on 15-4-26.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit
import CoreData

protocol RefreshDelegate: NSObjectProtocol {
    //回调方法
    func refresh(controller: NameAddViewController, tag: Int)
}

class NameAddViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var itemNameTf: UITextField!
    var delegate: RefreshDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameTf.becomeFirstResponder()
        itemNameTf.delegate = self
        self.modalPresentationStyle = .Custom
        let font = UIFont.systemFontOfSize(18)
        let textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        let attributes = [
            NSForegroundColorAttributeName : textColor,
            NSFontAttributeName : font
        ]
        itemNameTf.attributedPlaceholder = NSAttributedString(string: "输入待办事项", attributes: attributes)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if itemNameTf.text != "" {
            var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
            var item: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("ToDo1", inManagedObjectContext: context!)
            
            var dateString1 = "1999-1-1"
            var formatter1 = NSDateFormatter()
            formatter1.dateFormat = "yyyy-M-dd"
            var date1 = formatter1.dateFromString(dateString1)
            let id = todoCoreDataManager.findMaxId()
            
            item.setValue(itemNameTf.text, forKey: "items")
            item.setValue(date1, forKey: "date")
            item.setValue(false, forKey: "state")
            item.setValue(id + 1, forKey: "id")
            item.setValue(19, forKey: "image")
            context?.save(nil)
        }
        delegate?.refresh(self, tag: 1)
        if (delegate != nil) {
            delegate?.refresh(self, tag: 1)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        return true
    }
}
