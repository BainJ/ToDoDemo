//
//  ToDoCellTableViewCell.swift
//  ToDoLearn4
//
//  Created by bain on 15-5-8.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit

class ToDoCellTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dueTimeLabel: UILabel!
    @IBOutlet weak var remainTimeLabel: UILabel!
    @IBOutlet weak var stateBtn: UIButton!
    @IBOutlet weak var timeProgress: UIProgressView!
    @IBOutlet weak var imageV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}