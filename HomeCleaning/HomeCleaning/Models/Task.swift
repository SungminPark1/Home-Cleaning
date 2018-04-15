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
    var notification: Bool = false
    var info: String = "Info"
    
    init(name: String, info: String, notification: Bool) {
        self.name = name
        self.info = info
        self.notification = notification
    }
}
