//
//  Task.swift
//  HomeCleaning
//
//  Created by Balor on 4/5/18.
//  Copyright © 2018 Balor. All rights reserved.
//

import Foundation

class Task: Codable {
    var name: String
    var frequency: Int
    var notification: Bool = false
    var isPaused: Bool = false
    var lastCompletedDate: Date
    var history: [Date] = []
    
    var dueTimeInterval: TimeInterval {
        return TimeInterval(60 * 60 * 24 * frequency)
    }
    
    var isOverdue: Bool {
        var checkOverdue = false
        if getRemainingTime() <= 0 {
            checkOverdue = true
        }
        
        return checkOverdue
    }
    
    init(name: String, frequency: Int, notification: Bool) {
        self.name = name
        self.frequency = frequency
        self.notification = notification
        
        self.lastCompletedDate = Date()
    }
    
    func getRemainingTime() -> Double {
        let timePassed = self.lastCompletedDate.timeIntervalSinceNow
        
        return self.dueTimeInterval + timePassed
    }
    
    func getRemainingTimeString() -> String {
        if isPaused {
            return "Task is paused"
        }
        var timeString = ""
        let timeRemaining = getRemainingTime()
        
        let days = ceil(timeRemaining / (60 * 60 * 24))
        
        if days <= -1 {
            timeString = "Due \(abs(days)) Days ago"
        } else if days <= 0 {
            let hours = round(timeRemaining / (60 * 60) * 10) / 10
            timeString = "Due \(abs(hours)) Hours ago"
        } else if days <= 1 {
            let hours = round(timeRemaining / (60 * 60) * 10) / 10
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
    
    func getHistoryIndexString(index: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        
        return formatter.string(from: history[index])
    }
}
