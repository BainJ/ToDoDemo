//
//  imgCollectionViewController.swift
//  collectionView
//
//  Created by bain on 15-6-4.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit

protocol ImageChanagedDelegate: NSObjectProtocol{
    func imageChanaged(controller: imgCollectionViewController,data: Int)
}

class imgCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let imageArr = presetDataName
    let reuseIdentifier = "imgCollectionViewCell"
    var size: CGSize!
    var delegate: ImageChanagedDelegate?
    let flowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(imgCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//        self.collectionView?.allowsMultipleSelection = true
        
        collectionView?.backgroundColor = UIColor.clearColor()
        size = self.collectionView!.frame.size
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as imgCollectionViewCell
        cell.image.image = UIImage(named: imageArr[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake((size.width - 60 - 50) / 6, (size.width - 60 - 50) / 6)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(15, 30, 5, 30)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
        if (delegate != nil) {
            delegate?.imageChanaged(self, data: indexPath.row)
        }
    }
}
