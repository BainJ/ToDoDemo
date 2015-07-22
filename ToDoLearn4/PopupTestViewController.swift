//
//  PopupTestViewController.swift
//  ToDoLearn4
//
//  Created by bain on 15-6-1.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit

class PopupTestViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tf.becomeFirstResponder()
        tf.delegate = self
        self.modalPresentationStyle = .Custom
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
