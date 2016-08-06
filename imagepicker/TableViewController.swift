//
//  TableViewController.swift
//  imagepicker
//
//  Created by Scott Baumbich on 1/10/16.
//  Copyright © 2016 Scott Baumbich. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.memes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        let memeData = delegate.memes[indexPath.row]
        
        cell.textLabel?.text = "\(memeData.topText) \(memeData.bottomText)"
        cell.imageView?.image = memeData.memedImage
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let memeImg = delegate.memes[indexPath.row]
        let detailVC = storyboard!.instantiateViewControllerWithIdentifier("DetailVC") as! DetailViewController
        
        detailVC.meme = memeImg
        
        navigationController!.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        if editingStyle == .Delete {
            delegate.memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}







