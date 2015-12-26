//
//  SFPlainTextTableViewController.swift
//  Swift-Files
//
//  Created by Francisco José A. C. Souza on 26/12/15.
//  Copyright © 2015 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class SFPlainTextTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Delegate Methods
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.row) {
        case 0:
            FileHelper.sharedInstance.createPlainTextFileWithName("plain_text")
            self.makeSimpleAlert("Success", message: "File plain_text.txt created succfully!")
            
        case 1...2:
            var fileContent: String?
            
            do {
                fileContent = try FileHelper.sharedInstance.readPlainTextWithName("plain_text")
                
                let options = ["mode": indexPath.row, "file_content": fileContent!] as [String : AnyObject]
                performSegueWithIdentifier("toPlainTextDetail", sender:  options)
            }
            catch {
                self.makeSimpleAlert("Error", message: "File Not Found!!!")
            }
            
        case 3:
            do {
                try FileHelper.sharedInstance.deletePlainTextFileWithName("plain_text")
                self.makeSimpleAlert("Success", message: "File plain_text.txt deleted succfully!")
            }
            catch {
                self.makeSimpleAlert("Error", message: "An error was detected when deleting plain_text.txt.")
            }
            
        default:
            break
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toPlainTextDetail" {
            let destinationViewController = segue.destinationViewController as! SFPlainTextDetailViewController
            
            if let options = sender as? [String : AnyObject],
                let fileContent = options["file_content"] as? String{
                    
                    destinationViewController.bodyText = fileContent
                    
                    if let mode = options["mode"] as? Int where mode == 2 {
                        
                        destinationViewController.editMode = true
                    }
            }
            
        }
    }
}
