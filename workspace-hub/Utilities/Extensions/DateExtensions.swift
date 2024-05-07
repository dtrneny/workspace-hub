//
//  DateExtensions.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 07.05.2024.
//

import Foundation

extension Date {
    var day: Int {
        Calendar.current.component(.day, from: self)
    }
    
    var month: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var year: Int {
        Calendar.current.component(.year, from: self)
    }
    
    var dayName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self)
    }
}
