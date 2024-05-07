//
//  DateUtil.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 07.05.2024.
//

import Foundation

final class DateUtil {
    
    static func generateMonthDates(for month: Date) -> [Date] {
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month))!
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        
        let dates = calendar.generateDatesBasedOnMonth(from: startOfMonth, to: endOfMonth)
        return dates
    }
    
    static func monthName(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM yyyy")
        return dateFormatter.string(from: date)
    }
    
    static func previousMonth(from date: Date) -> Date {
        Calendar.current.date(byAdding: .month, value: -1, to: date)!
    }
    
    static func nextMonth(from date: Date) -> Date {
        Calendar.current.date(byAdding: .month, value: 1, to: date)!
    }
    
    static func isAfterByAtLeast(date2: Date, date1: Date, atlest: Int) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: date1, to: date2)
        
        if let minutes = components.minute {
            return minutes >= atlest
        } else {
            return false
        }
    }
    
    static func formatTimespan(from: Date, to: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let fromTime = dateFormatter.string(from: from)
        let toTime = dateFormatter.string(from: to)
        
        return "\(fromTime) - \(toTime)"
    }
    
    static func formatTimespanWithDates(from: Date, to: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy, HH:mm"
        
        let fromDateFormatted = dateFormatter.string(from: from)
        let toDateFormatted = dateFormatter.string(from: to)
        
        return "\(fromDateFormatted) - \(toDateFormatted)"
    }
}
