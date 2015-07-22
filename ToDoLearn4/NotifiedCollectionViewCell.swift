//
//  NotifiedCollectionViewCell.swift
//  collectionView
//
//  Created by bain on 15-6-7.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit

class NotifiedCollectionViewCell: UICollectionViewCell {
    var nameLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        let size = self.frame.size
        nameLabel = UILabel(frame: CGRectMake(0, size.height / 4, size.width, size.height / 2))
        let font = UIFont.systemFontOfSize(13)
        nameLabel.font = font
        nameLabel.textAlignment = NSTextAlignment.Center
//        self.image = UIImageView(frame: CGRectMake(0, 0, 50, 50))
        self.contentView.addSubview(self.nameLabel)
        self.backgroundColor = UIColor.clearColor()
        setDefaultSelectedBackgroundView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //self.imageView.
        //fatalError("init(coder:) has not been implemented")
    }
    private func setDefaultSelectedBackgroundView() {
        self.selectedBackgroundView = UIView(frame: self.bounds)
        self.selectedBackgroundView.backgroundColor = UIColor.ColorPalette.xECEFF1
    }
}
