//
//  Task.swift
//  HomeCleaning
//
//  Created by Balor on 4/5/18.
//  Copyright © 2018 Balor. All rights reserved.
//

import Foundation

class Task {
    var name: String
    var notifcation: Bool = false
    var info: String = "Info"
    
    init(name: String, info: String) {
        self.name = name
        self.info = info
    }
}