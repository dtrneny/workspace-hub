//
//  TimelineViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 07.05.2024.
//

import SwiftUI

final class TimelineViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .idle
    
    private var today: Date = Date()
    
    @Published var selectedDate: Date = Date()
    @Published var selectedMonth: Date = {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        return calendar.date(from: components)!
    }()
    
    func resetTimeline () {
        selectedDate = today
        
        selectedMonth = {
            let calendar = Calendar.current
            let currentDate = Date()
            let components = calendar.dateComponents([.year, .month], from: currentDate)
            return calendar.date(from: components)!
        }()
    }
    
    func nextMonth () {
        selectedMonth = DateUtil.nextMonth(from: selectedMonth)
        
        if let firstDay = firstDateOfMonth(year: selectedMonth.year, month: selectedMonth.month) {
            selectedDate = firstDay
        }
    }
    
    func previousMonth () {
        selectedMonth = DateUtil.previousMonth(from: selectedMonth)
    }
    
    func firstDateOfMonth(year: Int, month: Int) -> Date? {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = 1
        return calendar.date(from: components)
    }
}

