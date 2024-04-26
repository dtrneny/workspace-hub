//
//  WorkspaceRootView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import SwiftUI

struct WorkspaceRootView: View {
    
    @ObservedObject private var coordinator: WorkspaceCoordinator = WorkspaceCoordinator()

    var body: some View {
        TabCoordinatorView(content: {
            TabSectionFactory.viewForWorkspaceTabSection(history: coordinator.history)
                .environmentObject(coordinator)
        }, coordinator: coordinator)
    }
}

#Preview {
    WorkspaceRootView()
}
