//
//  imgCollectionViewCell.swift
//  collectionView
//
//  Created by bain on 15-6-4.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit

class imgCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    var image: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        let size = self.frame.size
        self.image = UIImageView(frame: CGRectMake(0, 0, size.width, size.height))
        self.contentView.addSubview(self.image)
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
        self.selectedBackgroundView.backgroundColor = UIColor(hex: 0xCCCFC1)
    }
    
}
