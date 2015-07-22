//
//  HabitTimeTableViewCell.swift
//  ToDoLearn4
//
//  Created by bain on 15-5-20.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit

class HabitTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var habitTimeLabel: UILabel!
    @IBOutlet weak var habitTimeNoLabel: UILabel!
    @IBOutlet weak var habitIdLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
