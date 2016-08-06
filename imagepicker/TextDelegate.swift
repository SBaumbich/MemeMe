//
//  TopTextDelegate.swift
//  imagepicker
//
//  Created by Scott Baumbich on 1/3/16.
//  Copyright © 2016 Scott Baumbich. All rights reserved.
//

import Foundation
import UIKit

class TextDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text?.uppercaseString == "TOP" {
            textField.text = ""
        } else if textField.text?.uppercaseString == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.text == "" {
            let positionText = textField.placeholder
            textField.text = positionText
        }
    }
}