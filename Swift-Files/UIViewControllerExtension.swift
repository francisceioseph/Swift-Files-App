//
//  UIViewControllerExtension.swift
//  Swift-Files
//
//  Created by Francisco José A. C. Souza on 26/12/15.
//  Copyright © 2015 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

extension UIViewController {
    func makeSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

