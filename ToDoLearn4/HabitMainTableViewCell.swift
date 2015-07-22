//
//  HabitMainTableViewCell.swift
//  ToDoLearn4
//
//  Created by bain on 15-5-20.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit

class HabitMainTableViewCell: UITableViewCell {

    @IBOutlet weak var habitNameLabel: UILabel!
    @IBOutlet weak var habitTimeLabel: UILabel!
    @IBOutlet weak var habitStatusBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
