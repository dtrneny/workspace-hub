//
//  TimelineRootView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import SwiftUI

struct TimelineView: View {
    @ObservedObject private var coordinator: TimelineCoordinator = TimelineCoordinator()
    @State private var selectedDate: Date = Date()
    @State private var selectedMonth: Date = {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        return calendar.date(from: components)!
    }()

    var body: some View {
        BaseLayout {
                HStack(alignment: .firstTextBaseline) {
                    ViewTitle(title: "Timeline")
                    
                    Spacer()
                    
                    OperationButton(icon: "line.3.horizontal.decrease") {
                        print("list")
                    }
                    .padding(.trailing, 10)
                    
                    OperationButton(icon: "arrow.counterclockwise") {
                        print("arrow counterclockwise icon")
                    }
                }
                
                DateSwiper(dates: generateDates(for: selectedMonth), itemWidth: 20, selectedDate: $selectedDate, selectedMonth: $selectedMonth)
        }
    }
    
    private func generateDates(for month: Date) -> [Date] {
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month))!
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        
        let dates = calendar.generateDatesBasedOnMonth(from: startOfMonth, to: endOfMonth)
        return dates
    }
}

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

#Preview {
    TimelineView()
}
