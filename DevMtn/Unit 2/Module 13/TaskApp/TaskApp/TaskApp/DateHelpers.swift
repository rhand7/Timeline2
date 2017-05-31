//
//  DateHelpers.swift
//  TaskApp
//
//  Created by handje on 4/5/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import CoreData

extension Date {
    
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: self)
    }
    
}
