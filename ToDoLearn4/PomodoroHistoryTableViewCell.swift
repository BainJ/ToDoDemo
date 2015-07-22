//
//  PomodoroHistoryTableViewCell.swift
//  ToDoLearn4
//
//  Created by bain on 15-5-31.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit

class PomodoroHistoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
