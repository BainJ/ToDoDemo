//
//  HabitNameAddViewController.swift
//  ToDoLearn4
//
//  Created by bain on 15-5-17.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit
import CoreData

class HabitNameAddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.becomeFirstResponder()
        nameLabel.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        var Data: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Habit", inManagedObjectContext: context!)
        //        let habitCoreData: [AnyObject]! = context?.executeFetchRequest(NSFetchRequest(entityName: "Habit"), error: nil)
        let maxId = habitManager.findMaxId()
        Data.setValue(nameLabel.text, forKey: "name")
        Data.setValue(maxId + 1, forKey: "id")
        context?.save(nil)
        self.navigationController?.popViewControllerAnimated(true)
        println("1")
        return true
    }
}
