//
//  NotifiedCollectionViewController.swift
//  collectionView
//
//  Created by bain on 15-6-7.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit

protocol NotifiedChanagedDelegate: NSObjectProtocol{
    func notifiedChanaged(controller: NotifiedCollectionViewController, data: String)
}

class NotifiedCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let reuseIdentifier = "NotifiedCollectionViewCell"
    let arrData = notifiedDataName
    var size: CGSize!
    var delegate: NotifiedChanagedDelegate?
    var selectData: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(NotifiedCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.backgroundColor = UIColor.clearColor()
        size = self.collectionView!.frame.size
        self.collectionView?.allowsMultipleSelection = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return arrData.count
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return arrData[section].count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as NotifiedCollectionViewCell
        cell.nameLabel.text = arrData[indexPath.section][indexPath.row]
        // Configure the cell
    
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSizeMake((size.width - 60 - 10) / 2, 60)
        case 1:
            return CGSizeMake((size.width - 60 - 40) / 5, 60)
        case 2:
            return CGSizeMake((size.width - 60 - 30) / 4, 60)
        case 3:
            return CGSizeMake((size.width - 60 - 20) / 3, 60)
        case 4:
            return CGSizeMake((size.width - 60 - 30) / 4, 60)
        default:
            return CGSizeMake(60, 60)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(15, 30, 5, 30)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        selectData.append(arrData[indexPath.section][indexPath.row])
        delegate?.notifiedChanaged(self, data: arrData[indexPath.section][indexPath.row])
    }

}
