//
//  DateSwiper.swift
//  workspace-hub
//
//  Created by František on 18.04.2024.
//

import SwiftUI

struct DateSwiper: View {
    
    let dates: [Date]
            
    @Binding var selectedDate: Date
    @Binding var selectedMonth: Date
                
    var body: some View {
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
                .onChange(of: selectedDate, { oldValue, newValue in
                    value.scrollTo(selectedDate.day, anchor: .center)
                })
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
