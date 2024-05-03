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
            TabSectionFactory.viewForGroupTabSection(coordinator: coordinator)
                .environmentObject(coordinator)
        }, coordinator: coordinator)
        .onDisappear {
            coordinator.replaceAll(with: [.list])
        }
    }
}

#Preview {
    GroupRootView()
}
