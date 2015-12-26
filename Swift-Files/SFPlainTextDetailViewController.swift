//
//  SFPlainTextDetailViewController.swift
//  Swift-Files
//
//  Created by Francisco José A. C. Souza on 26/12/15.
//  Copyright © 2015 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class SFPlainTextDetailViewController: UIViewController {
    var bodyText:String?
    var editMode:Bool?
    
    @IBOutlet weak var fileContentTextView: UITextView!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fileContentTextView.text = self.bodyText
        
        if let editMode = self.editMode where editMode == true {
            self.fileContentTextView.editable = true
            self.saveBarButton.enabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onSaveTap(sender: UIBarButtonItem) {
        FileHelper.sharedInstance.savePlainTextFileWithName("plain_text", fileContent: self.fileContentTextView.text)
    }
}
