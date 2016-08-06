//
//  DetailViewController.swift
//  imagepicker
//
//  Created by Scott Baumbich on 1/10/16.
//  Copyright © 2016 Scott Baumbich. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    var meme: MemeImage?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let memeData = meme {
            image.image = memeData.memedImage
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        let edit = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(DetailViewController.editMeme))
        self.navigationItem.rightBarButtonItem = edit
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    
    func editMeme() {
        let memeEditVC = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        presentViewController(memeEditVC, animated: true, completion: nil)
    }
}
