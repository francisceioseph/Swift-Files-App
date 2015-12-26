//
//  FileHelper.swift
//  Swift-Files
//
//  Created by Francisco José A. C. Souza on 24/12/15.
//  Copyright © 2015 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class FileHelper: NSObject {
    static let sharedInstance = FileHelper()
    
    let fileManager = NSFileManager.defaultManager()
    
    func createPlainTextFileWithName(name: String) -> Bool{
        let filePath = self.documentsFolder().stringByAppendingString("/\(name).txt")
        
        return fileManager.createFileAtPath(filePath, contents: nil , attributes: nil)
    }
    
    func readPlainTextWithName(name: String) throws -> String? {
        let filePath = self.documentsFolder().stringByAppendingString("/\(name).txt")
        let fileContent:String? = try String(contentsOfFile: filePath)
        
        return fileContent
    }
    
    func savePlainTextFileWithName(name: String, fileContent: String) -> Bool {
        
        let filePath = self.documentsFolder().stringByAppendingString("/\(name).txt")
        let fileData = fileContent.dataUsingEncoding(NSUTF8StringEncoding)
        
        return fileManager.createFileAtPath(filePath, contents: fileData , attributes: nil)
    }
    
    func deletePlainTextFileWithName(name: String) throws{
        
        let filePath = self.documentsFolder().stringByAppendingString("/\(name).txt")
        try fileManager.removeItemAtPath(filePath)
    }
    
    //MARK: - Plist Text File

    func createPlistFileWithName(name: String) -> Bool{
        
        let filePath = self.documentsFolder().stringByAppendingString("/\(name).plist")
        
        return fileManager.createFileAtPath(filePath, contents: nil , attributes: nil)
    }
    
    func readPlistWithName(name: String) -> NSMutableArray? {
        
        let filePath = self.documentsFolder().stringByAppendingString("/\(name).plist")
        var fileContent: NSMutableArray?
        
        if self.fileManager.fileExistsAtPath(filePath) {
            
            if let array = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? NSMutableArray{
                
                fileContent = array
            }
            else {
                
                fileContent = NSMutableArray()
            }
        }
        
    
        return fileContent
    }
    
    func savePlistFileWithName(name: String, fileContent: NSMutableArray) -> Bool {
        
        let filePath = self.documentsFolder().stringByAppendingString("/\(name).plist")
        let fileData = NSKeyedArchiver.archivedDataWithRootObject(fileContent)
        
        let result = fileManager.createFileAtPath(filePath, contents: fileData , attributes: nil)
        
        return result
    }
    
    func deletePlistFileWithName(name: String) throws{
        
        let filePath = self.documentsFolder().stringByAppendingString("/\(name).plist")
        try fileManager.removeItemAtPath(filePath)
    }


    
    private func documentsFolder () -> String{
        let folders = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        return folders.first!
    }
}