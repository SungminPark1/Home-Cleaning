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
    
    var frequency: Int
    var dueTimeInterval: TimeInterval {
        return TimeInterval(60 * 60 * 24 * frequency)
    }
    
    var notification: Bool = false
    var isPaused: Bool = false
    
    var lastCompletedDate: Date
    
    var history: [Date] = []
    
    init(name: String, frequency: Int, notification: Bool) {
        self.name = name
        self.frequency = frequency
        self.notification = notification
        
        self.lastCompletedDate = Date()
    }
    
    func getRemainingTime() -> String {
        var timeString = ""
        let timePassed = self.lastCompletedDate.timeIntervalSinceNow
        let timeRemaining = self.dueTimeInterval + timePassed
        
        let days = ceil(timeRemaining / (60 * 60 * 24))
        
        if days <= 1 {
            let hours = ceil(timeRemaining / (60 * 60))
            timeString = "Due in \(hours) Hours"
        } else if days > 1 {
            timeString = "Due in \(days) Days"
        }
        
        return timeString
    }
    
    func taskCompleted() {
        lastCompletedDate = Date()
        
        history.append(lastCompletedDate)
    }
    
    func taskReset() {
        lastCompletedDate = Date()
    }
}
