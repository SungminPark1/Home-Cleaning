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
    var frequency: Int = 14
    var notification: Bool = false
    var isPaused: Bool = false
    var history: [Date] = []
    
    init(name: String, frequency: Int, notification: Bool) {
        self.name = name
        self.frequency = frequency
        self.notification = notification
    }
}
