//
//  RepeatCollectionViewController.swift
//  collectionView
//
//  Created by bain on 15-6-7.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit

protocol RepeatChanagedDelegate: NSObjectProtocol{
    func repeatChanaged(controller: RepeatCollectionViewController, data: String)
}

class RepeatCollectionViewController: UICollectionViewController {
    let reuseIdentifier = "RepeatCollectionViewCell"
    let arrData = repeatDataName
    var size: CGSize!
    var delegate: RepeatChanagedDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(NotifiedCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        size = self.collectionView!.frame.size
        collectionView?.backgroundColor = UIColor.clearColor()
//        collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.allowsMultipleSelection = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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
            return CGSizeMake((size.width - 60 - 40) / 5, 60)
        case 1:
            return CGSizeMake((size.width - 60 - 30) / 4, 60)
        default:
            return CGSizeMake(60, 60)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(15, 30, 5, 30)
    }
    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        delegate?.repeatChanaged(self, data: arrData[indexPath.section][indexPath.row])
    }
    
}
