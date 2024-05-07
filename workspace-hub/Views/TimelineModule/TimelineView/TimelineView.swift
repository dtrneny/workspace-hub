//
//  TimelineRootView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import SwiftUI

struct TimelineView: View {
    
    @EnvironmentObject var coordinator: TimelineCoordinator
    
    @StateObject private var viewModel = TimelineViewModel()

    var body: some View {
        BaseLayout {
            HStack(alignment: .firstTextBaseline) {
                DynamicViewTitle(title: DateUtil.monthName(from: viewModel.selectedMonth))
                
                Spacer()
                
                HStack (spacing: 10) {
                    OperationButton(icon: "chevron.left") {
                        viewModel.previousMonth()
                    }
                    
                    OperationButton(icon: "chevron.right") {
                        viewModel.nextMonth()
                    }
                    
                    OperationButton(icon: "arrow.counterclockwise") {
                        viewModel.resetTimeline()
                    }
                }
            }
            
            DateSwiper(
                dates: DateUtil.generateMonthDates(for: viewModel.selectedMonth),
                selectedDate: $viewModel.selectedDate,
                selectedMonth: $viewModel.selectedMonth
            )
        }
    }
}
