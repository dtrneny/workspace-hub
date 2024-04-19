//
//  DateItem.swift
//  workspace-hub
//
//  Created by František on 18.04.2024.
//

import SwiftUI

struct DateItem: View {
    let date: Date
    @Binding var selectedDate: Date
        
    var isSelected: Bool {
        Calendar.current.isDate(date, inSameDayAs: selectedDate)
    }
        
    var body: some View {
            VStack(spacing: 4) {
                Text(date.dayName)
                    .font(.inter(16.0))
                Text("\(date.day)")
                    .font(.inter(16.0))
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 55)
            .foregroundColor(isSelected ? .secondary900 : .grey800)
            .overlay(
                Circle()
                    .fill(.secondary900)
                    .frame(width: 6, height: 6)
                    .opacity(isSelected ? 1 : 0)
                    .padding(.top, 10),
                alignment: .bottom
            )
        }
}
