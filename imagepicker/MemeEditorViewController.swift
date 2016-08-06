//
//  MemeEditorViewController.swift
//  imagepicker
//
//  Created by Scott Baumbich on 1/2/16.
//  Copyright © 2016 Scott Baumbich. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    
    
    // Properties
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var cameraButton: UIBarButtonItem!
    @IBOutlet var topTextfield: UITextField!
    @IBOutlet var bottomTextfield: UITextField!
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet var shareMeme: UIBarButtonItem!
    
    let topTextDel = TextDelegate()
    let bottomTextDel = TextDelegate()
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0
    ]
    

    
    // UIActions
    @IBAction func imagePicker(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func cameraImage(sender: AnyObject) {
        let camera = UIImagePickerController()
        camera.delegate = self
        camera.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(camera, animated: true, completion: nil)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        imageView.image = nil
        topTextfield.text = "TOP"
        bottomTextfield.text = "BOTTOM"
        shareMeme.enabled = imageView.image != nil
        dismissViewControllerAnimated(true, completion: {});
    }

    
    @IBAction func shareMeme(sender: AnyObject) {
        let memeImage = generateMemedImage()
        let shareController = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        shareController.completionWithItemsHandler = { activity, success, items, error in

            if activity != nil {
                self.saveMeme()
                print("Meme Saved")
                self.dismissViewControllerAnimated(true, completion: {});
            }
        }
        presentViewController(shareController, animated: true, completion: nil)
    }
    
    
    
    // iOS LifeCycle
    override func viewWillAppear(animated: Bool) {
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
        shareMeme.enabled = imageView.image != nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextAttributes()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    // Helper Methods
    func setTextAttributes() {
        topTextfield.defaultTextAttributes = memeTextAttributes
        topTextfield.textAlignment = .Center
        topTextfield.delegate = topTextDel
        bottomTextfield.defaultTextAttributes = memeTextAttributes
        bottomTextfield.delegate = bottomTextDel
        bottomTextfield.textAlignment = .Center
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextfield.isFirstResponder() {
            view.frame.origin.y =  getKeyboardHeight(notification) * -1
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextfield.isFirstResponder() {
            view.frame.origin.y = 0
        }
    }
    
    func saveMeme() -> MemeImage {
        let meme = MemeImage(topText: topTextfield.text!, bottomText: bottomTextfield.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        return meme
    }
    
    func generateMemedImage() -> UIImage {
        toolBar.hidden = true
        navBar.hidden = true
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        toolBar.hidden = false
        navBar.hidden = false
        
        return memedImage
    }
    
    
    
    // Delegate Methods
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        imageView.image = image
        }
        dismissViewControllerAnimated(true, completion: nil)
    }

}

