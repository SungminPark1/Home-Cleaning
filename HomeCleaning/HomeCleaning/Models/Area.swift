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
        var progressPercent:Float = 0
        if tasks.count > 0 {
            var totalTimePercentRemaining: Float = 0
            for task in tasks {
                totalTimePercentRemaining += Float(task.getRemainingTime() / task.dueTimeInterval)
            }
            
            progressPercent = totalTimePercentRemaining / Float(tasks.count)
        }
        
        return progressPercent
    }
}
