//
//  GoupRootView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import SwiftUI

struct GroupRootView: View {
    
    @ObservedObject private var coordinator: GroupCoordinator = GroupCoordinator()

    var body: some View {
        TabCoordinatorView(content: {
            TabSectionFactory.viewForGroupTabSection(history: coordinator.history)
                .environmentObject(coordinator)
        }, coordinator: coordinator)
    }
}

#Preview {
    GroupRootView()
}
