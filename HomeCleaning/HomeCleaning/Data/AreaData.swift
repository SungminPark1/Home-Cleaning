//
//  AreaData.swift
//  HomeCleaning
//
//  Created by Balor on 4/5/18.
//  Copyright © 2018 Balor. All rights reserved.
//

import Foundation

class AreaData {
    static let sharedData = AreaData()
    var areas = [Area]()
    
    private init() {
        
    }
}
