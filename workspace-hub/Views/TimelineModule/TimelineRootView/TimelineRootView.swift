//
//  TimelineRootView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import SwiftUI

struct TimelineRootView: View {
    
    @ObservedObject private var coordinator: TimelineCoordinator = TimelineCoordinator()
    
    @State private var selectedDate: Date = Date()
    @State private var selectedMonth: Date = {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        return calendar.date(from: components)!
    }()
    
    var body: some View {
        TabCoordinatorView(content: {
            TabSectionFactory.viewForTimelineTabSection(history: coordinator.history)
                .environmentObject(coordinator)
        }, coordinator: coordinator)
    }
}

#Preview {
    TimelineRootView()
}
