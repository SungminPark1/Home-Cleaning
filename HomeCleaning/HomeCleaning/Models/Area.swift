//
//  Area.swift
//  HomeCleaning
//
//  Created by Balor on 4/5/18.
//  Copyright © 2018 Balor. All rights reserved.
//

import Foundation

class Area : Codable {    
    var name: String
    var tasks: Array<Task>
    
    init(name: String, tasks: Array<Task>) {
        self.name = name
        self.tasks = tasks
    }
    
    func getProgressPercent() -> Float {
        var totalTaskWeight: Int = 0
        var progressPercent: Float = 0
        if tasks.count > 0 {
            var totalTimePercentRemaining: Float = 0
            
            // loop through task and only count task that are not paused
            for task in tasks {
                if task.isPaused == false {
                    var taskTimePercent = Float(task.getRemainingTime() / task.dueTimeInterval)
                
                    // prevent overdue tasks from give negative percent value
                    if taskTimePercent <= 0 {
                        taskTimePercent = 0
                    }
                
                    totalTaskWeight += task.priorityWeight
                    totalTimePercentRemaining += taskTimePercent * Float(task.priorityWeight)
                }
            }
            
            progressPercent = totalTimePercentRemaining / Float(totalTaskWeight)
        }
        
        return progressPercent
    }
}
