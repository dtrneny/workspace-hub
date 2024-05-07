//
//  CalendarExtensions.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 07.05.2024.
//

import Foundation

extension Calendar {
    func generateDatesBasedOnMonth(from startDate: Date, to endDate: Date) -> [Date] {
        var dates: [Date] = []
        var currentDate = startDate
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = self.date(byAdding: .day, value: 1, to: currentDate)!
        }
        return dates
    }
}
