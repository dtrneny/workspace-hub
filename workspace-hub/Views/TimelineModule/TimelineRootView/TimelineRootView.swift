//
//  TimelineRootView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import SwiftUI

struct TimelineRootView: View {
    
    @ObservedObject private var coordinator: TimelineCoordinator = TimelineCoordinator()
    
    var body: some View {
        TabCoordinatorView(content: {
            TabSectionFactory.viewForTimelineTabSection(history: coordinator.history)
                .environmentObject(coordinator)
        }, coordinator: coordinator)
        .onDisappear {
            coordinator.replaceAll(with: [.timeline])
        }
    }
}

#Preview {
    TimelineRootView()
}
