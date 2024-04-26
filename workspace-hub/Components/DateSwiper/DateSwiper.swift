//
//  DateSwiper.swift
//  workspace-hub
//
//  Created by František on 18.04.2024.
//

import SwiftUI

struct DateSwiper: View {
    let dates: [Date]
    
    let itemWidth: CGFloat
    
    let initialDate: Date
    
    @Binding var selectedDate: Date
    
    @Binding var selectedMonth: Date
            
    @State private var shouldScrollToSelectedDate = false
    
    var body: some View {
        VStack {
            HStack() {
                Spacer()
                OperationButton(icon: "chevron.left") {
                    self.selectedMonth = self.previousMonth(from: self.selectedMonth)
                }
                
                Spacer()
                
                Text(monthName(from: selectedMonth))
                    .frame(width: 200)
                    .foregroundStyle(.secondary900)
                
                Spacer()
                
                OperationButton(icon: "chevron.right") {
                    self.selectedMonth = self.nextMonth(from: self.selectedMonth)
                }
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { value in
                    HStack(spacing: 20) {
                        ForEach(dates, id: \.self) { date in
                            DateItem(date: date, selectedDate: $selectedDate)
                                .id(date.day)
                                .onTapGesture {
                                    selectedDate = date
                                }
                        }
                    }
                    .onAppear {
                        value.scrollTo(selectedDate.day, anchor: .center)
                    }
                    .onChange(of: selectedMonth) { oldValue, newValue in
                        if (selectedDate.month == newValue.month) {
                            value.scrollTo(selectedDate.day, anchor: .center)
                        } else {
                            value.scrollTo(1, anchor: .center)
                        }
                    }
                }
            }
        }
    }
    
    private func monthName(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    private func previousMonth(from date: Date) -> Date {
        Calendar.current.date(byAdding: .month, value: -1, to: date)!
    }
        
    private func nextMonth(from date: Date) -> Date {
        Calendar.current.date(byAdding: .month, value: 1, to: date)!
    }
    
}

extension Date {
    var day: Int {
        Calendar.current.component(.day, from: self)
    }
    
    var month: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var dayName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self)
    }
}
