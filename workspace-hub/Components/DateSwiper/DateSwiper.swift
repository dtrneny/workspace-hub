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
    
    @Binding var selectedDate: Date
    
    @Binding var selectedMonth: Date
        
    @State private var scrollOffset: CGFloat = .zero
    
    @State private var shouldScrollToSelectedDate = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                OperationButton(icon: "chevron.left") {
                    self.selectedMonth = self.previousMonth(from: self.selectedMonth)
                }
                
                Spacer()
                
                Text(monthName(from: selectedMonth))
                    .frame(width: 200)
                
                Spacer()
                
                OperationButton(icon: "chevron.right") {
                    self.selectedMonth = self.nextMonth(from: self.selectedMonth)
                }
                Spacer()
            }
            
            ScrollViewReader { value in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(dates, id: \.self) { date in
                            DateItem(date: date, selectedDate: $selectedDate)
                                .id(date)
                                .onTapGesture {
                                    self.selectedDate = date
                                }
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
//    private func swipeGesture(date: Date) -> some Gesture {
//        DragGesture()
//            .onEnded { value in
//                let threshold: CGFloat = 50
//                if value.translation.width > threshold {
//                    selectPreviousDate()
//                } else if value.translation.width < -threshold {
//                    selectNextDate()
//                }
//            }
//    }
    
//    private func selectPreviousDate() {
//            if let index = dates.firstIndex(of: selectedDate), index > 0 {
//                selectedDate = dates[index - 1]
//            }
//        }
//        
//    private func selectNextDate() {
//        if let index = dates.firstIndex(of: selectedDate), index < dates.count - 1 {
//            selectedDate = dates[index + 1]
//        }
//    }
    
    
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
    
    var dayName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self)
    }
}

struct ContentView: View {
    @State private var selectedDate = Date()
    @State private var selectedMonth = Date()
    
    var body: some View {
        VStack {
            DateSwiper(dates: [], itemWidth: 20, selectedDate: $selectedDate, selectedMonth: $selectedMonth)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
