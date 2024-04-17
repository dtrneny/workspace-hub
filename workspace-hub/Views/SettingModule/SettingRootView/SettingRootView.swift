//
//  SettingRootView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import SwiftUI

struct SettingRootView: View {
    @ObservedObject private var coordinator: SettingCoordinator = SettingCoordinator()

    var body: some View {
        TabCoordinatorView(content: {
            TabSectionFactory.viewForSettingTabSection(history: coordinator.history)
                .environmentObject(coordinator)
        }, coordinator: coordinator)
    }
}

#Preview {
    SettingRootView()
}
