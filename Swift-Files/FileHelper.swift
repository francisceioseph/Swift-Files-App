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
    
    func readPlistWithName(name: String) -> NSArray? {
        let filePath = self.documentsFolder().stringByAppendingString("/\(name).plist")
        let fileContent = NSArray(contentsOfFile: filePath)
        
        return fileContent
    }
    
    func savePlistFileWithName(name: String, fileContent: NSArray) -> Bool {
        let filePath = self.documentsFolder().stringByAppendingString("/\(name).plist")
        let fileData = NSKeyedArchiver.archivedDataWithRootObject(fileContent)
        
        return fileManager.createFileAtPath(filePath, contents: fileData , attributes: nil)
    }
    
    func deletePlistFileWithName(name: String) throws{
        let filePath = self.documentsFolder().stringByAppendingString("/\(name).plist")
        try fileManager.removeItemAtPath(filePath)
    }

    //MARK: - list files into a documents directory
    
    func listDocumentsFolderContent() throws -> [String]{
        let directoryContents: [String]? = try fileManager.contentsOfDirectoryAtPath(documentsFolder())
        var fileNames: [String] = []
        
        if let directoryContents = directoryContents {
            fileNames = directoryContents.map({ (path:String) -> String in
                path.componentsSeparatedByString("/").last!
            })
        }
        
        return fileNames
    }
    
    private func documentsFolder () -> String{
        let folders = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return folders.first!
    }
}