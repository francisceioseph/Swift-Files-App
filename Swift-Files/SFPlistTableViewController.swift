//
//  SFPlistTableViewController.swift
//  Swift-Files
//
//  Created by Francisco José A. C. Souza on 26/12/15.
//  Copyright © 2015 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class SFPlistTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(indexPath.row) {
            
        case 0:
            
            FileHelper.sharedInstance.createPlistFileWithName("list")
            self.makeSimpleAlert("Success", message: "File created successfully!")
            
        case 1...2:
            
            let list: NSMutableArray? = FileHelper.sharedInstance.readPlistWithName("list")
            
            if let list = list {
                let options = ["mode" : indexPath.row, "list": list] as [String : AnyObject]
                performSegueWithIdentifier("toPlistDetails", sender: options)
            }
            else {
                self.makeSimpleAlert("Error", message: "File not found!")
            }
        
        case 3:
            
            do {
                try FileHelper.sharedInstance.deletePlistFileWithName("list")
            }
            catch {
                self.makeSimpleAlert("Error", message: "Error while deleting file")
            }
            
        default:
            
            break
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toPlistDetails" {
            
            let destinationViewController = segue.destinationViewController as! SFPlistDetailTableViewController
            
            if let options = sender as? [String : AnyObject],
                let datasource = options["list"] as? NSMutableArray {
                    
                    destinationViewController.datasource = datasource
                    if let mode = options["mode"] as? Int where mode == 2 {
                        destinationViewController.canEdit = true
                    }
            }
        }
    }

}
