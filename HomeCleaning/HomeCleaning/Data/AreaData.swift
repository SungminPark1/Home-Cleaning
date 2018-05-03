//
//  AreaData.swift
//  HomeCleaning
//
//  Created by Sungmin on 4/5/18.
//  Copyright © 2018 Sungmin. All rights reserved.
//

import Foundation

class AreaData {
    static let sharedData = AreaData()
    var areas = [Area]()
    
    private init() {
        
    }
}
