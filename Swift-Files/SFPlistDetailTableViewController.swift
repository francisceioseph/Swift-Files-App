//
//  SFPlistDetailTableViewController.swift
//  Swift-Files
//
//  Created by Francisco José A. C. Souza on 26/12/15.
//  Copyright © 2015 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class SFPlistDetailTableViewController: UITableViewController {
    
    var datasource: NSMutableArray?
    var canEdit: Bool = false

    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.addButton.enabled = self.canEdit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfRows = 0;
        
        if let datasource = self.datasource {
            numberOfRows = datasource.count
        }
        
        return numberOfRows
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return self.canEdit
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = datasource?[indexPath.row] as? String
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            if let datasource = self.datasource {
                
                datasource.removeObjectAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
    
    @IBAction func onAddTap(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add", message: "Insert the Text to be added to Plist", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let saveAction   = UIAlertAction(title: "Save", style: .Default) { (_) -> Void in
            
            let inputTextField = alert.textFields?.first
            
            if let datasource = self.datasource,
                let text = inputTextField?.text {
                    
                    datasource.addObject(text)
                    FileHelper.sharedInstance.savePlistFileWithName("list", fileContent: datasource)
                    
                    self.tableView.reloadData()
            }
            
        }
        
        alert.addTextFieldWithConfigurationHandler { (textfield) -> Void in
            textfield.placeholder = "Type something"
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
