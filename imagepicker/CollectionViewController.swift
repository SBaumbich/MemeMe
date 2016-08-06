//
//  CollectionViewController.swift
//  imagepicker
//
//  Created by Scott Baumbich on 1/10/16.
//  Copyright © 2016 Scott Baumbich. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CollectionViewCell"

class CollectionViewController: UICollectionViewController {
    
    
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
    
    
    override func viewWillAppear(animated: Bool) {
        collectionView!.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFlowControll()
    }

    
    
    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate.memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        
        let meme = delegate.memes[indexPath.row]
        cell.imageView.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let memeData = delegate.memes[indexPath.row]
        let detailVC = storyboard!.instantiateViewControllerWithIdentifier("DetailVC") as! DetailViewController
        detailVC.meme = memeData
        
        navigationController!.pushViewController(detailVC, animated: true)
    }
    
    func setFlowControll () {
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
}
