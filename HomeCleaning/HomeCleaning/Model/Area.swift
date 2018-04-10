//
//  Area.swift
//  HomeCleaning
//
//  Created by Balor on 4/5/18.
//  Copyright © 2018 Balor. All rights reserved.
//

import Foundation

class Area {
    var name: String
    var tasks: Array<Task>
    
    init(name: String, tasks: Array<Task>) {
        self.name = name
        self.tasks = tasks
    }
}
