//
//  FileManagerExtension.swift
//  HomeCleaning
//
//  Created by Sungmin on 4/11/18.
//  Copyright © 2018 Sungmin. All rights reserved.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    static var cachesDirectory: URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
    static var  tempsDirectory: String {
        return NSTemporaryDirectory()
    }
    
    static func filePathInDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory.appendingPathComponent(filename)
    }
    
    static func fileExistsInDocumentsDirectory(filename: String) -> Bool {
        let path = filePathInDocumentsDirectory(filename: filename).path
        
        return FileManager.default.fileExists(atPath: path)
    }
    
    static func deleteFileInDocumentsDirectory(filename: String) {
        let path = filePathInDocumentsDirectory(filename: filename).path
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("File: \(path) was deleted!")
        } catch {
            print("Error: \(error) - For File: \(path)")
        }
    }
    
    static func contentsOfDir(url: URL) -> [String] {
        do {
            if let paths = try FileManager.default.contentsOfDirectory(atPath: url.path) as [String]? {
                return paths
            } else {
                print("none found")
                return [String]() // return empty array of Strings
            }
        } catch {
            print("Error: \(error)")
            return [String]() // return empty array of Strings on error
        }
    }
    
    static func clearDocumentsFolder() {
        let fileManager = FileManager.default
        let docsFolderPath = FileManager.documentsDirectory.path
        
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: docsFolderPath)
            for filePath in filePaths {
                try fileManager.removeItem(atPath: docsFolderPath + "/" + filePath)
            }
            print("Clear Documents folder")
        } catch {
            print("Could not clear Documents folder: \(error)")
        }
    }
}
